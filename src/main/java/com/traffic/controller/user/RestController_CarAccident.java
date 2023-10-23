package com.traffic.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.traffic.dao.user.IDao_CarAccident_Chart;
import com.traffic.dao.user.IDao_CarAccident_TOP3;
import com.traffic.dto.user.DTO_Traffic_CarAccident;
import com.traffic.service.Interface_TrafficService;
import com.traffic.service.Service_CarAccident_CCTV;

@RestController
@RequestMapping("user")
public class RestController_CarAccident {
	
	// 도로교통공단 교통사고분석시스템 API
	// https://opendata.koroad.or.kr/api/
	
	Interface_TrafficService service = null;
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("caraccident_top3_typechanged")
	public List<DTO_Traffic_CarAccident> caraccident_top3_typechanged(HttpServletRequest request, Model model) {
		
		String sido = request.getParameter("sido") != null ? request.getParameter("sido") : "11";
		
		IDao_CarAccident_TOP3 dao = sqlSession.getMapper(IDao_CarAccident_TOP3.class);
		
		List<DTO_Traffic_CarAccident> list = dao.searchSecondType(sido);
		
		return list;
	}
	
	@RequestMapping("caraccident_chart_typechanged")
	public List<DTO_Traffic_CarAccident> caraccident_chart_typechanged(HttpServletRequest request, Model model) {
		
		String sido = request.getParameter("sido") != null ? request.getParameter("sido") : "11";
		
		IDao_CarAccident_Chart dao = sqlSession.getMapper(IDao_CarAccident_Chart.class);
		
		List<DTO_Traffic_CarAccident> list = dao.searchChartSecondType(sido);
		
		return list;
	}
	
	@RequestMapping("caraccident_cctv")
	public String caraccident_cctv(HttpServletRequest request, Model model) {
		
		
		final String apiKey = "5b6b923e173a425bb0da8920ffb129df";
		
		Service_CarAccident_CCTV service = new Service_CarAccident_CCTV(apiKey, request);
		String cctv_url = service.resultCCTV_URL();
		
		return cctv_url;
	}
	
	
	
}
