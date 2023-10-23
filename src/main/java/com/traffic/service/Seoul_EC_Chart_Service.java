package com.traffic.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Seoul_Parking;

public class Seoul_EC_Chart_Service implements Interface_TrafficService {
	
	IDao_Seoul_Parking dao;
	
	public Seoul_EC_Chart_Service(SqlSession sqlSession) {
		dao = sqlSession.getMapper(IDao_Seoul_Parking.class);
	}

	@Override
	public void execute(Model model) {
		
		System.out.println("Seoul_EC_Chart_Service");
		
		List<Map<String, Object>> seoul_EC_chart_data = dao.seoul_EC_chart();
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("seoul_EC_chart_data", seoul_EC_chart_data);
		arr.add(obj); 

		model.addAttribute("arr", arr.toJSONString()); 
	}

}
