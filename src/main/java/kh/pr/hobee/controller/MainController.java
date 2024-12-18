package kh.pr.hobee.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.vo.HobeeVO;

@Controller
public class MainController {

	HobeeDAO hobeedao;

	public void setHobeedao(HobeeDAO hobeedao) {
		this.hobeedao = hobeedao;
	}

	//메인페이지
	@RequestMapping(value= {"/","main.do"})
	public String select(Model model) {
		//best 제품 조회
		List<HobeeVO> best_list = hobeedao.bestSelect();
		model.addAttribute("best_list", best_list);
	

		//pick 제품 조회
		List<HobeeVO> pick_list = hobeedao.pickSelect();
		model.addAttribute("pick_list", pick_list);
		
		//new 제품 조회
		List<HobeeVO> new_list = hobeedao.pickSelect();
		 System.out.println("list 사이즈: " + new_list.size());
		model.addAttribute("new_list", new_list);
		
		return Common.VIEW_PATH + "main/main.jsp";
	}

	// 검색
	@RequestMapping("search.do")
	public String search(String search_text, Model model) {
		// 파라미터가 없으면 기본값으로 빈 문자열을 설정합니다.
		System.out.println("Search Text: " + search_text); // 로그로 검색어 확인

		List<HobeeVO> search_list = hobeedao.searchSelect(search_text);
		model.addAttribute("search_list", search_list);
		return Common.VIEW_PATH + "search/search.jsp";
	}
	
	
	
	
	//모임등록 페이지 이동
		@RequestMapping("apply_list.do")
		public String applyList() {
			return Common.VIEW_PATH + "apply/apply_list.jsp";
		}

}
