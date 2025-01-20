package kh.pr.hobee.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.dao.InquiryDAO;
import kh.pr.hobee.dao.ReserveDAO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.InquiryVO;
import kh.pr.hobee.vo.ReserveVO;
import kh.pr.hobee.vo.UsersVO;

@Controller
public class AdminController {

	@Autowired // 파일 포함을 위해
	private ServletContext application;

	@Autowired
	private HttpServletRequest request;

	@Autowired
	HttpSession session;

	HobeeDAO hobeedao;

	public void setHobeedao(HobeeDAO hobeedao) {
		this.hobeedao = hobeedao;
	}

	InquiryDAO inqdao;

	public void setInqdao(InquiryDAO inqdao) {
		this.inqdao = inqdao;
	}

	ReserveDAO reservedao;

	public void setReservedao(ReserveDAO reservedao) {
		this.reservedao = reservedao;
	}

	private void setCurrentUrl(Model model) {
		String currentUrl = request.getRequestURI().replace(request.getContextPath(), "");
		model.addAttribute("currentUrl", currentUrl);
	}

	// 관리자 메인
	@RequestMapping("admin_main.do")
	public String hostMain(Model model) {

		// 세션에서 사용자 정보 확인
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		if (user == null) {
			System.out.println("[디버그] 사용자가 로그인하지 않았습니다. 로그인 페이지로 리다이렉트");
			return "redirect:/login_form.do";
		}

		if ("일반".equals(user.getLv()) && "호스트".equals(user.getLv())) {
			// 사용자가 관리자 권한이 없는 경우
			System.out.println("[디버그] 사용자 ID: " + user.getId() + " - 관리자 권한 없음. 로그인 페이지로 이동");
			return "redirect:/login_form.do";
		}

		// 다른 조건을 처리하거나 디버그 추가
		System.out.println("[디버그] 사용자 ID: " + user.getId() + " - 권한 확인 완료");

		return Common.VIEW_PATH + "admin/admin_main.jsp";
	}

	// 배너 관리
	@RequestMapping("admin_banner.do")
	public String adminBanner(Model model) {
		setCurrentUrl(model);
		return Common.VIEW_PATH + "admin/admin_banner.jsp";
	}

	// 회원 관리
	@RequestMapping("admin_user.do")
	public String adminUser(Model model) {
	    setCurrentUrl(model); // currentUrl 값을 Model에 추가
	    return Common.VIEW_PATH + "admin/admin_user.jsp";
	}

	// 호스트 관리
	@RequestMapping("admin_host.do")
	public String adminHost(Model model) {
		setCurrentUrl(model);
		return Common.VIEW_PATH + "admin/admin_host.jsp";
	}

	// 프로그램 관리
	@RequestMapping("admin_program.do")
	public String adminProgram(Model model) {
		setCurrentUrl(model);
		return Common.VIEW_PATH + "admin/admin_program.jsp";
	}

	// 결제 관리
	@RequestMapping("admin_pay.do")
	public String adminPay(Model model) {
	    setCurrentUrl(model);
	    return Common.VIEW_PATH + "admin/admin_pay.jsp";
	}

}