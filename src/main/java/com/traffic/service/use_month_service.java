package com.traffic.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Bike;
import com.traffic.dto.user.DTO_Bike;

public class use_month_service implements Interface_TrafficService {

	private SqlSession sqlSession;

	public use_month_service(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println("use month bike Service");

		IDao_Bike dao = sqlSession.getMapper(IDao_Bike.class);

		JSONArray arr = new JSONArray();

		    List<DTO_Bike> months = dao.use_month_bike();
		    
		    for (DTO_Bike month : months) {
 
		            JSONObject obj = new JSONObject();
		            obj.put("Date", month.getDay()); 
		            if (month.getNum() == null) {
		                obj.put("Num", 0);
		            } else {
		                obj.put("Num", month.getNum());
		            }
		            arr.add(obj);
		        }
		    


		System.out.println("arr : " + arr);
		model.addAttribute("arr", arr);
	}
}
