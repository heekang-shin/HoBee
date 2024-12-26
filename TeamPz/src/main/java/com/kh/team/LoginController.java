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
		UsersVO loggedInUser = (UsersVO) session.getAttribute("loggedInUser");

		if (loggedInUser != null) {
			model.addAttribute("user", loggedInUser);
		} else {
			model.addAttribute("user", null);
		}

		return common.Common.VIEW_PATH + "main.jsp";
	}

	// 로그인 폼 페이지
	@RequestMapping("/login_form.do")
	public String showLoginForm() {
		return common.Common.VIEW_PATH + "login_form.jsp";
	}

	@ResponseBody
	@RequestMapping("/Login.do")
	public String processLogin(String id, String password, HttpSession session) {
		UsersVO user = users_dao.select_id(id);
		if (user != null && user.getUser_pwd().equals(password)) {
			session.setAttribute("loggedInUser", user);
			return "success";
		} else {
			return "fail";
		}
	}

	// 로그아웃 처리
	@RequestMapping("/logout.do")
	public String processLogout(HttpSession session) {
		session.invalidate();
		return "redirect:main.do";
	}

	// 회원가입 폼 페이지
	@RequestMapping("/CreateAccount_form.do")
	public String showCreateAccountForm() {
		return common.Common.VIEW_PATH + "CreateAccount_form.jsp";
	}

	// 중복 체크 처리
	@ResponseBody
	@RequestMapping("/check_duplicate.do")
	public String checkDuplicate(String id) {
		String duplicateCheck = users_dao.Duplicate_check(id);
		if ("1".equals(duplicateCheck)) {
			return "fail";
		} else if ("0".equals(duplicateCheck)) {
			return "true";
		} else {
			return "unknown";
		}
	}

	// 회원가입 처리
	@ResponseBody
	@RequestMapping("/create_account.do")
	public String processCreateAccount(UsersVO user) {
		int result = users_dao.Create(user);
		if (result > 0) {
			return "success";
		} else {
			return "error";
		}
	}

	// 회원가입 완료 페이지
	@RequestMapping("/createAccount.do")
	public String createAccount() {
		return common.Common.VIEW_PATH + "createAccount.jsp";
	}

	// 아이디|비밀번호 찾기 페이지
	@RequestMapping("/find.do")
	public String find_form() {
		return common.Common.VIEW_PATH + "find_form.jsp";
	}

	// 아이디 찾기
	@RequestMapping("/findUserId.do")
	@ResponseBody
	public String findUserId(String name, String email) {
		// UsersVO 객체 생성 및 값 설정
		UsersVO vo = new UsersVO();
		vo.setUser_name(name); // JSP에서 넘어온 name을 VO에 설정
		vo.setUser_email(email); // JSP에서 넘어온 email을 VO에 설정

		// DAO 메서드 호출
		UsersVO result = users_dao.findUserId(vo);

		// 조회 결과 반환
		if (result != null) {
			return "success:" + result.getId(); // "success:아이디" 형식으로 반환
		} else {
			return "fail"; // 조회 실패 시 "fail" 반환
		}
	}

	// 비밀번호 찾기
	@RequestMapping("/findPassword.do")
	@ResponseBody
	public String findPassword(String id, String email) {
	    UsersVO vo = new UsersVO();
	    vo.setId(id);
	    vo.setUser_email(email);

	    System.out.println("컨트롤러로 전달된 ID: " + id);
	    System.out.println("컨트롤러로 전달된 EMAIL: " + email);

	    // DAO 호출
	    String userPwd = users_dao.findUserpwd(vo);

	    // 결과 처리
	    if (userPwd != null) {
	        System.out.println("조회 성공: " + userPwd);
	        return "success:" + userPwd;
	    } else {
	        System.out.println("조회 실패");
	        return "fail";
	    }
	}



}
