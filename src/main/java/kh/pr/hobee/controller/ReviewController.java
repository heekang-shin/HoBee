package kh.pr.hobee.controller;

import java.util.Arrays;
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

	@RequestMapping("deleteReview.do")
	public String deleteReview(int[] review_id, int hbidx, RedirectAttributes redirectAttributes) {
		// 세션에서 사용자 정보 확인
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		if (user == null) {
			redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
			return "redirect:/login_form.do";
		}

		// 사용자 레벨 확인
		String userLevel = user.getLv(); // "일반", "호스트", "관리자", "총괄관리자"
		String userId = user.getId(); // 현재 로그인한 사용자 ID
		System.out.println("[디버그] 로그인한 사용자 레벨: " + userLevel);
		System.out.println("[디버그] 로그인한 사용자 ID: " + userId);

		if (review_id == null || review_id.length == 0) {
			redirectAttributes.addFlashAttribute("message", "삭제할 리뷰를 선택하세요.");
			return "redirect:/review_detail.do?hbidx=" + hbidx;
		}

		int deletedCount = 0;
		for (int id : review_id) {
			if ("일반".equals(userLevel)) {
				ReviewVO review = review_dao.getReviewById(id); // 특정 리뷰 조회
				if (review != null && review.getUser_id() != null && review.getUser_id().equals(userId)) {
					int res = review_dao.delete(id);
					if (res > 0) {
						deletedCount++;
						System.out.println("[디버그] 본인 리뷰 삭제 성공: review_id = " + id);
					} else {
						System.out.println("[디버그] 본인 리뷰 삭제 실패: review_id = " + id);
					}
				} else {
					System.out.println("[디버그] 본인이 작성하지 않은 리뷰입니다: review_id = " + id);
					redirectAttributes.addFlashAttribute("errorMessage", "본인이 작성한 리뷰만 삭제할 수 있습니다.");
					return "redirect:/review_detail.do?hbidx=" + hbidx;
				}
			} else if ("호스트".equals(userLevel)) {
				// 호스트일 경우 삭제 요청 메시지를 추가
				redirectAttributes.addFlashAttribute("infoMessage", "리뷰 삭제를 요청하겠습니까?");
				return "redirect:/review_detail.do?hbidx=" + hbidx; // 적절한 경로로 리다이렉트
			} else if ("관리자".equals(userLevel) || "총괄관리자".equals(userLevel)) {
				int res = review_dao.delete(id);
				if (res > 0) {
					deletedCount++;
					System.out.println("[디버그] 관리자/총괄관리자 리뷰 삭제 성공: review_id = " + id);
				} else {
					System.out.println("[디버그] 관리자/총괄관리자 리뷰 삭제 실패: review_id = " + id);
				}
			}
		}

		if (deletedCount > 0) {
			redirectAttributes.addFlashAttribute("message", "선택된 리뷰가 성공적으로 삭제되었습니다.");
		} else if ("호스트".equals(userLevel)) {
			redirectAttributes.addFlashAttribute("message", "리뷰 삭제 요청이 접수되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "리뷰 삭제에 실패했습니다.");
		}

		return "redirect:/review_detail.do?hbidx=" + hbidx;
	}

	@RequestMapping("MyReviews.do")
	public String myReviewsAndDelete(int[] review_id, Model model, int hbidx) {
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		if (user == null) {
			model.addAttribute("errorMessage", "로그인이 필요합니다.");
			return kh.pr.hobee.common.Common.VIEW_PATH + "login/login_form.jsp"; // 로그인 페이지로 리다이렉트
		}

		String userId = user.getId();
		List<ReviewVO> myReviews = review_dao.getReviewsByUserId(userId); // 본인 리뷰 조회

		if (myReviews != null && !myReviews.isEmpty()) {
			model.addAttribute("reviews", myReviews);
			model.addAttribute("reviewCount", myReviews.size());
		} else {
			model.addAttribute("errorMessage", "작성한 리뷰가 없습니다.");
		}
		model.addAttribute("hbidx", hbidx);
		return kh.pr.hobee.common.Common.VIEW_PATH + "detail/my_review.jsp"; // my_review.jsp로 이동
	}

	@RequestMapping("delmyReview.do")
	public String delmyReview(int[] review_id, int hbidx, Model model) {
		System.out.println("[디버그] 전달받은 hbidx: " + hbidx);
		System.out.println("[디버그] 전달받은 review_id: " + Arrays.toString(review_id));

		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		if (user == null) {
			model.addAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/login_form.do";
		}

		String userId = user.getId();
		int deletedCount = 0;

		if (review_id != null && review_id.length > 0) {
			for (int id : review_id) {
				ReviewVO review = review_dao.getReviewById(id);
				if (review != null && review.getUser_id().equals(userId)) {
					deletedCount += review_dao.delete(id);
				}
			}
		}

		if (deletedCount > 0) {
			model.addAttribute("successMessage", "선택한 리뷰가 성공적으로 삭제되었습니다.");
		} else {
			model.addAttribute("errorMessage", "삭제할 리뷰를 선택하거나 권한이 없습니다.");
		}

		return "redirect:/MyReviews.do?hbidx=" + hbidx;
	}

}