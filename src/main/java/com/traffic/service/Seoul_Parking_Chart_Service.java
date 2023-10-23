package com.traffic.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Seoul_Parking;

public class Seoul_Parking_Chart_Service implements Interface_TrafficService {
	
	IDao_Seoul_Parking dao;
	
	public Seoul_Parking_Chart_Service(SqlSession sqlSession) {
		dao = sqlSession.getMapper(IDao_Seoul_Parking.class);
	}

	@Override
	public void execute(Model model) {
		
		System.out.println("Seoul_Parking_Chart_Service");
		
		List<Map<String, Object>> seoul_parking_chart_data = dao.seoul_parking_chart();
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("seoul_parking_chart_data", seoul_parking_chart_data);
		arr.add(obj); 

		model.addAttribute("arr", arr.toJSONString());
		
		List<Map<String, Object>> seoul_parking_chart_free_data = dao.seoul_free_parking_chart();
		
		JSONArray arr2 = new JSONArray();
		JSONObject obj2 = new JSONObject();
		obj2.put("seoul_parking_chart_free_data", seoul_parking_chart_free_data);
		arr2.add(obj2); 

		model.addAttribute("arr2", arr2.toJSONString());
		
		List<Map<String, Object>> seoul_parking_chart_not_free_data = dao.seoul_not_free_parking_chart();
		
		JSONArray arr3 = new JSONArray();
		JSONObject obj3 = new JSONObject();
		obj3.put("seoul_parking_chart_not_free_data", seoul_parking_chart_not_free_data);
		arr3.add(obj3); 
		
		model.addAttribute("arr3", arr3.toJSONString()); 
		
	}

}
