package kh.pr.hobee.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.dao.InquiryDAO;
import kh.pr.hobee.vo.InquiryVO;

@Controller
public class InqController {
	
	@Autowired
	private HttpServletRequest request;
	
	HobeeDAO hobeedao;

	public void setHobeedao(HobeeDAO hobeedao) {
		this.hobeedao = hobeedao;
	}

	InquiryDAO inqdao;

	public void setInqdao(InquiryDAO inqdao) {
		this.inqdao = inqdao;
	}
	
	private void setCurrentUrl(Model model) {
		String currentUrl = request.getRequestURI().replace(request.getContextPath(), "");
		model.addAttribute("currentUrl", currentUrl);
	}

	// inq_list 조회
	@RequestMapping("inq_list.do")
	public String inqListWithHobee(
	        @RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
	        @RequestParam(defaultValue = "10") int itemsPerPage, // 페이지당 항목 수 기본값 10
	        Model model
	) {
	    // 전체 문의 리스트 가져오기
	    List<InquiryVO> inqList = inqdao.selectInq();

	    // 페이징 처리 계산
	    int totalItems = inqList.size(); // 총 항목 수
	    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수

	    // 현재 페이지에 맞는 데이터 가져오기
	    int start = (page - 1) * itemsPerPage; // 시작 인덱스
	    int end = Math.min(start + itemsPerPage, totalItems); // 끝 인덱스
	    List<InquiryVO> paginatedList = inqList.subList(start, end);

		// 시작 idx 계산 (전체 데이터 기준으로 줄어드는 번호 계산)
		int startIdx = totalItems - (page - 1) * itemsPerPage;
	    
	    // Model 객체에 데이터 추가
	    model.addAttribute("inq_list", paginatedList); // 페이징 처리된 데이터
	    model.addAttribute("currentPage", page); // 현재 페이지
	    model.addAttribute("totalPages", totalPages); // 총 페이지 수
	    model.addAttribute("totalItems", totalItems); // 총 항목?
	    model.addAttribute("startIdx", startIdx); // 시작 idx 전달
	    setCurrentUrl(model);
	    
	    // JSP로 이동
	    return Common.VIEW_PATH_HOST + "inq/host_inq_main.jsp";
	}

	

	// inq 한개 조회
	@RequestMapping("host_inq_detail.do")
	public String applyList(int id, Model model) {
		InquiryVO vo = inqdao.inqOne(id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH_HOST + "inq/host_inq_detail.jsp";
	}

	
	//inq 답변폼으로 이동
	@RequestMapping("inq_write.do")
	public String writeForm(int id,Model model) {
		InquiryVO vo = inqdao.inqOne(id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH_HOST + "inq/host_inq_write.jsp";
	}
	
	//inq 답변 제출
	@RequestMapping("inq_update.do")
	public String writeFormFin(InquiryVO vo) {
		int res  = inqdao.inqFin(vo);
		return "redirect:inq_list.do";
	}
	
	//inq 답변 삭제
	@RequestMapping("inq_del.do")
	public String writeDel(int id) {
		int res  = inqdao.inqDel(id);
		return "redirect:inq_list.do";
	}
	
	//inq 답변폼으로 이동
	@RequestMapping("inq_write_update.do")
	public String writeUpdate(int id,Model model) {
		InquiryVO vo = inqdao.inqOne(id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH_HOST + "inq/host_inq_write.jsp";
	}
	
	
	//inq 검색
	@RequestMapping("inq_search.do")
	public String applySch(String search_text, String search_category, Model model) {
		 
		List<InquiryVO> search_list = null;

	    // 검색 카테고리에 따라 다른 조회 메서드 호출
	    if ("title".equals(search_category)) {
	    	//타이틀 검색
	        search_list = inqdao.searchByTitle(search_text);
	    } else if ("content".equals(search_category)) {
	    	//내용 검색
	        search_list = inqdao.searchByContent(search_text);
	    } else {
	        // 전체 검색
	        search_list = inqdao.searchByAll(search_text);
	    }

	    model.addAttribute("inq_list", search_list);
	    return Common.VIEW_PATH_HOST + "inq/host_inq_main.jsp";
	}
	
	
	
	
	
}
