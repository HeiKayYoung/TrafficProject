package com.traffic.service.main;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Subway;
import com.traffic.dto.user.DTO_Subway_sabli_fac;

import kotlin.reflect.jvm.internal.impl.load.java.JavaClassFinder.Request;

public class Service_subway_disabil_fac implements  Interface_Traffic_main_Service  {
	private SqlSession sqlSession;

	public Service_subway_disabil_fac(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	@Override
	public void execute(Model model) {
		IDao_Subway dao = sqlSession.getMapper(IDao_Subway.class);
		
		Map<String, Object> map=model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		
		JSONArray evArr = new JSONArray();
		ArrayList<DTO_Subway_sabli_fac> ssafetyL = dao.ssabli_fac_ev();
		
		for (DTO_Subway_sabli_fac sabli_fac : ssafetyL) {
			System.out.println(sabli_fac.getCrdnt_x()+":"+sabli_fac.getCrdnt_y());
			JSONObject evObj = new JSONObject();
			
			evObj.put("evMapY", sabli_fac.getCrdnt_x());
			evObj.put("evMapX", sabli_fac.getCrdnt_y());
			if (evObj !=null) {
				evArr.add(evObj);
			}
		}
		model.addAttribute("evArr",evArr);
		
		
		
		JSONArray wlArr = new JSONArray();
		ArrayList<DTO_Subway_sabli_fac> ssafetyWl = dao.ssabli_fac_wl();
		
		for (DTO_Subway_sabli_fac sabli_fac : ssafetyWl) {
			System.out.println(sabli_fac.getCrdnt_x()+"::"+sabli_fac.getCrdnt_y());
			JSONObject wlObj = new JSONObject();
			
			wlObj.put("MapY", sabli_fac.getCrdnt_x());
			wlObj.put("MapX", sabli_fac.getCrdnt_y());
			if (wlObj !=null) {
				wlArr.add(wlObj);
			}
		}
		model.addAttribute("wlArr",wlArr);
		
		
		
		
		JSONArray bfArr = new JSONArray();
		ArrayList<DTO_Subway_sabli_fac> ssafetyBf = dao.ssabli_fac_bf();
		
		for (DTO_Subway_sabli_fac sabli_fac : ssafetyBf) {
			System.out.println(sabli_fac.getCrdnt_x()+":::"+sabli_fac.getCrdnt_y());
			JSONObject bfObj = new JSONObject();
			
			bfObj.put("MapY", sabli_fac.getCrdnt_x());
			bfObj.put("MapX", sabli_fac.getCrdnt_y());
			if (bfObj !=null) {
				bfArr.add(bfObj);
			}
		}
		model.addAttribute("bfArr",bfArr);
		
		
		
		
		JSONArray emArr = new JSONArray();
		ArrayList<DTO_Subway_sabli_fac> ssafetyEm = dao.ssabli_fac_em();
		
		for (DTO_Subway_sabli_fac sabli_fac : ssafetyEm) {
			System.out.println(sabli_fac.getCrdnt_x()+"::::"+sabli_fac.getCrdnt_y());
			JSONObject emObj = new JSONObject();
			
			emObj.put("MapY", sabli_fac.getCrdnt_x());
			emObj.put("MapX", sabli_fac.getCrdnt_y());
			if (emObj !=null) {
				bfArr.add(emObj);
			}
		}
		model.addAttribute("emArr",bfArr);
		
		
		//엘베검색키워드
		String searchEvKeyword=request.getParameter("sek");
		if (searchEvKeyword==null) {
			searchEvKeyword="";
		}
		//휠체어리프트검색키워드
		String searchWlKeyword=request.getParameter("swlk");
		if (searchWlKeyword==null) {
			searchWlKeyword="";
		}
		
		ArrayList<DTO_Subway_sabli_fac> ev_info = dao.ssabli_ev_info(searchEvKeyword);
		model.addAttribute("ev_info",ev_info);
		
		ArrayList<DTO_Subway_sabli_fac> wl_info = dao.ssabli_wl_info(searchWlKeyword);
		model.addAttribute("wl_info",wl_info);
		
		
		
	}
}
