package kh.pr.hobee.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.dao.InvenDAO;
import kh.pr.hobee.dao.ReviewDAO;
import kh.pr.hobee.vo.CategoryVO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.ReviewVO;

@Controller
public class InvenController {

	InvenDAO inven_dao;

	public void setInven_dao(InvenDAO inven_dao) {
		this.inven_dao = inven_dao;
	}

	ReviewDAO review_dao;

	public void setReview_dao(ReviewDAO review_dao) {
		this.review_dao = review_dao;
	}

	@RequestMapping("/select_list.do")
	public String selectlist(Model model, int category, String arr) {

		// 모임 목록의 정렬 방식의 초기값을 최신순으로 설정
		String sel = "new";

		// 전달 받은 모임 목록 정렬 방식이 null이 아닐경우
		if (arr != null) {
			sel = arr;
		}

		List<CategoryVO> cate_list = inven_dao.selectInven(category); // 카테고리 하위의 세부 카테고리 받아오기
		List<HobeeVO> hobee_list = null; // 모임을 받아오고 전달하기 위한 list 생성

		// 정렬 방식에 따라 mapper의 쿼리문에 orderby를 다르게 주기 위한 if문
		if (sel.equals("new")) {
			hobee_list = inven_dao.selectHobee(category);
		} else if (sel.equals("best")) {
			hobee_list = inven_dao.selectHobee_best(category);
		}

		model.addAttribute("cate_list", cate_list);
		model.addAttribute("hobee_list", hobee_list);
		return "/WEB-INF/views/inventory/inven.jsp";
	}

	// 상세페이지
	@RequestMapping("/hobee_detail.do")
	public String detail(Model model, int hbidx) {
		System.out.println("inven 컨트롤러[디버그] 전달받은 hbidx: " + hbidx); // 디버깅용 로그
		HobeeVO hobee_vo = inven_dao.hobeeDetail(hbidx);
		model.addAttribute("hobee", hobee_vo);
		model.addAttribute("hbidx", hbidx); // hbidx도 별도로 전달

		// 리뷰 목록 조회
		List<ReviewVO> reviews = review_dao.reviewList();
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


		return "/WEB-INF/views/detail/detail.jsp";
	}

}
