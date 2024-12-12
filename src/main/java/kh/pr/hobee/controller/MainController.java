package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	//메인페이지
	@RequestMapping(value={"/","/main-page"})
	public String mainPage() {
		
		return "/main";
	}
	
}
