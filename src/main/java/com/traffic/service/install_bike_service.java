package com.traffic.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Bike;
import com.traffic.dto.user.DTO_Bike;

public class install_bike_service implements Interface_TrafficService {

	private SqlSession sqlSession;

	public install_bike_service(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println("Install Bike Service");

		IDao_Bike dao = sqlSession.getMapper(IDao_Bike.class);

		JSONArray arr = new JSONArray();

		for (int i = 1; i <= 12; i++) {
		    boolean found = false;
		    
		    List<DTO_Bike> months = dao.install_bike();
		    
		    for (DTO_Bike month : months) {
		        if (month.getMonth() == i) { 
		            JSONObject obj = new JSONObject();
		            obj.put("Date", i); 
		            if (month.getCount() == null) {
		                obj.put("Count", 0);
		            } else {
		                obj.put("Count", month.getCount());
		            }
		            arr.add(obj);
		            found = true;
		            break;
		        }
		    }
		    
		    if (!found) {
		        // If data for the month was not found, add 0 to the JSON array
		        JSONObject obj = new JSONObject();
		        obj.put("Date", i); // Use the loop counter as the month
		        obj.put("Count", 0);
		        arr.add(obj);
		    }

		}
		System.out.println("arr : " + arr);
		model.addAttribute("arr", arr);

	}
}
