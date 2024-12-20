package com.kh.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.UsersDAO;
import vo.UsersVO;

@Controller
public class LoginController {

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	UsersDAO users_dao;

	// Setter 주입
	public void setUsers_dao(UsersDAO users_dao) {
		this.users_dao = users_dao;
	}

	// 메인 페이지 조회 (서버 실행 시 기본 페이지)
	@RequestMapping(value = { "/", "/main.do" })
	public String list(HttpSession session, Model model) {
		// 세션에서 사용자 정보 가져오기
		UsersVO loggedInUser = (UsersVO) session.getAttribute("loggedInUser");

		if (loggedInUser != null) {
			// 로그인된 사용자 정보를 모델에 추가
			model.addAttribute("user", loggedInUser);
		} else {
			// 로그인이 안 된 상태임을 모델에 추가
			model.addAttribute("user", null);
		}

		return common.Common.VIEW_PATH + "main.jsp"; // main.jsp로 이동
	}

	// 로그인 폼 페이지
	@RequestMapping("/login_form.do")
	public String showLoginForm() {
		return common.Common.VIEW_PATH + "login_form.jsp"; // login_form.jsp
	}

	@ResponseBody
	@RequestMapping("/Login.do")
	public String processLogin(String id, String password, HttpSession session) {
		UsersVO user = users_dao.select_id(id);
		if (user != null && user.getUserpwd().equals(password)) {
			session.setAttribute("loggedInUser", user);
			return "success"; // 성공 시 문자열 반환
		} else {
			return "fail"; // 실패 시 문자열 반환
		}
	}

	// 로그아웃 처리
	@RequestMapping("/logout.do")
	public String processLogout(HttpSession session) {
		session.invalidate(); // 세션 초기화
		return "redirect:main.do";
	}

	// 회원가입 폼 페이지
	@RequestMapping("/CreateAccount_form.do")
	public String showCreateAccountForm() {
		return common.Common.VIEW_PATH + "CreateAccount_form.jsp"; // 회원가입 폼
	}

	// 회원가입 처리
	@RequestMapping("/create_account.do")
	public String processCreateAccount(UsersVO user, Model model) {
		// 아이디 중복 체크
		String duplicateCheck = users_dao.Duplicate_check(user.getId());
		if (duplicateCheck.equals("1")) {
			model.addAttribute("error", "이미 사용 중인 아이디입니다.");
			return common.Common.VIEW_PATH + "createAccount.jsp";
		}

		// 사용자 등록
		int result = users_dao.Create(user);
		if (result > 0) {
			model.addAttribute("message", "회원가입이 성공적으로 완료되었습니다.");
			return "login_form"; // 로그인 페이지로 이동
		} else {
			model.addAttribute("error", "회원가입 중 오류가 발생했습니다.");
			return common.Common.VIEW_PATH + "createAccount_form.jsp";
		}
	}
}
