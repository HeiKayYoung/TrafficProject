package com.traffic.controller.user;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.traffic.service.Interface_TrafficService;
import com.traffic.service.install_bike_service;
import com.traffic.service.new_member_service2021;
import com.traffic.service.new_member_service2022;
import com.traffic.service.new_member_service2023;
import com.traffic.service.ride_bike_service;
import com.traffic.service.use_month_service;
import com.traffic.service.use_year_service;

@Controller
@RequestMapping("user")
public class Controller_bike {
	
	private Interface_TrafficService trafficservice;
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping(value = "new_mem21")
	public String new2021(Model model, HttpServletRequest request) {
	
	trafficservice = new new_member_service2021(sqlSession);
	trafficservice.execute(model);
	
	return "traffic/new_mem21";

	}
	@RequestMapping(value = "new_mem22")
	public String new2022(Model model, HttpServletRequest request) {
		
		trafficservice = new new_member_service2022(sqlSession);
		trafficservice.execute(model);
		
		return "traffic/new_mem22";
		
	}
	@RequestMapping(value = "new_mem23")
	public String new2023(Model model, HttpServletRequest request) {
		
		trafficservice = new new_member_service2023(sqlSession);
		trafficservice.execute(model);
		
		return "traffic/new_mem23";
	}
	@RequestMapping(value = "how_to_ride")
	public String howtoride(Model model, HttpServletRequest request) {
		
		trafficservice = new ride_bike_service(sqlSession);
		trafficservice.execute(model);
		
		return "traffic/ride_bike";
	}
	@RequestMapping(value = "install_bike")
	public String install_bike(Model model, HttpServletRequest request) {
		
		trafficservice = new install_bike_service(sqlSession);
		trafficservice.execute(model);
		
		return "traffic/install_bike";
	}
	@RequestMapping(value = "use_year_bike")
	public String use_year_bike(Model model, HttpServletRequest request) {
		
		trafficservice = new use_year_service(sqlSession);
		trafficservice.execute(model);
		
		return "traffic/use_year_bike";
	}
	@RequestMapping(value = "use_month_bike")
	public String use_month_bike(Model model, HttpServletRequest request) {
		
		trafficservice = new use_month_service(sqlSession);
		trafficservice.execute(model);
		
		return "traffic/use_month_bike";
	}

	
	
}
