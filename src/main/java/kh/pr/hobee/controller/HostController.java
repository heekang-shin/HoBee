package kh.pr.hobee.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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

	// 호스트 프로그램 신청 디테일 이동
	@RequestMapping("host_apply_detail.do")
	public String hostApplyDetail(int hb_idx, Model model) {
		HobeeVO vo = hobeedao.applyOne(hb_idx);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH + "host/host_apply_detail.jsp";
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
			
			return Common.VIEW_PATH + "host/host_apply_fin.jsp";
		}
		

		private void handleFileUpload(MultipartFile file, String savePath, String fieldName, HobeeVO vo) {
			String filename = "no_file";

			if (file != null && !file.isEmpty()) {
				filename = file.getOriginalFilename();

				// 저장할 파일의 경로
				File saveFile = new File(savePath, filename);

				if (!saveFile.exists()) {
					saveFile.mkdirs();
				} else {
					// 동일한 이름의 파일이 존재한다면 현재 업로드 시간을 붙여서 중복을 방지
					long time = System.currentTimeMillis();
					filename = String.format("%d_%s", time, filename);
					saveFile = new File(savePath, filename);
				}

				// 파일을 절대경로에 생성, 복사본을 넣는 것이다.
				try {
					file.transferTo(saveFile);
				} catch (IOException e) {
					e.printStackTrace();
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

			System.out.println(fieldName + " 파일이름:" + filename);
		}
	
	
}
