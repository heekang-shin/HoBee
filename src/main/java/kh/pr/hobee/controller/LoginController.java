package kh.pr.hobee.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pr.hobee.dao.UsersDAO;
import kh.pr.hobee.vo.UsersVO;
import util.BCryptPwd;

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

	/*
	 * // 메인 페이지 조회 (서버 실행 시 기본 페이지)
	 * 
	 * @RequestMapping(value = { "/", "/main.do" }) public String list(HttpSession
	 * session, Model model) { UsersVO loggedInUser = (UsersVO)
	 * session.getAttribute("loggedInUser");
	 * 
	 * if (loggedInUser != null) { model.addAttribute("user", loggedInUser); } else
	 * { model.addAttribute("user", null); }
	 * 
	 * return kh.pr.hobee.common.Common.VIEW_PATH + "main.jsp"; }
	 */

	// 로그인 폼 페이지
	@RequestMapping("/login_form.do")
	public String showLoginForm() {
		return kh.pr.hobee.common.Common.VIEW_PATH + "login/login_form.jsp";
	}
	// 로그인 처리
	@ResponseBody
	@RequestMapping("/Login.do")
	public String processLogin(String id, String password, HttpSession session) {
	    // DB에서 사용자 조회
	    UsersVO user = users_dao.select_id(id);

	    if (user != null) {
	        BCryptPwd pwdUtil = new BCryptPwd();
	        // 비밀번호 비교 (입력된 비밀번호와 DB 저장된 암호화된 비밀번호)
	        boolean isValid = pwdUtil.decryption(user.getUser_pwd(), password);

	        if (isValid) {
	            session.setAttribute("loggedInUser", user); // 세션에 사용자 정보 저장
	            return "success";
	        }
	    }

	    return "fail"; // 로그인 실패
	}

	//에러페이지
	@RequestMapping("/errorPage.do")
	public String errorPage() {
		return kh.pr.hobee.common.Common.VIEW_PATH+ "login/errorPage.jsp"; // errorPage.jsp 또는 View 이름
	}


	// 로그아웃 처리
	@RequestMapping("/logout.do")
	public String processLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/main.do";
	}

	// 회원가입 폼 페이지
	@RequestMapping("/CreateAccount_form.do")
	public String showCreateAccountForm() {
		return kh.pr.hobee.common.Common.VIEW_PATH+ "login/CreateAccount_form.jsp";
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
	    // 비밀번호 암호화
	    BCryptPwd pwdUtil = new BCryptPwd();
	    String encryptedPassword = pwdUtil.encryption(user.getUser_pwd()); // 입력된 비밀번호 암호화
	    user.setUser_pwd(encryptedPassword); // 암호화된 비밀번호를 VO에 설정

	    // DAO 호출 및 사용자 정보 저장
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
		return kh.pr.hobee.common.Common.VIEW_PATH + "login/createAccount.jsp";
	}

	// 아이디|비밀번호 찾기 페이지
	@RequestMapping("/find.do")
	public String find_form() {
		return kh.pr.hobee.common.Common.VIEW_PATH+ "login/find_form.jsp";
	}

	// 아이디 찾기
	@RequestMapping("/findUserId.do")
	@ResponseBody
	public String findUserId(String name, String email) {
	    System.out.println("입력된 이름: " + name);
	    System.out.println("입력된 이메일: " + email);

	    UsersVO vo = new UsersVO();
	    vo.setUser_name(name);
	    vo.setUser_email(email);

	    String result = users_dao.findUserId(vo);

	    if (result != null) {
	        System.out.println("조회된 ID: " + result);
	        return "success:" + result; // "success:아이디" 형식으로 반환
	    } else {
	        System.out.println("조회된 ID가 없습니다.");
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
