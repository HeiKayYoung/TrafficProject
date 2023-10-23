package com.traffic.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Seoul_Parking;
import com.traffic.dto.user.DTO_Seoul_Parking;

public class Seoul_Parking_View_Service implements Interface_TrafficService {
	
	IDao_Seoul_Parking dao;
	
	public Seoul_Parking_View_Service(SqlSession sqlSession) {
		dao = sqlSession.getMapper(IDao_Seoul_Parking.class);
	}

	@Override
	public void execute(Model model) {
		
		System.out.println("Seoul_Parking_View_Service");
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String no = request.getParameter("no");
		System.out.println("no : "+no);
		
		DTO_Seoul_Parking seoul_parking_view = dao.seoul_parking_view(no);
		
		// �씠�쟾湲�, �떎�쓬湲�
		DTO_Seoul_Parking prev_next = dao.prev_next(no);
		model.addAttribute("prev_next",prev_next);
		
		String latitude = seoul_parking_view.getP_latitude();
		String hardness = seoul_parking_view.getP_hardness();
		
		System.out.println("latitude : "+latitude);
		System.out.println("hardness : "+hardness);
		
		model.addAttribute("seoul_parking_view",seoul_parking_view);
		model.addAttribute("latitude",latitude);
		model.addAttribute("hardness",hardness);
		
	}

}
