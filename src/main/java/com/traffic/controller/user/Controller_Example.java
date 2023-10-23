package com.traffic.controller.user;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.traffic.service.Interface_TrafficService;

@Controller
@RequestMapping("user")
public class Controller_Example {
	
	Interface_TrafficService trafficservice = null;
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("example")
	public String couponlist(Model model, HttpServletRequest request) {
		
		return "traffic/example";

	}
	
	
}
