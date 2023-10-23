package com.traffic.service.main;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Subway;
import com.traffic.dto.user.DTO_Subway_congestion;

public class Service_scongestion_info implements  Interface_Traffic_main_Service  {
	private SqlSession sqlSession;

	public Service_scongestion_info(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	@Override
	public void execute(Model model) {
		IDao_Subway dao = sqlSession.getMapper(IDao_Subway.class);
		
		Map<String, Object> map=model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		


		
		//시간검색
		String congesttime=request.getParameter("congesttime");
		if (congesttime == null || congesttime.equals("") ) {
			congesttime="time8";
		}
		
		//시간검색 유지
		String time8 = "";
		String time9 = "";
		String time18 = "";
		String time19 = "";
		String tc8 = request.getParameter("congesttime");
		if (tc8 != null && tc8.equals("time8")) {
			time8 = tc8;
			model.addAttribute("congesttime", "time8");
		}
		String tc9 = request.getParameter("congesttime");
		if (tc9 != null && tc9.equals("time9")) {
			time9 = tc9;
			model.addAttribute("congesttime", "time9");
		}
		String tc18 = request.getParameter("congesttime");
		if (tc18 != null && tc18.equals("time18")) {
			time18 = tc18;
			model.addAttribute("congesttime", "time18");
		}
		String tc19 = request.getParameter("congesttime");
		if (tc19 != null && tc18.equals("time19")) {
			time19 = tc19;
			model.addAttribute("congesttime", "time19");
		}
		
		System.out.println("congest 볼까욤 :"+congesttime);
		
		ArrayList<DTO_Subway_congestion> conge_info = dao.scongestion_info(congesttime);
		
		
		//잘 불러오는지 확인
		for (DTO_Subway_congestion dto : conge_info) {

			if (dto.getTime8() != 0) {
				System.out.println("update subway_line2 set congest88='" + dto.getTime8() + "' where linkid='"
						+ dto.getStatn_link() + "'");
			} else if (dto.getTime18() != 0) {
				System.out.println("update subway_line2 set congest1010='" + dto.getTime18() + "' where linkid='"
						+ dto.getStatn_link() + "'");
			}
			
		}
	
		model.addAttribute("conge_info",conge_info);
		
		
	}
}
