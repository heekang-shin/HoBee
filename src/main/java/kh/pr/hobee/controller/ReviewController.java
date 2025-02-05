package kh.pr.hobee.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kh.pr.hobee.dao.ReviewDAO;
import kh.pr.hobee.vo.ReviewVO;
import kh.pr.hobee.vo.UsersVO;

@Controller
public class ReviewController {

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	ReviewDAO review_dao;

	public void setReview_dao(ReviewDAO review_dao) {
		this.review_dao = review_dao;
	}

	// 리뷰
	@RequestMapping("Review.do")
	public String insertReview(String rating, String reviewContent, String hbidx, Model model,
			HttpSession httpSession) {
		// 로그 추가: 입력 값 확인
		System.out.println("[디버그] 전달받은 별점 값: " + rating);
		System.out.println("[디버그] 전달받은 리뷰 내용: " + reviewContent);
		System.out.println("[디버그] 전달받은 게시글 ID: " + hbidx);
		// 세션에 hbidx 값 저장
		session.setAttribute("hbidx", hbidx);
		// 세션에서 사용자 정보 확인
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		if (user == null) {
			System.out.println("[디버그] 사용자가 로그인하지 않았습니다. 로그인 페이지로 리다이렉트");
			return "redirect:/login_form.do";
		}

		String username = user.getUser_name();
		String userId = user.getId();
		System.out.println("[디버그] 로그인된 사용자 이름: " + username);

		// 리뷰 객체 생성 및 저장
		ReviewVO review = new ReviewVO();
		review.setUser_name(username);
		review.setRating(Integer.parseInt(rating));
		review.setContent(reviewContent);
		review.setHb_idx(Integer.parseInt(hbidx));
		review.setUser_id(userId);

		review_dao.insertReview(review);
		System.out.println("[디버그] 리뷰가 데이터베이스에 성공적으로 저장되었습니다.");

		// 특정 hb_idx에 해당하는 리뷰 목록 조회
		List<ReviewVO> reviews = review_dao.get_reviewList(Integer.parseInt(hbidx));
		System.out.println("[디버그] 조회된 리뷰 개수: " + reviews.size());

		// 평균 평점 계산
		double totalRating = 0;
		for (ReviewVO r : reviews) {
			totalRating += r.getRating();
		}
		double averageRating = (reviews.size() == 0) ? 0 : totalRating / reviews.size();

		// 평균 평점 포맷팅 (소수점 한 자리로)
		String formattedAverageRating = String.format("%.1f", averageRating);

		System.out.println("[디버그] 평균 평점: " + formattedAverageRating);

		// 모델에 저장
		model.addAttribute("reviews", reviews);
		model.addAttribute("formattedAverageRating", formattedAverageRating); // 포맷된 값을 전달
		model.addAttribute("reviewCount", reviews.size());

		// 특정 게시글 조회라서 hbidx값을 같이 갖고 넘겨야함
		return "redirect:/hobee_detail.do?hbidx=" + hbidx;

	}

	// 리뷰 전체 보기 페이지
	@RequestMapping("review_detail.do")
	public String reviewDetail(int hbidx, Model model) {
		// 디버깅용 hbidx 값 출력
		System.out.println("[디버그] 전달받은 hbidx 값: " + hbidx);

		// 특정 hbidx의 리뷰만 가져오기
		List<ReviewVO> reviews = review_dao.get_reviewList(hbidx);
		// 디버깅
		System.out.println("토탈 리뷰 갯수 : " + reviews.size());

		// 모델에 데이터 저장
		model.addAttribute("reviews", reviews);
		model.addAttribute("hbidx", hbidx);
		model.addAttribute("reviewCount", reviews.size());
		// 단순 화면 전환
		return kh.pr.hobee.common.Common.VIEW_PATH + "detail/review_detail.jsp";
	}

	// ✅ 리뷰 삭제 처리 (일반 사용자 & 관리자 & 호스트)
	@RequestMapping("deleteReview.do")
	public String deleteReview(int[] review_id, int hbidx, RedirectAttributes redirectAttributes) {
	    UsersVO user = (UsersVO) session.getAttribute("loggedInUser");

	    // ✅ 1️ 로그인 체크
	    if (user == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/review_detail.do?hbidx=" + hbidx;
	    }

	    String userLevel = user.getLv(); // 사용자의 권한 (일반, 호스트, 관리자 등)
	    String userId = user.getId(); // 현재 로그인한 사용자 ID

	    // ✅ 2️ 해당 모임을 생성한 호스트의 user_id 조회
	    String hostUserId = review_dao.getHostUserIdByHbidx(hbidx);
	    System.out.println("[디버그] 모임 작성자 ID: " + hostUserId);
	    System.out.println("[디버그] 현재 로그인한 사용자 ID: " + userId);

	    // ✅ 3️ 중복된 리뷰 ID 제거 (리스트에서 중복 제거)
	    List<Integer> uniqueReviewIds = new ArrayList<Integer>();
	    for (int id : review_id) {
	        if (!uniqueReviewIds.contains(id)) {
	            uniqueReviewIds.add(id);
	        }
	    }

	    System.out.println("[디버그] 중복 제거 후 삭제 요청된 리뷰 ID 목록: " + uniqueReviewIds);

	    int deletedCount = 0; // 실제 삭제된 리뷰 개수 확인을 위한 변수

	    // ✅ 4️ 리뷰 삭제 또는 삭제 요청 로직 수행
	    for (int id : uniqueReviewIds) {
	        ReviewVO review = review_dao.getReviewById(id);

	        // ✅ 4-1️ 리뷰 ID가 DB에 존재하는지 확인
	        if (review == null) {
	            System.out.println("[디버그] 리뷰 ID: " + id + " -> DB에 존재하지 않음");
	            continue;
	        }

	        System.out.println("[디버그] 현재 리뷰 ID: " + id + ", 작성자: " + review.getUser_id());

	        // ✅ 4-2️ 일반 사용자는 본인 리뷰만 삭제 가능
	        if ("일반".equals(userLevel)) {
	            if (review.getUser_id().equals(userId)) {
	                int result = review_dao.delete(id);
	                System.out.println("[디버그] 일반 유저 리뷰 삭제 결과: " + result);
	                deletedCount += result;
	            } else {
	                redirectAttributes.addFlashAttribute("errorMessage", "본인이 작성한 리뷰만 삭제할 수 있습니다.");
	                return "redirect:/review_detail.do?hbidx=" + hbidx;
	            }
	        }
	        // ✅ 4-3️ 관리자 및 총괄관리자는 언제든 즉시 삭제 가능
	        else if ("관리자".equals(userLevel) || "총괄관리자".equals(userLevel)) {
	            int result = review_dao.delete(id);
	            System.out.println("[디버그] 관리자 리뷰 삭제 결과: " + result);
	            deletedCount += result;
	        }
	        // ✅ 4-4️ 호스트의 경우 처리 (삭제 요청 vs 즉시 삭제)
	        else if ("호스트".equals(userLevel)) {
	            // ✅ 4-4-1️ 호스트 본인이 작성한 리뷰는 즉시 삭제 가능
	            if (review.getUser_id().equals(userId)) { 
	                int result = review_dao.delete(id);
	                System.out.println("[디버그] 호스트 본인 리뷰 삭제 결과: " + result);
	                deletedCount += result;
	            } 
	         // ✅ 4-4-2️ 다른 호스트의 모임이면 삭제 요청 불가능
	            else if (Integer.parseInt(hostUserId) != user.getUser_Id()) { 
	                System.out.println("[디버그] 삭제 요청 불가 - 모임 작성자가 아님: 로그인한 ID = " + userId + ", 모임 개설자 ID = " + hostUserId);
	                redirectAttributes.addFlashAttribute("errorMessage", "해당 모임을 작성한 호스트만 리뷰 삭제 요청을 할 수 있습니다.");
	                return "redirect:/review_detail.do?hbidx=" + hbidx;
	            }

	            // ✅ 4-4-3️ 모임 개설자는 삭제 요청 가능 (이미 요청된 경우 중복 방지)
	            else { 
	                if (review_dao.isDeleteRequestExists(id)) {
	                    System.out.println("[디버그] 호스트 이미 삭제 요청이 존재하는 리뷰: review_id = " + id);
	                    continue;
	                }

	                System.out.println("[디버그] 호스트가 리뷰 삭제 요청 생성: review_id = " + id);
	                ReviewVO deleteRequest = new ReviewVO();
	                deleteRequest.setReview_id(id);
	                deleteRequest.setRequested_by(userId);
	                deleteRequest.setHb_idx(hbidx);
	                deleteRequest.setRequest_status("대기");

	                review_dao.insertDeleteRequest(deleteRequest);
	            }

	        }
	    }

	    // ✅ 5️ 삭제 성공 여부 메시지 설정
	    if (deletedCount > 0) {
	        redirectAttributes.addFlashAttribute("message", "선택된 리뷰가 성공적으로 삭제되었습니다.");
	    } else {
	        redirectAttributes.addFlashAttribute("message", "리뷰 삭제에 실패했습니다.");
	    }

	    return "redirect:/review_detail.do?hbidx=" + hbidx;
	}



	// 관리자 리뷰 삭제 요청 목록 보기
	@RequestMapping("/admin_review_detail.do")
	public String adminReviewDetail(Model model) {

		// '대기' 상태의 삭제 요청 목록 조회
		List<ReviewVO> pendingReviews = review_dao.getPendingDeleteRequests();

		// 디버깅 로그
		System.out.println("[디버그] 삭제 요청된 리뷰 개수: " + pendingReviews.size());

		// 모델에 데이터 추가
		model.addAttribute("deleteRequests", pendingReviews);

		return kh.pr.hobee.common.Common.VIEW_PATH + "detail/admin_review_detail.jsp"; // JSP 페이지로 이동
	}

	// ✅ 삭제 요청 승인 (관리자)
	@RequestMapping("approveDeleteRequest.do")
	public String approveDeleteRequest(int review_id, RedirectAttributes redirectAttributes) {
		if (!checkAdminAccess()) {
			return "redirect:/admin_review_detail.do";
		}

		// 1️ 리뷰 테이블에서 삭제
		int res = review_dao.delete(review_id);

		if (res > 0) {
			// 2️ 삭제 요청 테이블에서 해당 요청 제거
			review_dao.deleteDeleteRequest(review_id);

			redirectAttributes.addFlashAttribute("message", "리뷰 삭제가 승인되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("errorMessage", "리뷰 삭제 승인에 실패하였습니다.");
		}

		return "redirect:/admin_review_detail.do"; // ✅ 수정된 리다이렉트 경로
	}

	// ✅ 삭제 요청 거절 (관리자)
	@RequestMapping("rejectDeleteRequest.do")
	public String rejectDeleteRequest(int review_id, RedirectAttributes redirectAttributes) {
		if (!checkAdminAccess()) {
			return "redirect:/adminReviewRequests.do";
		}

		review_dao.updateDeleteRequestStatus(review_id, "거절");
		redirectAttributes.addFlashAttribute("message", "리뷰 삭제 요청이 거절되었습니다.");

		return "redirect:/admin_review_detail.do"; // ✅ 수정된 리다이렉트 경로
	}

	// 중복체크 관리자 권한
	private boolean checkAdminAccess() {
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");

		if (user == null) {
			return false;
		}

		String userLevel = user.getLv();
		return "관리자".equals(userLevel) || "총괄관리자".equals(userLevel);
	}
	// 작성한 리뷰
	@RequestMapping("MyReviews.do")
	public String myReviewsAndDelete(Model model) {
	    UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
	    if (user == null) {
	        model.addAttribute("errorMessage", "로그인이 필요합니다.");
	        return kh.pr.hobee.common.Common.VIEW_PATH + "login/login_form.jsp"; // 로그인 페이지로 리다이렉트
	    }

	    String userId = user.getId();
	    
	    // 리뷰 목록 조회 (모임명 포함)
	    List<ReviewVO> myReviews = review_dao.getReviewsByUserId(userId); 
	    
	    if (myReviews != null && !myReviews.isEmpty()) {
	        model.addAttribute("reviews", myReviews);
	        model.addAttribute("reviewCount", myReviews.size());
	    } else {
	        model.addAttribute("errorMessage", "작성한 리뷰가 없습니다.");
	    }

	    return kh.pr.hobee.common.Common.VIEW_PATH + "detail/my_review.jsp"; // my_review.jsp로 이동
	}

	  @RequestMapping("delmyReview.do")
	    public String deleteMyReviews(HttpServletRequest request, RedirectAttributes redirectAttributes) {
	        UsersVO user = (UsersVO) session.getAttribute("loggedInUser");

	        // ✅ 로그인 체크
	        if (user == null) {
	            return "redirect:/login_form.do";
	        }

	        // ✅ 삭제할 리뷰 ID 가져오기
	        String[] reviewIdArray = request.getParameterValues("review_id");
	        if (reviewIdArray == null || reviewIdArray.length == 0) {
	            return "redirect:/MyReviews.do";
	        }

	        // ✅ ReviewDAO의 delete() 메서드 사용하여 삭제
	        for (String id : reviewIdArray) {
	            review_dao.delete(Integer.parseInt(id));
	        }

	        return "redirect:/MyReviews.do";
	    }


}
