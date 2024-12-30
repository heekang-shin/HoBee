package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.vo.HobeeVO;


@Controller
public class ApplyController {

	HobeeDAO hobeedao;

	public void setHobeedao(HobeeDAO hobeedao) {
		this.hobeedao = hobeedao;
	}
	
	
	
	//apply_form_check로 이동
	@RequestMapping("apply_insert.do")
    public String applyInsert(HobeeVO vo) {
		
		return Common.VIEW_PATH + "apply/apply_fin.jsp";
    }
	
	
	
	
	
}