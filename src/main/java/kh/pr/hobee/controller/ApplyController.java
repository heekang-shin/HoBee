package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;


@Controller
public class ApplyController {

	//apply_form으로 이동
	@RequestMapping("apply_form.do")
    public String applyForm() {
        return Common.VIEW_PATH + "apply/apply_form.jsp";
    }
}