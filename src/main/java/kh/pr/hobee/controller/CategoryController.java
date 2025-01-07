package kh.pr.hobee.controller;

import org.springframework.stereotype.Controller;

import kh.pr.hobee.dao.CategoryDAO;
import kh.pr.hobee.dao.HobeeDAO;

@Controller
public class CategoryController {
	
	CategoryDAO categoryDAO;

	public void setCategoryDAO(CategoryDAO categoryDAO) {
		this.categoryDAO = categoryDAO;
	}

	
	
}
