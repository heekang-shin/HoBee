package kh.pr.hobee.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.ReserveDAO;


@Controller
public class ReserveController {

	ReserveDAO reserveDAO;

	public void setReserveDAO(ReserveDAO reserveDAO) {
		this.reserveDAO = reserveDAO;
	}


	// 신청 내역 리스트 페이지로 이동
	@RequestMapping("res_list.do")
	public String resList(Model model) {
		return Common.VIEW_PATH_HOST + "res/host_res_main.jsp";
	}

	
	
	
}
