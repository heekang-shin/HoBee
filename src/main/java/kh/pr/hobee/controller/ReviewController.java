package kh.pr.hobee.controller;

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

	@RequestMapping("Review.do")
	public String insertReview(String rating, String reviewContent, String hbidx, Model model) {
		// 로그 추가: 입력 값 확인
		System.out.println("[디버그] 전달받은 별점 값: " + rating);
		System.out.println("[디버그] 전달받은 리뷰 내용: " + reviewContent);
		System.out.println("[디버그] 전달받은 게시글 ID: " + hbidx);

		// 세션에서 사용자 정보 확인
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		if (user == null) {
			System.out.println("[디버그] 사용자가 로그인하지 않았습니다. 로그인 페이지로 리다이렉트");
			return "redirect:/login_form.do";
		}

		String username = user.getUser_name();
		System.out.println("[디버그] 로그인된 사용자 이름: " + username);

		// 리뷰 객체 생성 및 저장
		ReviewVO review = new ReviewVO();
		review.setUser_name(username);
		review.setRating(Integer.parseInt(rating));
		review.setContent(reviewContent);
		review.setHb_idx(Integer.parseInt(hbidx));

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
	    // 디버깅 로그
	    System.out.println("[디버그] 전달받은 review_id 리스트: " + java.util.Arrays.toString(review_id));
	    System.out.println("[디버그] 전달받은 hbidx: " + hbidx);

	    if (review_id == null || review_id.length == 0) {
	        redirectAttributes.addFlashAttribute("message", "리뷰 삭제에 필요한 데이터가 없습니다.");
	        return "redirect:/review_detail.do?hbidx=" + hbidx;
	    }

	    // 리뷰 삭제 처리
	    int deletedCount = 0;
	    for (int id : review_id) {
	        int res = review_dao.delete(id);
	        if (res > 0) {
	            deletedCount++;
	        }
	    }

	    // 결과 메시지 설정
	    if (deletedCount > 0) {
	        redirectAttributes.addFlashAttribute("message", "선택된 리뷰가 성공적으로 삭제되었습니다.");
	    } else {
	        redirectAttributes.addFlashAttribute("message", "리뷰 삭제에 실패했습니다.");
	    }

	    // 삭제 후 리다이렉트
	    return "redirect:/review_detail.do?hbidx=" + hbidx;
	}


}