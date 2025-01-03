package kh.pr.hobee.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

	// 로그인 페이지로 이동
	@RequestMapping("host_login.do")
	public String hostList() {
		return Common.VIEW_PATH + "host/host_login.jsp";
	}

	// host_apply_form으로 이동
	@RequestMapping("host_apply_form.do")
	public String applyForm() {
		return Common.VIEW_PATH + "host/host_apply_form.jsp";
	}

	//host_apply_insert.do
	@RequestMapping("host_apply_insert.do")
	public String hostInsert(HobeeVO vo) {

		String webPath = "/resources/images/upload/"; // 상대경로
		String savePath = application.getRealPath(webPath);// 절대경로
		
		System.out.println("절대경로:" + savePath);

		// 업로드를 위한 파일 정보 가져오기
		MultipartFile photo = vo.getS_image_filename();
		String filename = "no_file";

		if (!photo.isEmpty()) {
			filename = photo.getOriginalFilename();

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
				photo.transferTo(saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		// 파일이름 저장
		vo.setS_image(filename);

		System.out.println("파일이름:" + filename);
		return Common.VIEW_PATH + "host/host_login.jsp";
	}

}
