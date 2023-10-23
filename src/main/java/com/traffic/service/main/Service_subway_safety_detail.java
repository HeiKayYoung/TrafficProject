package com.traffic.service.main;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Subway;
import com.traffic.dto.user.DTO_Subway_sabli_fac;
import com.traffic.dto.user.DTO_Subway_safety;

public class Service_subway_safety_detail implements  Interface_Traffic_main_Service  {
	private SqlSession sqlSession;

	public Service_subway_safety_detail(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	@Override
	public void execute(Model model) {
		
		Map<String, Object> map=model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		
		IDao_Subway dao = sqlSession.getMapper(IDao_Subway.class);
		
		int ssafety_no=Integer.parseInt(request.getParameter("ssafety_no"));
		
		dao.ssafety_info_detail_count(ssafety_no);
		DTO_Subway_safety ssL = dao.ssafety_info_detail(ssafety_no);
		
		
		model.addAttribute("ssL",ssL);
		
	}
}
