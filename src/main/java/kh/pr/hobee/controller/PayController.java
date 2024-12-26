package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PayController {
	
	@RequestMapping("/payment.do")
	public String payment() {
		return "/WEB-INF/views/pay/pay.jsp";
	}
}
