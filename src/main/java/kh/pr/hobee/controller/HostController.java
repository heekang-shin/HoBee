package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.vo.HobeeVO;

@Controller
public class HostController {

	// 로그인 페이지로 이동
	@RequestMapping("host_login.do")
	public String hostList() {
		return Common.VIEW_PATH + "host/host_login.jsp";
	}

	// host_apply_form으로 이동
	@RequestMapping("host_apply_form.do")
	public String applyForm() {
		return Common.VIEW_PATH + "host/host_apply_form.jsp";
	}

	// apply_form_check로 이동
	@RequestMapping("host_apply_insert.do")
	public String applyInsert() {

		return Common.VIEW_PATH + "host/host_apply_fin.jsp";
	}

}
