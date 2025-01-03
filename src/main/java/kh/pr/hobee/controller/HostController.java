package kh.pr.hobee.controller;


import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.vo.HobeeVO;

@Controller
public class HostController {

	@Autowired // 자동주입
	private ServletContext application;

	@Autowired
	HttpServletRequest request;

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

	 // 폼 제출 및 파일 업로드 처리
    @RequestMapping("host_apply_insert.do")
    public String hostInsert(HobeeVO vo, Model model) {
    	
    	//파일업로드
    	String webPath ="resources/images/upload/";//상대경로
    	String savePath= application.getRealPath(webPath);//절대경로
    	System.out.println("절대경로:" + savePath);
    	
    	//파일업로드를 위한 파일 정보
    	MultipartFile s_image_filename = vo.getS_image_filename();
    	
    	String filename= "no_file";
    	File saveFile;
    	
    	//업로드를 하고자 하는 파일이 존재한다면
    	if(!s_image_filename.isEmpty()) {
    		filename = s_image_filename.getOriginalFilename();
    		
    		 saveFile = new File(savePath, filename);
    		
    		if(!saveFile.exists()) {
    			//파일이 없다면 파일 생성
    			saveFile.mkdirs();
    		}
    	}
    	
    	vo.setS_image_filename(s_image_filename);
    	System.out.println("썸네일 명:" + s_image_filename);
        return "main.do";
    }

    
	
	
	
	
}
