package kh.pr.hobee.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.vo.HobeeVO;

@Controller
public class HostController {

	@Autowired // 파일 포함을 위해
	private ServletContext application;

	@Autowired
	private HttpServletRequest request;
	
	
	HobeeDAO hobeedao;

	public void setHobeedao(HobeeDAO hobeedao) {
		this.hobeedao = hobeedao;
	}

	/**/
	// 리스트 페이지로 이동
	@RequestMapping("host_list.do")
	public String hostList(Model model) {
		List<HobeeVO> apply_list = hobeedao.applyList();
		model.addAttribute("apply_list", apply_list);
		return Common.VIEW_PATH + "host/host_list.jsp";
	}

	// host_apply_form으로 이동
	@RequestMapping("host_apply_form.do")
	public String applyForm() {
		return Common.VIEW_PATH + "host/host_apply_form.jsp";
	}

	
	// host_apply_insert.do
	@RequestMapping("host_apply_insert.do")
	public String hostInsert(HobeeVO vo, Model model) {

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

		
		System.out.println("카테고리:"+ vo.getCategory_num());
		
		// DAO를 통해 데이터 삽입
		int res = hobeedao.insertFin(vo);
		System.out.println("삽입 결과: " + res);
		
		List<HobeeVO> apply_list = hobeedao.applyList();
		model.addAttribute("apply_list", apply_list);
		
		return Common.VIEW_PATH + "host/host_list.jsp";
	}
	

	private void handleFileUpload(MultipartFile file, String savePath, String fieldName, HobeeVO vo) {
	    String filename = null;

	    if (file != null && !file.isEmpty()) {
	        filename = file.getOriginalFilename();

	        // 기존 파일 삭제
	        if ("s_image".equals(fieldName) && vo.getS_image() != null) {
	            deleteExistingFile(savePath, vo.getS_image());
	        } else if ("l_image".equals(fieldName) && vo.getL_image() != null) {
	            deleteExistingFile(savePath, vo.getL_image());
	        } else if ("in_image".equals(fieldName) && vo.getIn_image() != null) {
	            deleteExistingFile(savePath, vo.getIn_image());
	        }

	        // 저장할 파일의 경로
	        File saveFile = new File(savePath, filename);

	        // 동일한 이름의 파일이 존재하면 중복 방지 처리
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
	        // 파일이 업로드되지 않으면 기존 파일명을 유지
	        if ("s_image".equals(fieldName)) {
	            filename = vo.getS_image();
	        } else if ("l_image".equals(fieldName)) {
	            filename = vo.getL_image();
	        } else if ("in_image".equals(fieldName)) {
	            filename = vo.getIn_image();
	        }
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

	
	private void deleteExistingFile(String savePath, String filename) {
	    if (filename != null && !filename.equals("no_file")) {
	        File existingFile = new File(savePath, filename);
	        if (existingFile.exists()) {
	            existingFile.delete();
	            System.out.println("Deleted File: " + filename);
	        }
	    }
	}

	
	//host 한개 조회
	@RequestMapping("host_apply_detail.do")
	public String applyList(int hb_idx, Model model) {
		HobeeVO vo = hobeedao.applyOne(hb_idx);
		model.addAttribute("vo",vo);
		return Common.VIEW_PATH + "host/host_apply_detail.jsp";
	}
	
	
	//host 한개 수정
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
	        return Common.VIEW_PATH + "host/host_list.jsp";
	    } else {
	        System.out.println("수정 실패");
	        model.addAttribute("errorMsg", "수정에 실패했습니다.");
	        // 수정 실패 시 원래 페이지로 이동
	        return "redirect:host_apply_detail.do?hb_idx=" + vo.getHb_idx();
	    }
	}

	
	
	
}