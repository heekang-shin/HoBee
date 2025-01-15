package kh.pr.hobee.controller;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.ReserveDAO;
import kh.pr.hobee.vo.InquiryVO;
import kh.pr.hobee.vo.ReserveVO;


@Controller
public class ReserveController {

	ReserveDAO reservedao;
	
	public void setReservedao(ReserveDAO reservedao) {
		this.reservedao = reservedao;
	}

	
	// 신청 내역 리스트 페이지로 이동
	@RequestMapping("res_list.do")
	public String resList(Model model) {
		List<ReserveVO> res_list = reservedao.resList();
		model.addAttribute("res_list", res_list);
		return Common.VIEW_PATH_HOST + "res/host_res_main.jsp";
	}

	
	//신청 내역 검색
	@RequestMapping("res_search.do")
	public String applySch(String search_text, String search_category, Model model) {
		 
		List<ReserveVO> search_list = null;

	    // 검색 카테고리에 따라 다른 조회 메서드 호출
	    if ("title".equals(search_category)) {
	    	//타이틀 검색
	        search_list = reservedao.searchByTitle(search_text);
	    } else if ("content".equals(search_category)) {
	    	//내용 검색
	        search_list = reservedao.searchByContent(search_text);
	    } else {
	        // 전체 검색
	        search_list = reservedao.searchByAll(search_text);
	    }

	    model.addAttribute("res_list", search_list);
	    return Common.VIEW_PATH_HOST + "res/host_res_main.jsp";
	}
	
}
