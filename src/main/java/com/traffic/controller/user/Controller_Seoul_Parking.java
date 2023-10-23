package com.traffic.controller.user;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.traffic.service.Interface_TrafficService;
import com.traffic.service.Seoul_EC_Chart_Service;
import com.traffic.service.Seoul_Electric_charge_View_Service;
import com.traffic.service.Seoul_Eletric_charge_Service;
import com.traffic.service.Seoul_Parking_Chart_Service;
import com.traffic.service.Seoul_Parking_Service;
import com.traffic.service.Seoul_Parking_View_Service;

@Controller
@RequestMapping("user")
public class Controller_Seoul_Parking {
	
	@Autowired
	private SqlSession sqlSession;
	private Interface_TrafficService service;
	
	@RequestMapping("parking")
	public String parking(Model model, HttpServletRequest request) {
		
		System.out.println("parking_controller");
		model.addAttribute("request",request);
		
		service = new Seoul_Parking_Service(sqlSession);
		service.execute(model);
		
		return "traffic/seoul_parking";
	}
	
	@RequestMapping("parking_view")
	public String parking_view(Model model, HttpServletRequest request) {
		
		System.out.println("parking_view_controller");
		model.addAttribute("request",request);
		
		service = new Seoul_Parking_View_Service(sqlSession);
		service.execute(model);
		
		return "traffic/seoul_parking_view";
	}
	
	@RequestMapping("electric_charge")
	public String electric_charge(Model model, HttpServletRequest request) {
		
		System.out.println("electric_charge_controller");
		model.addAttribute("request",request);
		
		service = new Seoul_Eletric_charge_Service(sqlSession);
		service.execute(model);
		
		return "traffic/seoul_electric_charge";
		
	}
	
	@RequestMapping("ec_view")
	public String ec_view(Model model, HttpServletRequest request) {
		
		System.out.println("ec_view_controller");
		model.addAttribute("request",request);
		
		service = new Seoul_Electric_charge_View_Service(sqlSession);
		service.execute(model);
		
		return "traffic/seoul_electric_charge_view";
		
	}
	
	@RequestMapping("map")
	public String map(Model model, HttpServletRequest request) {
		
		System.out.println("map_controller");
		model.addAttribute("request",request);
		
		service = new Seoul_Parking_Chart_Service(sqlSession);
		service.execute(model);
		
		return "traffic/seoul_parking_map";

	}
	
	@RequestMapping("ec_map")
	public String ec_map(Model model, HttpServletRequest request) {
		
		System.out.println("ec_map_controller");
		model.addAttribute("request",request);
		
		service = new Seoul_EC_Chart_Service(sqlSession);
		service.execute(model);
		
		return "traffic/seoul_ec_chager_map";

	}
	
	
}
