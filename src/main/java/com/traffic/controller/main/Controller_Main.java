package com.traffic.controller.main;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.traffic.service.Interface_TrafficService;

@Controller
public class Controller_Main {
	
	@Autowired
	private SqlSession sqlSession;
	private Interface_TrafficService service;
	
	@RequestMapping(value = "main")
	public String main(HttpServletRequest request, Model model) {
		
		return "main/main_page";
	}
	
}
