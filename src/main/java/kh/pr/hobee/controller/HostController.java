package kh.pr.hobee.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.dao.HostDAO;
import kh.pr.hobee.dao.InquiryDAO;
import kh.pr.hobee.dao.ReserveDAO;
import kh.pr.hobee.dao.UsersDAO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.HostVO;
import kh.pr.hobee.vo.InquiryVO;
import kh.pr.hobee.vo.ReserveVO;
import kh.pr.hobee.vo.UsersVO;

@Controller
public class HostController {

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
	
	
	UsersDAO users_dao;

	// Setter 주입
	public void setUsers_dao(UsersDAO users_dao) {
		this.users_dao = users_dao;
	}
	
	HostDAO host_dao;
	public void setHost_dao(HostDAO host_dao) {
		this.host_dao = host_dao;
	}

	// 호스트 메인
	@RequestMapping("host_main.do")
	public String hostMain(Model model) {

		// 세션에서 사용자 정보 확인
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		if (user == null) {
			System.out.println("[디버그] 사용자가 로그인하지 않았습니다. 로그인 페이지로 리다이렉트");
			return "redirect:/login_form.do";
		} 
		
		if (!"호스트".equals(user.getLv())) {
		    // 사용자가 호스트 권한이 없는 경우
		    System.out.println("[디버그] 사용자 ID: " + user.getId() + " - 호스트 권한 없음. 호스트 신청 페이지로 이동");
		    return Common.VIEW_PATH_HOST + "classApply/host_classApply.jsp";
		}

		// 다른 조건을 처리하거나 디버그 추가
		System.out.println("[디버그] 사용자 ID: " + user.getId() + " - 권한 확인 완료");
		int user_id = user.getUser_Id();
		
		// 전체 프로그램 신청 리스트 가져오기
		List<HobeeVO> apply_list = hobeedao.applyListUser(user_id);
		int totalItems = apply_list.size();

		// 질문 프로그램 신청 리스트 가져오기
		List<InquiryVO> inqList = inqdao.selectInqUser(user_id);
		// 전체 항목 수 계산
		int inqtotalItems = inqList.size();

		// 질문 미답변 계산
		int nullCount = inqdao.selectNull(user_id); 

		// 전체 신청 내역 리스트 가져오기
		List<ReserveVO> resList = reservedao.resListUser(user_id);
		int restotalItems = resList.size();

		// 날짜 가져오기
		model.addAttribute("now", new Date());
		
		//호스트 정보
		HostVO host_vo = host_dao.selectHost(user_id);
		model.addAttribute("host",host_vo);

		model.addAttribute("apply_list", apply_list);
		model.addAttribute("inqList", inqList);
		model.addAttribute("resList", resList);

		model.addAttribute("totalItems", totalItems);
		model.addAttribute("inqtotalItems", inqtotalItems);
		model.addAttribute("restotalItems", restotalItems);
		model.addAttribute("nullCount", nullCount);

		return Common.VIEW_PATH_HOST + "main/host_main.jsp";
	}
	
	//호스트 정보 조회, 수정
	@RequestMapping("host_info.do")
	public String hostInfo(HttpSession session, Model model) {
		UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		System.out.println(user.getUser_Id());
		HostVO vo = host_dao.selectHost(user.getUser_Id());
		model.addAttribute("hostInfo", vo);
		return Common.VIEW_PATH_HOST + "host_info.jsp";
	}

	// 호스트 리스트 페이지로 이동
	@RequestMapping("host_list.do")
	public String hostList(@RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
			@RequestParam(defaultValue = "10") int itemsPerPage, // 페이지당 항목 수 기본값 10
			Model model) {
		
		// 세션에서 사용자 정보 확인
	    UsersVO user = (UsersVO) session.getAttribute("loggedInUser");
		int user_id = user.getUser_Id();
		
		// 전체 호스트 리스트 가져오기
		List<HobeeVO> apply_list = hobeedao.applyListUser(user_id);
	    
		// 페이징 처리  계산
		int totalItems = apply_list.size(); // 총 항목 수
		int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수

		// 현재 페이지에 맞는 데이터 가져오기
		int start = (page - 1) * itemsPerPage; // 시작 인덱스
		int end = Math.min(start + itemsPerPage, totalItems); // 끝 인덱스
		List<HobeeVO> paginatedList = apply_list.subList(start, end);

		// 시작 idx 계산 (전체 데이터 기준으로 줄어드는 번호 계산)
	    int startIdx = totalItems - (page - 1) * itemsPerPage;
		
		// Model 객체에 데이터 추가
		model.addAttribute("apply_list", paginatedList); // 페이징 처리된 데이터
		model.addAttribute("currentPage", page); // 현재 페이지
		model.addAttribute("totalPages", totalPages); // 총 페이지 수
		model.addAttribute("totalItems", totalItems); // 총 항목 수
		model.addAttribute("startIdx", startIdx); // 시작 idx 전달
		model.addAttribute("user_id", user_id); // 로그인user_id 전달
		setCurrentUrl(model);
		
		// JSP로 이동
		return Common.VIEW_PATH + "host/host_list.jsp";
	}

	
	
	// host_apply_form으로 이동
	@RequestMapping("host_apply_form.do")
	public String applyForm(HttpSession session, Model model) {
		
		// JSP 경로 반환
		return Common.VIEW_PATH + "host/host_apply_form.jsp";
	}
	
	
	// host_apply_insert.do
	@RequestMapping("host_apply_insert.do")
	public String hostInsert(HobeeVO vo, Model model, HttpSession session) {
		
		// 세션에서 로그인 사용자 정보 가져오기
		UsersVO loggedInUser = (UsersVO) session.getAttribute("loggedInUser");
		
		//user_id 설정
		int user_id = loggedInUser.getUser_Id();
		vo.setUser_id(user_id);
		
		String webPath = "/resources/images/upload/"; // 상대경로
		String savePath = application.getRealPath(webPath); // 절대경로

		System.out.println("절대경로:" + savePath);

		// 업로드를 위한 파일 정보 처리
		handleFileUpload(vo.getS_image_filename(), savePath, "s_image", vo);
		handleFileUpload(vo.getIn_image_filename(), savePath, "in_image", vo);
		handleFileUpload(vo.getL_image_filename(), savePath, "l_image", vo);

		// 시간 데이터 포맷 적용
		if (vo.getHb_time() != null) {
			try {
				LocalTime time = LocalTime.parse(vo.getHb_time());
				String formattedTime = time.format(DateTimeFormatter.ofPattern("HH:mm"));
				vo.setHb_time(formattedTime);
			} catch (Exception e) {
				System.err.println("Invalid time format: " + vo.getHb_time());
			}
		}

		System.out.println("주소:" + vo.getHb_address());
		System.out.println("주소:" + vo.getExtraAddress());

		System.out.println("카테고리:" + vo.getCategory_num());
		
		

		// DAO를 통해 데이터 삽입
		int res = hobeedao.insertFin(vo);
		System.out.println("삽입 결과: " + res);

		List<HobeeVO> apply_list = hobeedao.applyList();
		model.addAttribute("apply_list", apply_list);

		return "redirect:host_list.do";
	}

	// 파일 업로드
	private void handleFileUpload(MultipartFile file, String savePath, String fieldName, HobeeVO vo) {
		String filename = null;

		if (file != null && !file.isEmpty()) {
			filename = file.getOriginalFilename();

			// 저장 경로 디렉터리 생성
			File directory = new File(savePath);
			if (!directory.exists()) {
				directory.mkdirs();
			}

			// 기존 파일 삭제
			deleteExistingFile(savePath, fieldName.equals("s_image") ? vo.getS_image()
					: fieldName.equals("l_image") ? vo.getL_image() : vo.getIn_image());

			// 중복 파일 이름 처리
			File saveFile = new File(savePath, filename);
			if (saveFile.exists()) {
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}

			try {
				file.transferTo(saveFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			// 파일이 없을 경우 기존 파일 이름 유지
			filename = fieldName.equals("s_image") ? vo.getS_image()
					: fieldName.equals("l_image") ? vo.getL_image() : vo.getIn_image();
		}

		// VO에 파일 이름 설정
		if ("s_image".equals(fieldName)) {
			vo.setS_image(filename);
		} else if ("in_image".equals(fieldName)) {
			vo.setIn_image(filename);
		} else if ("l_image".equals(fieldName)) {
			vo.setL_image(filename);
		}

		System.out.println(fieldName + " 파일이름: " + filename);
	}

	
	// 기존 파일 삭제
	private void deleteExistingFile(String savePath, String filename) {
		if (filename != null && !filename.equals("no_file")) {
			File existingFile = new File(savePath, filename);
			if (existingFile.exists()) {
				existingFile.delete();
				System.out.println("Deleted File: " + filename);
			}
		}
	}

	// host 한개 조회
	@RequestMapping("host_apply_detail.do")
	public String applyList(int hb_idx, Model model) {
		HobeeVO vo = hobeedao.applyOne(hb_idx);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH + "host/host_apply_detail.jsp";
	}

	// host 한개 수정
	@RequestMapping("apply_modify.do")
	public String applyModify(HobeeVO vo, Model model) {
		String webPath = "/resources/images/upload/"; // 상대경로
		String savePath = application.getRealPath(webPath); // 절대경로

		System.out.println("절대경로: " + savePath);

		// 업로드된 파일 처리
		handleFileUpload(vo.getS_image_filename(), savePath, "s_image", vo);
		handleFileUpload(vo.getL_image_filename(), savePath, "l_image", vo);
		handleFileUpload(vo.getIn_image_filename(), savePath, "in_image", vo);
		// 데이터 수정 처리
		int res = hobeedao.modify(vo);
		if (res > 0) {
			System.out.println("수정 성공");
			// 수정 후 상세 페이지로 리다이렉트
			return "redirect:host_list.do";
		} else {
			System.out.println("수정 실패");
			model.addAttribute("errorMsg", "수정에 실패했습니다.");
			// 수정 실패 시 원래 페이지로 이동
			return "redirect:host_apply_detail.do?hb_idx=" + vo.getHb_idx();
		}
	}

	// host 삭제
	@RequestMapping("apply_del.do")
	public String applyDel(HobeeVO vo) {
		int res = hobeedao.hostDel(vo.getHb_idx());
		return "redirect:host_list.do";
	}

	// 호스트 검색
	@RequestMapping("host_search.do")
	public String applySch(
	        @RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
	        @RequestParam(defaultValue = "10") int itemsPerPage, // 페이지당 항목 수 기본값 10
	        String search_text, String search_category, Model model) {

	    List<HobeeVO> search_list = null;

	    // 검색 카테고리에 따라 다른 조회 메서드 호출
	    if ("title".equals(search_category)) {
	        // 타이틀 검색
	        search_list = hobeedao.searchByTitle(search_text);
	    } else if ("content".equals(search_category)) {
	        // 내용 검색
	        search_list = hobeedao.searchByContent(search_text);
	    } else {
	        // 전체 검색
	        search_list = hobeedao.searchByAll(search_text);
	    }

	    // 페이징 처리 계산
	    int totalItems = search_list.size(); // 총 항목 수
	    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수
	    int start = (page - 1) * itemsPerPage; // 시작 인덱스
	    int end = Math.min(start + itemsPerPage, totalItems); // 끝 인덱스
	    List<HobeeVO> paginatedList = search_list.subList(start, end);

	    // 시작 idx 계산 (전체 데이터 기준으로 줄어드는 번호 계산)
	    int startIdx = totalItems - (page - 1) * itemsPerPage;

	    // Model 객체에 데이터 추가
	    model.addAttribute("apply_list", paginatedList); // 페이징 처리된 데이터
	    model.addAttribute("currentPage", page); // 현재 페이지
	    model.addAttribute("totalPages", totalPages); // 총 페이지 수
	    model.addAttribute("totalItems", totalItems); // 총 항목 수
	    model.addAttribute("startIdx", startIdx); // 시작 idx 전달
	    model.addAttribute("search_text", search_text); // 검색어 전달
	    model.addAttribute("search_category", search_category); // 검색 카테고리 전달

	    return Common.VIEW_PATH + "host/host_list.jsp";
	}
	
	//호스트 네임 중복 체크 처리
	@ResponseBody
	@RequestMapping("/check_host_duplicate.do")
	public String checkDuplicate(String host_name) {
		String duplicateCheck = users_dao.hostname_check(host_name);
		if ("1".equals(duplicateCheck)) {
			return "fail";
		} else if ("0".equals(duplicateCheck)) {
			return "true";
		} else {
			return "unknown";
		}
	}
	
	@RequestMapping("add_host.do")
	@ResponseBody
	public String hostadd(HostVO vo, Model model) {
	    try {
	        String webPath = "/resources/images/upload/"; // 상대경로
	        String savePath = application.getRealPath(webPath); // 절대경로

	        System.out.println("절대경로:" + savePath);
	        System.out.println("hostfilename : " + vo.getHost_image_filename());

	        // 업로드를 위한 파일 정보 처리
	        hostImgUpload(vo.getHost_image_filename(), savePath, "host_img", vo);
	        
	        // DAO를 통해 데이터 삽입
	        int res = host_dao.hostadd(vo);
	        System.out.println("삽입 결과: " + res);

	        if (res > 0) {
	            return "success";
	        } else {
	            return "fail";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "fail";
	    }
	}
	
	// 파일 업로드
		private void hostImgUpload(MultipartFile file, String savePath, String fieldName, HostVO vo) {
			String filename = null;

			if (file != null && !file.isEmpty()) {
				filename = file.getOriginalFilename();

				// 저장 경로 디렉터리 생성
				File directory = new File(savePath);
				if (!directory.exists()) {
					directory.mkdirs();
				}

				// 기존 파일 삭제
				deleteExistingFile(savePath, vo.getHost_img());

				// 중복 파일 이름 처리
				File saveFile = new File(savePath, filename);
				if (saveFile.exists()) {
					long time = System.currentTimeMillis();
					filename = String.format("%d_%s", time, filename);
					saveFile = new File(savePath, filename);
				}

				try {
					file.transferTo(saveFile);
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				// 파일이 없을 경우 기존 파일 이름 유지
				filename = vo.getHost_img();
			}
			System.out.println("필드이름:"+fieldName);
			// VO에 파일 이름 설정
			if ("host_img".equals(fieldName)) {
				vo.setHost_img(filename);
			}

			System.out.println(fieldName + " 파일이름: " + vo.getHost_img());
		}
		
		@RequestMapping("/host_modify.do")
		public String hostmodify(HostVO vo) {
			String webPath = "/resources/images/upload/"; // 상대경로
			String savePath = application.getRealPath(webPath); // 절대경로

			System.out.println("절대경로: " + savePath);

			// 업로드된 파일 처리
			hostImgUpload(vo.getHost_image_filename(), savePath, "host_img", vo);
			
			// 데이터 수정 처리
			int res = host_dao.modify(vo);
				System.out.println("수정 성공");
				// 수정 후 상세 페이지로 리다이렉트
				return "redirect:host_main.do";
			
		}
	

}