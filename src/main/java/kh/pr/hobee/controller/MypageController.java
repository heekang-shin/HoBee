package kh.pr.hobee.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kh.pr.hobee.common.BCryptPwd;
import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.MypageDAO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.ReserveVO;
import kh.pr.hobee.vo.UsersVO;

@Controller
public class MypageController {

	MypageDAO mypage_dao;

	BCryptPwd bcp;

	public void setBcp(BCryptPwd bcp) {
		this.bcp = bcp;
	}

	public void setMypage_dao(MypageDAO mypage_dao) {
		this.mypage_dao = mypage_dao;
	}

	// 찜목록 로그인한 사람이 찜한내역 가져오기
	@SuppressWarnings("null")
	@RequestMapping("/mypage_heart_form.do")
	public String heart(int user_Id, Model model) {

		// user_Id를 기반으로 heart_list 가져오기
		List<Integer> heart_list = mypage_dao.selectheart(user_Id);

		System.out.println(heart_list.size());
		System.out.println(heart_list);

		// ggim_list 초기화
		List<HobeeVO> ggim_list = new ArrayList<HobeeVO>();

		HobeeVO hvo;
		int k;

		// heart_list를 순회하며 ggim_list에 추가
		for (int i = 0; i < heart_list.size(); i++) {

			System.out.println(heart_list.get(i));

			k = heart_list.get(i);
			hvo = mypage_dao.selectggim(k);

			System.out.println("ㅋㅋ" + heart_list.get(i));

			ggim_list.add(hvo); // hvo 추가

			System.out.println("ㅎㅎ" + heart_list.get(i));
		}
		// ggim_list를 모델에 추가
		model.addAttribute("ggim_list", ggim_list);
		return Common.User.VIEW_PATH + "heart_list.jsp";
	}
	
	//신청내역 조회하기 
	@RequestMapping("/mypage_apply_form.do")
	public String apply(
	        @RequestParam(defaultValue = "1") int page, // 현재 페이지 기본값 1
	        @RequestParam(defaultValue = "3") int itemsPerPage, // 페이지당 항목 수 기본값 3
	        int user_Id,
	        Model model
	) {
	    // 신청 내역 ID 리스트 가져오기
	    List<Integer> apply_list = mypage_dao.select_apply(user_Id);

	    // 페이징 처리 계산
	    int totalItems = apply_list.size(); // 총 항목 수
	    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // 총 페이지 수

	    // 현재 페이지에 맞는 데이터 가져오기
	    int start = (page - 1) * itemsPerPage; // 시작 인덱스
	    int end = Math.min(start + itemsPerPage, totalItems); // 끝 인덱스
	    List<Integer> paginatedApplyList = apply_list.subList(start, end);

	    // HobeeVO와 ReserveVO를 병합할 데이터를 저장할 리스트
	    List<Map<String, Object>> apply_finish = new ArrayList<Map<String,Object>>();
	    
	    for (int reserve_id : paginatedApplyList) {
	        List<ReserveVO> reserveList = mypage_dao.select_reserve_info(reserve_id);

	        for (ReserveVO rvo : reserveList) {
	            HobeeVO hvo = mypage_dao.select_apply_two(rvo.getHb_idx());

	            if (hvo != null && rvo != null) {
	                String category_name = mypage_dao.select_category_name(hvo.getCategory_num());
	                Map<String, Object> combinedData = new HashMap<String,Object>();
	                combinedData.put("reserve_id", rvo.getReserve_id());
	                combinedData.put("reserve_date", rvo.getReserve_date());
	                combinedData.put("price", rvo.getPrice());
	                combinedData.put("category_name", category_name);
	                combinedData.put("hb_title", hvo.getHb_title());
	                combinedData.put("hb_date", hvo.getHb_date());

	                apply_finish.add(combinedData);
	            }
	        }
	    }

	    // Model 객체에 데이터 추가
	    model.addAttribute("apply_finish", apply_finish);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);

	    // JSP로 이동
	    return Common.User.VIEW_PATH + "group_apply_list.jsp";
	}

	// 신청내역 삭제하기
	@RequestMapping("/mypage_apply_delete.do")
	public String apply_delete(int reserve_id) {
		int res = mypage_dao.apply_delete(reserve_id);
		return "redirect:mypage_apply_form.do?user_Id=2";
	}

	// 수정을 위한 한명값 가지고오기
	@RequestMapping("/user_update_form.do")
	public String userupdate(Model model, int user_Id) {
		UsersVO vo = mypage_dao.userupdate(user_Id);
		model.addAttribute("vo", vo);
		return Common.User.VIEW_PATH + "user_modify_form.jsp";

	}

	// 유저정보 수정
	@RequestMapping("/user_update_fin.do")
	public String updateFin(UsersVO vo) {
		System.out.println(vo.getPwd_change());

		String encodePwd = bcp.encryption(vo.getPwd_change());
		vo.setPwd_change(encodePwd);

		System.out.println(vo.getPwd_change());
		int res = mypage_dao.updateFin(vo);
		return Common.User.VIEW_PATH + "user_modify_finish.jsp";

	}

	// 유저 삭제를 위한 한명 값 가지고오기
	@RequestMapping("/user_delete_form.do")
	public String userdelete(Model model, int user_Id) {
		UsersVO vo = mypage_dao.userdelete(user_Id);
		model.addAttribute("vo", vo);
		return Common.User.VIEW_PATH + "user_delete_form.jsp";
	}

	// 유저 삭제
	@RequestMapping("/mypage_user_delete.do")
	public String mypage_user_delete(UsersVO vo, String pwd_c) {
		// 비밀번호 비교
		boolean isValid = bcp.decryption(vo.getUser_pwd(), pwd_c);

		if (isValid) {
			// 비밀번호가 일치하면 사용자 삭제 수행
			int res = mypage_dao.mypage_user_delete(vo);

			// 삭제 성공 시 성공 페이지로 이동
			return Common.User.VIEW_PATH + "user_delete_finish.jsp";
		} else {
			// 비밀번호가 일치하지 않으면 실패 페이지로 이동
			return Common.User.VIEW_PATH + "user_delete_form.jsp";
		}
	}

}
