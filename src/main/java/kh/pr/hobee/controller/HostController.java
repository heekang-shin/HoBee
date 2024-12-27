package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;

@Controller
public class HostController {

	//로그인 페이지로 이동
	@RequestMapping("host_login.do")
	public String hostList() {
		return Common.VIEW_PATH + "host/host_login.jsp";
	}
	
	
}
