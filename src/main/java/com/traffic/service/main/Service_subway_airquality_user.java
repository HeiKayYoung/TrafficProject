package com.traffic.service.main;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Subway;
import com.traffic.dto.user.DTO_Subway;

public class Service_subway_airquality_user implements  Interface_Traffic_main_Service  {
	private SqlSession sqlSession;

	public Service_subway_airquality_user(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	@Override
	public void execute(Model model) {
		IDao_Subway dao = sqlSession.getMapper(IDao_Subway.class);
		
		JSONArray arr = new JSONArray();
		ArrayList<DTO_Subway> dto = dao.airqulity();
		
		for (DTO_Subway dto_Subway : dto) {
			
			JSONObject obj = new JSONObject();
			System.out.println(dto_Subway.getTotal() + ":" + dto_Subway.getS_co2());
			obj.put("total", dto_Subway.getTotal());
			obj.put("s_name", dto_Subway.getS_name());
			obj.put("s_line", dto_Subway.getS_line());
			obj.put("s_pdust", dto_Subway.getS_pdust());
			obj.put("s_co2", dto_Subway.getS_co2());
			obj.put("s_h2co", dto_Subway.getS_h2co());
			obj.put("s_co", dto_Subway.getS_co());
			if (obj != null) {
				arr.add(obj);
			}
			
		}
		
		
		model.addAttribute("arr",arr);
		
		JSONArray arrRow = new JSONArray();
		ArrayList<DTO_Subway> dtoRow = dao.airqulityRow();
		
		for (DTO_Subway dto_Subway : dtoRow) {
			
			JSONObject obj = new JSONObject();
			System.out.println("두번째"+dto_Subway.getTotal() + ":" + dto_Subway.getS_co2());
			obj.put("total", dto_Subway.getTotal());
			obj.put("s_name", dto_Subway.getS_name());
			obj.put("s_line", dto_Subway.getS_line());
			obj.put("s_pdust", dto_Subway.getS_pdust());
			obj.put("s_co2", dto_Subway.getS_co2());
			obj.put("s_h2co", dto_Subway.getS_h2co());
			obj.put("s_co", dto_Subway.getS_co());
			if (obj != null) {
				arrRow.add(obj);
			}
			
		}
		
		
		model.addAttribute("arrRow",arrRow);
		
		
	}
	
	
	
}
