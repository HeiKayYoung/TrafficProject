package com.traffic.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_CarAccident_Chart;
import com.traffic.dto.user.DTO_Traffic_CarAccident;

public class Service_CarAccident_Percnt implements Interface_TrafficService{

	
	private IDao_CarAccident_Chart dao;
		
	public Service_CarAccident_Percnt(SqlSession sqlSession) {
		this.dao = sqlSession.getMapper(IDao_CarAccident_Chart.class);
	}

	@Override
	public void execute(Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String searchType = request.getParameter("searchType") != null ? request.getParameter("searchType") : "year";
		
		model.addAttribute("searchType", searchType);
		
		if(searchType.equals("year")) {
			
			String searchYearCd = request.getParameter("searchYearCd") != null ? request.getParameter("searchYearCd") : "2022";
			
			List<DTO_Traffic_CarAccident> searchYear = dao.searchYearType();
			List<DTO_Traffic_CarAccident> firstList = dao.searchAccidentYearType(searchYearCd);
			
			model.addAttribute("searchYearCd", searchYearCd);
			model.addAttribute("searchYear",searchYear);
			model.addAttribute("firstList", firstList); 
		}
		else {
			
			String searchAgeCd = request.getParameter("searchAgeCd") != null ? request.getParameter("searchAgeCd") : "12ºº¿Ã«œ";
			
			List<DTO_Traffic_CarAccident> searchAge = dao.searchAgeType();
			List<DTO_Traffic_CarAccident> secondList = dao.searchAccidentAgeType(searchAgeCd);
			model.addAttribute("searchAgeCd", searchAgeCd);
			model.addAttribute("searchAge",searchAge);
			model.addAttribute("secondList", secondList);
		}
		
	}

}
