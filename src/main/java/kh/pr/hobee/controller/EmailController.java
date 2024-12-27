package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.MailSendService;

@Controller
public class EmailController {

	MailSendService mss;
	public EmailController( MailSendService mss ) {
		this.mss = mss;
	}
	
	@RequestMapping("/mailCheck.do")
	@ResponseBody
	public String mailCheck( String email ) {
		String res = mss.joinEmail(email);
		return res;
	}

	@RequestMapping("/mailCheckPassword.do")
	@ResponseBody
	public String mailCheckPassword( String email ) {
		String res = mss.joinEmail(email);
		return res;
	}
}












