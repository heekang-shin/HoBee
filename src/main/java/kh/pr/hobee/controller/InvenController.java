package kh.pr.hobee.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.dao.InvenDAO;
import kr.pr.hobee.vo.CategoryVO;

@Controller
public class InvenController {
	
	InvenDAO inven_dao;
	public InvenController(InvenDAO inven_dao) {
		this.inven_dao = inven_dao;
	}
	
	@RequestMapping("/select_list.do")
	public String selectlist(Model model, int category) {
		List<CategoryVO> list = inven_dao.selectInven(category);
		model.addAttribute("list",list);
		return "/WEB-INF/views/admin_inventory/admin_inven.jsp";
	}
}
