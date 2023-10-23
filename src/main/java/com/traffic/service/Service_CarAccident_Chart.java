package com.traffic.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_CarAccident_Chart;
import com.traffic.dto.user.DTO_Traffic_CarAccident;

public class Service_CarAccident_Chart implements Interface_TrafficService{

	// 도로교통공사 -> 지자체별 대상사고통계정보 -> API (JSON)으로 조회
	private IDao_CarAccident_Chart dao;
	private String api_Key;
		
	public Service_CarAccident_Chart(SqlSession sqlSession, String api_Key) {
		this.dao = sqlSession.getMapper(IDao_CarAccident_Chart.class);
		this.api_Key = api_Key;
	}
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String searchYearCd = request.getParameter("searchYearCd") != null ?  request.getParameter("searchYearCd") : "2022";
		String sido = request.getParameter("sido") != null ? request.getParameter("sido") : "1100";
		String gugun = request.getParameter("gugun") != null ? request.getParameter("gugun") : "1116";
		
		
		String API_url = "https://opendata.koroad.or.kr/data/rest/stt?authKey=" + api_Key + "&searchYearCd=" + searchYearCd + "&sido=" + sido + "&gugun=" + gugun + "&type=json";
		
		List<DTO_Traffic_CarAccident> yearType = dao.searchChartYearType();
		List<DTO_Traffic_CarAccident> firstType = dao.searchChartFirstType();
		List<DTO_Traffic_CarAccident> secondType = dao.searchChartSecondType(sido);
		
		// JSON 데이터를 List에 담아 가져옴..
		JSONArray list = readJsonFromUrl(API_url);
		
		model.addAttribute("list", list);
		
		model.addAttribute("yearSearchType", yearType);
		model.addAttribute("firstSearchType", firstType);
		model.addAttribute("secondSearchType", secondType);
		
		model.addAttribute("searchYearCd",searchYearCd);
		model.addAttribute("sido", sido);
		model.addAttribute("gugun", gugun);
	}
	
	private static String jsonReadAll(Reader reader){
		
		try {
			StringBuilder sb = new StringBuilder();

	        int cp;
	        while((cp = reader.read()) != -1){
	            sb.append((char) cp);
	        }

	        return sb.toString();
		}
		catch(Exception ex) {
			ex.printStackTrace();
			return null;
		}
    }
	
	private JSONArray readJsonFromUrl(String url) {
		
        try{
        	
        	// { } : JSONObject
        	// [ ] : JSONArray
        	
        	List<DTO_Traffic_CarAccident> li = new ArrayList<DTO_Traffic_CarAccident>();
        	
        	InputStream is = new URL(url).openStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            
			String jsonText = jsonReadAll(br);
	        
	        JSONParser jsonParser = new JSONParser();
	        Object obj = jsonParser.parse(jsonText);
	        
	        JSONObject jsonObject = (JSONObject)obj;
	        JSONArray data = (JSONArray)((JSONObject)jsonObject.get("items")).get("item");
	        
            
            Map<String, String> mp1 = (Map<String, String>)data.get(0);	
            
        	JSONArray arr = new JSONArray();
        	
        	// cnt_027_01 ~ cnt_027_07까지 추출 (자세한 내용은 DTO 참조)
        	for (int i = 1; i < 8; i++) {
        		
        		JSONObject obj1 = new JSONObject();
        		
        		String firstAbstractDataName = "cnt_027_0" + i;
        		
        		obj1.put("first_data", String.valueOf(mp1.get(firstAbstractDataName)));
        		arr.add(obj1);
        		
			}
        	
        	// cnt_014_01 ~ cnt_014_07까지 추출 (자세한 내용은 DTO 참조)
        	for (int i = 1; i < 5; i++) {
        		
        		JSONObject obj2 = new JSONObject();
        		String secondAbstractDataName = "cnt_014_0" + i;
        		
        		obj2.put("second_data", String.valueOf(mp1.get(secondAbstractDataName)));
        		arr.add(obj2);
			}
        	
            return arr;
        }
        catch(Exception ex)
        {
        	ex.printStackTrace();
        	return null;
        }
		
	}
	
	
	
}
