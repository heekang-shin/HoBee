package kh.pr.hobee.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.dao.HobeeDAO;
import kh.pr.hobee.dao.UsersDAO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.UsersVO;

@Controller
public class MainController {

	@Autowired
	HttpServletRequest request;
	
	UsersDAO users_dao;
	
	HobeeDAO hobeedao;
	public void setHobeedao(HobeeDAO hobeedao) {
		this.hobeedao = hobeedao;
	}
	
	
	  //메인페이지
	  @RequestMapping(value= {"/","main.do"}) 
	 public String mainPage(Model model, HttpSession session) {
	 List<HobeeVO> list = hobeedao.selectlist(); model.addAttribute("list", list);
	 UsersVO loggedInUser = (UsersVO) session.getAttribute("loggedInUser");

		if (loggedInUser != null) {
			model.addAttribute("user", loggedInUser);
		} else {
			model.addAttribute("user", null);
		}

	  return Common.VIEW_PATH + "main/main.jsp"; }
	
	
	//검색
		@RequestMapping("search.do")
		public String search(String search_text, Model model) {
		    // 파라미터가 없으면 기본값으로 빈 문자열을 설정합니다.
		    System.out.println("Search Text: " + search_text); // 로그로 검색어 확인
		    
		    List<HobeeVO> search_list = hobeedao.searchSelect(search_text);
		    model.addAttribute("search_list", search_list);
		    return Common.VIEW_PATH + "search/search.jsp";
		}
		
}

 