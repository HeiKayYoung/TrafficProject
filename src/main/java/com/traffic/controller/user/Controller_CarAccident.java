package com.traffic.controller.user;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.traffic.service.Interface_TrafficService;
import com.traffic.service.Service_CarAccident_Chart;
import com.traffic.service.Service_CarAccident_EventInfo;
import com.traffic.service.Service_CarAccident_Percnt;
import com.traffic.service.Service_CarAccident_TOP3;

@Controller
@RequestMapping("user")
public class Controller_CarAccident {
	
	// ITS 국가교통정보센터 API
	// https://its.go.kr/opendata
	private final String ITS_api_key = "5b6b923e173a425bb0da8920ffb129df";
	
	// 도로교통공단 교통사고분석시스템 API
	// https://opendata.koroad.or.kr/api/
	private String KOROAD_api_key = "";
	
	
	Interface_TrafficService service = null;
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("caraccident_top3")
	public String caraccident_top3(HttpServletRequest request, Model model) {
		
		KOROAD_api_key = "5Ahr2L6aCfM90uisMTozbsfyG7BvpYUQz8Pd81%2FcKhUfS6UnILPn3drjCamCj8Kt";
		
		model.addAttribute("request", request);
        
		service = new Service_CarAccident_TOP3(sqlSession, KOROAD_api_key);
		service.execute(model);
		
		return "traffic/Traffic_CarAccident_TOP3";

	}
	
	@RequestMapping("caraccident_chart")
	public String caraccident_chart(HttpServletRequest request, Model model) {
		
		KOROAD_api_key ="QSenFKLoy%2FeGnBh0g8GgDbgA2zKKuRb8%2FxSNgdCj0ULJl9SYmQ%2F5Nqi1IKzIta%2BQ";
		
		model.addAttribute("request", request);
		
		service = new Service_CarAccident_Chart(sqlSession, KOROAD_api_key);
		service.execute(model);
		
		return "traffic/Traffic_CarAccident_Chart";
		
	}
	
	@RequestMapping("caraccident_eventinfo")
	public String caraccident_eventinfo(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
        
		service = new Service_CarAccident_EventInfo(sqlSession, ITS_api_key);
		service.execute(model);
		
		return "traffic/Traffic_CarAccident_EventInfo";
	}
	
	@RequestMapping("caraccident_percnt")
	public String caraccident_percnt(HttpServletRequest request, Model model) {
		
		// DB 데이터 사용
		model.addAttribute("request", request);
        
		service = new Service_CarAccident_Percnt(sqlSession);
		service.execute(model);
		
		return "traffic/Traffic_CarAccident_Percnt";
	}
}
