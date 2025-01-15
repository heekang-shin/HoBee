package kh.pr.hobee.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pr.hobee.dao.ReviewDAO;
import kh.pr.hobee.vo.ReviewVO;
import kh.pr.hobee.vo.UsersVO;

@Controller
public class RatingController {

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	ReviewDAO review_dao;

	public void setReview_dao(ReviewDAO review_dao) {
		this.review_dao = review_dao;
	}

	@ResponseBody
	@RequestMapping("Review.do")
	public String insertReview(HttpSession session, String rating, String content, Model model) {
		// 세션에 담아둔 이름 갖고오기
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		
		if(user == null) {
			return "error";
		}
		
		String username = user.getUser_name();

		// 로그 확인
		System.out.println("작성자: " + username);
		System.out.println("별점: " + rating);
		System.out.println("내용: " + content);

		ReviewVO review = new ReviewVO();
		review.setUser_name(username);
		review.setRating(Integer.parseInt(rating));
		review.setContent(content);

		review_dao.insertReview(review);
		// 리뷰 목록 조회
		List<ReviewVO> reviews = review_dao.reviewList();

		// 평균 평점과 리뷰 개수 계산
		double totalRating = 0;
		int reviewCount = reviews.size();
		for (ReviewVO r : reviews) {
			totalRating += r.getRating();
		}
		double averageRating = (reviewCount == 0) ? 0 : totalRating / reviewCount;

		// 문자열로 평균 평점과 리뷰 개수를 반환
		return averageRating + "," + reviewCount;

	}
}
