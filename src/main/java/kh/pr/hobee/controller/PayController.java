package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.dao.InvenDAO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.ReserveVO;

	@Controller
	public class PayController {
	
		InvenDAO inven_dao;
	
		public void setInven_dao(InvenDAO inven_dao) {
			this.inven_dao = inven_dao;
	}
	
	@RequestMapping("/payment.do")
	public String payment(Model model, int price, int hbidx, int userid) {
		HobeeVO hobee_vo = inven_dao.hobeeDetail(hbidx);
		
		model.addAttribute("price", price);
		model.addAttribute("hobee", hobee_vo);
		model.addAttribute("user_id", userid);
		return "/WEB-INF/views/pay/pay.jsp";
	}
	
	@RequestMapping("/success.do")
	public String paymentSuccess(Model model, int hbidx , int amount, int userid) {
		
		ReserveVO res_vo = new ReserveVO();;		
		res_vo.setHb_idx(hbidx);
		res_vo.setUser_id(userid);
		res_vo.setPrice(amount);
		
		
		int reserve = inven_dao.addReserve(res_vo);
		model.addAttribute("price", amount);
	    return "WEB-INF/views/pay/success.jsp"; // View Resolver가 success.jsp로 매핑
	}
}
