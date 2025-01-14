package kh.pr.hobee.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.dao.InquiryDAO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.InquiryVO;

@Controller
public class inqController {

	HobeeDAO hobeedao;

	public void setHobeedao(HobeeDAO hobeedao) {
		this.hobeedao = hobeedao;
	}

	InquiryDAO inqdao;

	public void setInqdao(InquiryDAO inqdao) {
		this.inqdao = inqdao;
	}

	// inq_list 조회
	@RequestMapping("inq_list.do")
	public String inqListWithHobee(Model model) {
		List<InquiryVO> inqList = inqdao.selectInq();
		model.addAttribute("inq_list", inqList);
		return Common.VIEW_PATH_HOST + "inq/host_inq_main.jsp";
	}


	// inq 한개 조회
	@RequestMapping("host_inq_detail.do")
	public String applyList(int id, Model model) {
		InquiryVO vo = inqdao.inqOne(id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH_HOST + "inq/host_inq_detail.jsp";
	}

	
	//inq 답변폼으로 이동
	@RequestMapping("inq_write.do")
	public String writeForm(int id,Model model) {
		InquiryVO vo = inqdao.inqOne(id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH_HOST + "inq/host_inq_write.jsp";
	}
	
	//inq 답변 제출
	@RequestMapping("inq_update.do")
	public String writeFormFin(InquiryVO vo) {
		int res  = inqdao.inqFin(vo);
		return "redirect:inq_list.do";
	}
	
	//inq 답변 삭제
	@RequestMapping("inq_del.do")
	public String writeDel(int id) {
		int res  = inqdao.inqDel(id);
		return "redirect:inq_list.do";
	}
	
	//inq 답변폼으로 이동
	@RequestMapping("inq_write_update.do")
	public String writeUpdate(int id,Model model) {
		InquiryVO vo = inqdao.inqOne(id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH_HOST + "inq/host_inq_write.jsp";
	}
	
	
}
