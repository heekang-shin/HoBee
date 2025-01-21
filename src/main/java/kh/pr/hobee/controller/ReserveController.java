package kh.pr.hobee.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.ReserveDAO;
import kh.pr.hobee.vo.ReserveVO;


@Controller
public class ReserveController {
	
	@Autowired
	private HttpServletRequest request;
	
	ReserveDAO reservedao;
	
	public void setReservedao(ReserveDAO reservedao) {
		this.reservedao = reservedao;
	}
	
	private void setCurrentUrl(Model model) {
		String currentUrl = request.getRequestURI().replace(request.getContextPath(), "");
		model.addAttribute("currentUrl", currentUrl);
	}
	
	// 신청 내역 리스트 페이지로 이동
	@RequestMapping("res_list.do")
	public String resList(
	        @RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
	        @RequestParam(defaultValue = "10") int itemsPerPage, // 페이지당 항목 수 기본값 10
	        Model model
	) {
	    // 전체 신청 내역 리스트 가져오기
	    List<ReserveVO> resList = reservedao.resList();

	    // 페이징 처리 계산
	    int totalItems = resList.size(); // 총 항목 수
	    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수

	    // 현재 페이지에 맞는 데이터 가져오기
	    int start = (page - 1) * itemsPerPage; // 시작 인덱스
	    int end = Math.min(start + itemsPerPage, totalItems); // 끝 인덱스
	    List<ReserveVO> paginatedList = resList.subList(start, end);
	    
		// 시작 idx 계산 (전체 데이터 기준으로 줄어드는 번호 계산)
	    int startIdx = totalItems - (page - 1) * itemsPerPage;
	    
	    // Model 객체에 데이터 추가
	    model.addAttribute("res_list", paginatedList); // 페이징 처리된 데이터
	    model.addAttribute("currentPage", page); // 현재 페이지
	    model.addAttribute("totalPages", totalPages); // 총 페이지 수
	    model.addAttribute("totalItems", totalItems); // 총 페이지 수
	    model.addAttribute("startIdx", startIdx); // 시작 idx 전달
	    setCurrentUrl(model);
	    // JSP로 이동
	    return Common.VIEW_PATH_HOST + "res/host_res_main.jsp";
	}


	
	//신청 내역 검색
	@RequestMapping("res_search.do")
	public String applySch(String search_text, String search_category, Model model,
			 @RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
		        @RequestParam(defaultValue = "10") int itemsPerPage
			) {
		 
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
	    
	    // 페이징 처리 계산
	    int totalItems = search_list.size(); // 총 항목 수
	    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수
	    
		// 시작 idx 계산 (전체 데이터 기준으로 줄어드는 번호 계산)
	    int startIdx = totalItems - (page - 1) * itemsPerPage;
	    
	    // Model 객체에 데이터 추가
	    model.addAttribute("currentPage", page); // 현재 페이지
	    model.addAttribute("totalPages", totalPages); // 총 페이지 수
	    model.addAttribute("totalItems", totalItems); // 총 페이지 수
	    model.addAttribute("startIdx", startIdx); // 시작 idx 전달
	    model.addAttribute("res_list", search_list);
	    return Common.VIEW_PATH_HOST + "res/host_res_main.jsp";
	}
	
}
