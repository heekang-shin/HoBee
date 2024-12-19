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
		
		String sel= "new";
		
		if(arr!=null) {
			
			sel=arr;
		}
		
		List<CategoryVO> cate_list = inven_dao.selectInven(category);
		List<HobeeVO> hobee_list=null;
		
		if(sel.equals("new")) {
			System.out.println(sel);
			hobee_list = inven_dao.selectHobee(category);
		} else if(sel.equals("best")) {
			System.out.println(sel);
			hobee_list = inven_dao.selectHobee_best(category);
		}
		
		model.addAttribute("cate_list",cate_list);
		model.addAttribute("hobee_list", hobee_list);
		return "/WEB-INF/views/inventory/inven.jsp";
	}
	
}
