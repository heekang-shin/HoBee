package kh.pr.hobee.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.dao.InquiryDAO;
import kh.pr.hobee.dao.ReserveDAO;
import kh.pr.hobee.dao.UsersDAO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.UsersVO;
import util.BCryptPwd;

@Controller
public class AdminController {

	@Autowired // 파일 포함을 위해
	private ServletContext application;

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	UsersDAO users_dao;

	HobeeDAO hobeedao;

	InquiryDAO inqdao;

	ReserveDAO reservedao;

	public void setHobeedao(HobeeDAO hobeedao) {
		this.hobeedao = hobeedao;
	}

	public void setReservedao(ReserveDAO reservedao) {
		this.reservedao = reservedao;
	}

	public void setInqdao(InquiryDAO inqdao) {
		this.inqdao = inqdao;
	}

	private void setCurrentUrl(Model model) {
		String currentUrl = request.getRequestURI().replace(request.getContextPath(), "");
		model.addAttribute("currentUrl", currentUrl);
	}

	// Setter 주입
	public void setUsers_dao(UsersDAO users_dao) {
		this.users_dao = users_dao;
	}

	// 회원가입 폼 페이지
	@RequestMapping("/create_admin_account.do")
	public String create_admin_account() {
		return kh.pr.hobee.common.Common.VIEW_PATH + "admin/create_admin.jsp";
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
	public String adminUser(@RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
			@RequestParam(defaultValue = "10") int itemsPerPage, // 페이지당 항목 수 기본값 10
			Model model) {

		// 전체 유저 리스트 가져오기
		List<UsersVO> user_list = users_dao.selectList();

		// 페이징 처리 계산
		int totalItems = user_list.size(); // 총 항목 수
		int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수

		// 현재 페이지에 맞는 데이터 가져오기
		int start = (page - 1) * itemsPerPage; // 시작 인덱스
		int end = Math.min(start + itemsPerPage, totalItems); // 끝 인덱스
		List<UsersVO> paginatedList = user_list.subList(start, end);

		// 시작 idx 계산 (전체 데이터 기준으로 줄어드는 번호 계산)
		int startIdx = totalItems - (page - 1) * itemsPerPage;

		// Model 객체에 데이터 추가
		model.addAttribute("user_list", paginatedList); // 페이징 처리된 데이터
		model.addAttribute("currentPage", page); // 현재 페이지
		model.addAttribute("totalPages", totalPages); // 총 페이지 수
		model.addAttribute("totalItems", totalItems); // 총 항목 수
		model.addAttribute("startIdx", startIdx); // 시작 idx 전달
		setCurrentUrl(model); // currentUrl 값을 Model에 추가

		return Common.VIEW_PATH + "admin/admin_user.jsp";
	}

	// 회원 한개 조회
	@RequestMapping("user_detail.do")
	public String applyList(int user_Id, Model model) {
		UsersVO vo = users_dao.adminOne(user_Id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH + "admin/admin_user_detail.jsp";
	}

	// 회원 정보 수정
	@RequestMapping("user_admin_update.do")
	public String updateFin(UsersVO vo) {
		int res = users_dao.updateFin(vo);
		return "redirect:admin_user.do";
	}

	// 회원 정보 삭제
	@RequestMapping("user_admin_del.do")
	public String userDel(UsersVO vo) {
		int res = users_dao.adminUserDel(vo.getUser_Id());
		return "redirect:admin_user.do";
	}

	// 회원 검색
	@RequestMapping("admin_user_search.do")
	public String applySch(@RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
			@RequestParam(defaultValue = "10") int itemsPerPage, // 페이지당 항목 수 기본값 10
			String search_text, String search_category, Model model) {

		List<UsersVO> search_list = null;

		// 검색 카테고리에 따라 다른 조회 메서드 호출
		if ("title".equals(search_category)) {
			// 타이틀 검색
			search_list = users_dao.searchByTitle(search_text);
		} else if ("content".equals(search_category)) {
			// 내용 검색
			search_list = users_dao.searchByContent(search_text);
		} else {
			// 전체 검색
			search_list = users_dao.searchByAll(search_text);
		}

		// 페이징 처리 계산
		int totalItems = search_list.size(); // 총 항목 수
		int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수

		// 현재 페이지에 맞는 데이터 가져오기
		int start = (page - 1) * itemsPerPage; // 시작 인덱스
		int end = Math.min(start + itemsPerPage, totalItems); // 끝 인덱스
		List<UsersVO> paginatedList = search_list.subList(start, end);

		// 시작 idx 계산 (전체 데이터 기준으로 줄어드는 번호 계산)
		int startIdx = totalItems - (page - 1) * itemsPerPage;

		// Model 객체에 데이터 추가
		model.addAttribute("user_list", paginatedList); // 페이징 처리된 데이터
		model.addAttribute("currentPage", page); // 현재 페이지
		model.addAttribute("totalPages", totalPages); // 총 페이지 수
		model.addAttribute("totalItems", totalItems); // 총 항목 수
		model.addAttribute("startIdx", startIdx); // 시작 idx 전달
		model.addAttribute("search_text", search_text); // 검색어 전달
		model.addAttribute("search_category", search_category); // 검색 카테고리 전달

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
	public String adminProgram(Model model, @RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
			@RequestParam(defaultValue = "10") int itemsPerPage) {

		// 전체 유저 리스트 가져오기
		List<HobeeVO> hobee_list = hobeedao.applyList();
		model.addAttribute("hobee_list", hobee_list);

		// 페이징 처리 계산
		int totalItems = hobee_list.size(); // 총 항목 수
		int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수

		// 현재 페이지에 맞는 데이터 가져오기
		int start = (page - 1) * itemsPerPage; // 시작 인덱스
		int end = Math.min(start + itemsPerPage, totalItems); // 끝 인덱스
		List<HobeeVO> paginatedList = hobee_list.subList(start, end);

		// 시작 idx 계산 (전체 데이터 기준으로 줄어드는 번호 계산)
		int startIdx = totalItems - (page - 1) * itemsPerPage;

		// Model 객체에 데이터 추가
		model.addAttribute("hobee_list", paginatedList); // 페이징 처리된 데이터
		model.addAttribute("currentPage", page); // 현재 페이지
		model.addAttribute("totalPages", totalPages); // 총 페이지 수
		model.addAttribute("totalItems", totalItems); // 총 항목 수
		model.addAttribute("startIdx", startIdx); // 시작 idx 전달

		setCurrentUrl(model);
		return Common.VIEW_PATH + "admin/admin_program.jsp";
	}

	// 프로그램 상세 페이지
	@RequestMapping("admin_host_detail.do")
	public String adminHost(int hb_idx, int status, String category_name, Model model) {
		HobeeVO vo = hobeedao.applyOne(hb_idx);
		model.addAttribute("vo", vo);
		model.addAttribute("category_name", category_name);
		return Common.VIEW_PATH + "admin/admin_program_detail.jsp";
	}

	// 프로그램 게시
	@RequestMapping(value = "admin_host_post.do", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String delte(HobeeVO vo) {
		int res = hobeedao.hostPost(vo);

		String str = "no";

		if (res != 0) {
			str = "yes";
		}

		String resultStr = String.format("[{'res':'%s'}]", str);

		return resultStr;
	}
}
