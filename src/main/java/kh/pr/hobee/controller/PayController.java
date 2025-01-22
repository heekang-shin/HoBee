package kh.pr.hobee.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.dao.InvenDAO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.ReserveVO;
import kh.pr.hobee.vo.UsersVO;

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
		ReserveVO res_vo = new ReserveVO();
		int hbPrice = inven_dao.hobPrice(hbidx);
		int headCount = amount / hbPrice;
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("hbidx", hbidx);
	    params.put("headCount", headCount);

	    // inven_dao.plusHead() 메서드에 Map을 전달
	    int headPlus = inven_dao.plusHead(params);
		
		res_vo.setHb_idx(hbidx);
		res_vo.setUser_id(userid);
		res_vo.setPrice(amount);
		
		int reserve = inven_dao.addReserve(res_vo);
		
		UsersVO user = inven_dao.selectUser(userid);
		model.addAttribute("price", amount);
		model.addAttribute("user", user);
	    return "WEB-INF/views/pay/success.jsp"; // View Resolver가 success.jsp로 매핑
	}
}
