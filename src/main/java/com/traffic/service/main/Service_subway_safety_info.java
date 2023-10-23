package com.traffic.service.main;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Subway;
import com.traffic.dto.user.DTO_Subway_sabli_fac;
import com.traffic.dto.user.DTO_Subway_safety;

public class Service_subway_safety_info implements  Interface_Traffic_main_Service  {
	private SqlSession sqlSession;

	public Service_subway_safety_info(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	@Override
	public void execute(Model model) {
		IDao_Subway dao = sqlSession.getMapper(IDao_Subway.class);
		
		ArrayList<DTO_Subway_safety> ssafetyL = dao.ssafety_info_list();
		
		
		model.addAttribute("ssafetyL",ssafetyL);
		
	}
}
