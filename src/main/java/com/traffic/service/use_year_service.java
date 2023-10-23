package com.traffic.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Bike;
import com.traffic.dto.user.DTO_Bike;

public class use_year_service implements Interface_TrafficService {

	private SqlSession sqlSession;

	public use_year_service(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println("use bike year Service");

		IDao_Bike dao = sqlSession.getMapper(IDao_Bike.class);

		JSONArray arr = new JSONArray();

		for (int i = 1; i <= 12; i++) {
		    boolean found = false;
		    
		    List<DTO_Bike> months = dao.use_year_bike();
		    
		    for (DTO_Bike month : months) {
		        if (month.getMonth() == i) { 
		            JSONObject obj = new JSONObject();
		            obj.put("Date", i); 
		            if (month.getNum() == null) {
		                obj.put("Num", 0);
		            } else {
		                obj.put("Num", month.getNum());
		            }
		            arr.add(obj);
		            found = true;
		            break;
		        }
		    }
		    
		    if (!found) {
		        JSONObject obj = new JSONObject();
		        obj.put("Date", i); 
		        obj.put("Num", 0);
		        arr.add(obj);
		    }

		}
		System.out.println("arr : " + arr);
		model.addAttribute("arr", arr);
	}
}
