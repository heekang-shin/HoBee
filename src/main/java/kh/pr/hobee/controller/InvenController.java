package kh.pr.hobee.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.dao.InvenDAO;
import kh.pr.hobee.vo.CategoryVO;
import kh.pr.hobee.vo.HobeeVO;

@Controller
public class InvenController {
	
	InvenDAO inven_dao;
	public void setInven_dao(InvenDAO inven_dao) {
		this.inven_dao = inven_dao;
	}
	
	@RequestMapping("/select_list.do")
	public String selectlist(Model model, int category, String arr) {
		
		//모임 목록의 정렬 방식의 초기값을 최신순으로 설정
		String sel= "new";
		
		//전달 받은 모임 목록 정렬 방식이 null이 아닐경우
		if(arr!=null) {
			sel=arr;
		}
		
		List<CategoryVO> cate_list = inven_dao.selectInven(category); //카테고리 하위의 세부 카테고리 받아오기
		List<HobeeVO> hobee_list=null; //모임을 받아오고 전달하기 위한 list 생성
		
		//정렬 방식에 따라 mapper의 쿼리문에 orderby를 다르게 주기 위한 if문 
		if(sel.equals("new")) {
			hobee_list = inven_dao.selectHobee(category); 
		} else if(sel.equals("best")) {
			hobee_list = inven_dao.selectHobee_best(category);
		}
		
		model.addAttribute("cate_list",cate_list);
		model.addAttribute("hobee_list", hobee_list);
		return "/WEB-INF/views/inventory/inven.jsp";
	}
	
	@RequestMapping("/hobee_detail.do")
	public String detail(Model model, int hbidx) {
		HobeeVO hobee_vo = inven_dao.hobeeDetail(hbidx);
		model.addAttribute("hobee",hobee_vo);
		return "/WEB-INF/views/detail/detail.jsp";
	}
	
}