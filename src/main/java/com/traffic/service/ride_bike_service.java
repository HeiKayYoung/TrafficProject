package com.traffic.service;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Bike;
import com.traffic.dto.user.DTO_Bike;

public class ride_bike_service implements Interface_TrafficService {

	private SqlSession sqlSession;

	public ride_bike_service(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
	    System.out.println("How To Ride Bike Service");
	    
	    IDao_Bike dao = sqlSession.getMapper(IDao_Bike.class);
	    List<DTO_Bike> dtos = dao.ride_bike();
	    
	    model.addAttribute("dto",dtos);
		
	}
}
