package kh.pr.hobee.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pr.hobee.dao.UsersDAO;
import kh.pr.hobee.vo.UsersVO;
import util.BCryptPwd;

@Controller
public class AdminController {

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	UsersDAO users_dao;

	// Setter 주입
	public void setUsers_dao(UsersDAO users_dao) {
		this.users_dao = users_dao;
	}

	// 회원가입 폼 페이지
	@RequestMapping("/create_admin_account.do")
	public String create_admin_account() {
		return kh.pr.hobee.common.Common.VIEW_PATH + "admin/admin.jsp";
	}

	// 회원가입 처리
	@ResponseBody
	@RequestMapping("/admin_account.do")
	public String processCreateAccount(UsersVO user) {
		// 비밀번호 암호화
		BCryptPwd pwdUtil = new BCryptPwd();
		String encryptedPassword = pwdUtil.encryption(user.getUser_pwd()); // 입력된 비밀번호 암호화
		user.setUser_pwd(encryptedPassword); // 암호화된 비밀번호를 VO에 설정

		// LV 기본값 설정
		if (user.getLv() == null || user.getLv().isEmpty()) {
			user.setLv("관리자"); // LV 기본값을 "일반"으로 설정
		}

		// DAO 호출 및 사용자 정보 저장
		int result = users_dao.Create(user);

		if (result > 0) {
			return "success";
		} else {
			return "error";
		}
	}

	// 중복 체크 처리
	@ResponseBody
	@RequestMapping("/admin_check_duplicate.do")
	public String checkDuplicate(String id) {
		boolean isDuplicate = users_dao.admin_Duplicate_check(id);

		if (isDuplicate) {
			return "fail"; // 중복된 경우
		} else {
			return "true"; // 중복되지 않은 경우
		}
	}

}
