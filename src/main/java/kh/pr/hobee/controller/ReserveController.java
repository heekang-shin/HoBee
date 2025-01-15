package kh.pr.hobee.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.ReserveDAO;
import kh.pr.hobee.vo.ReserveVO;

@Controller
public class ReserveController {

	ReserveDAO reserveDAO;

	public void setReserveDAO(ReserveDAO reserveDAO) {
		this.reserveDAO = reserveDAO;
	}

	// 호스트 리스트 페이지로 이동
	@RequestMapping("res_list.do")
	public String resList(Model model) {

		List<ReserveVO> res_list = reserveDAO.resList();
		model.addAttribute("res_list", res_list);
		return Common.VIEW_PATH_HOST + "res/host_res_main.jsp";
	}

	
	
	
}
