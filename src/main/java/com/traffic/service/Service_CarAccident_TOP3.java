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

import com.traffic.dao.user.IDao_CarAccident_TOP3;
import com.traffic.dto.user.DTO_Traffic_CarAccident;

public class Service_CarAccident_TOP3 implements Interface_TrafficService{

	// 도로교통공사 -> 지자체별 교통사고 TOP 3 -> API (JSON)으로 조회
	private IDao_CarAccident_TOP3 dao;
	private String api_Key;
	
	public Service_CarAccident_TOP3(SqlSession sqlSession, String api_Key) {
		
		this.dao = sqlSession.getMapper(IDao_CarAccident_TOP3.class);
		this.api_Key = api_Key;
		
	}
	
	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String searchYearCd = request.getParameter("searchYearCd") != null ?  request.getParameter("searchYearCd") : "2022";
		String sido = request.getParameter("sido") != null ? request.getParameter("sido") : "11";
		String gugun = request.getParameter("gugun") != null ? request.getParameter("gugun") : "";
		
		String API_url = "https://opendata.koroad.or.kr/data/rest/frequentzone/lg?authKey=" + api_Key + "&searchYearCd=" + searchYearCd + "&sido=" + sido + "&gugun=" + gugun + "&type=json";
		
		List<DTO_Traffic_CarAccident> yearType = dao.searchYearType();
		List<DTO_Traffic_CarAccident> firstType = dao.searchFirstType();
		List<DTO_Traffic_CarAccident> secondType = dao.searchSecondType(sido);
		
		// JSON 데이터를 List에 담아 가져옴..
		List<DTO_Traffic_CarAccident> list = readJsonFromUrl(API_url);
		
		model.addAttribute("list", list);
		
		model.addAttribute("yearSearchType", yearType);
		model.addAttribute("firstSearchType", firstType);
		model.addAttribute("secondSearchType", secondType);
		
		model.addAttribute("searchYearCd",searchYearCd);
		model.addAttribute("sido", sido);
		model.addAttribute("gugun", gugun);
	}

	private List<DTO_Traffic_CarAccident> readJsonFromUrl(String url) {
		
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
            
            for (int i = 0; i < data.size(); i++) {
				
            	DTO_Traffic_CarAccident dto = new DTO_Traffic_CarAccident();
            	Map<String, String> map = (Map<String, String>)data.get(i);
            	
            	dto.setSpot_nm(map.get("spot_nm"));
            	dto.setOccrrnc_cnt(String.valueOf(map.get("occrrnc_cnt")));
            	dto.setSl_dnv_cnt(String.valueOf(map.get("sl_dnv_cnt")));
            	dto.setSe_dnv_cnt(String.valueOf(map.get("se_dnv_cnt")));
            	dto.setDth_dnv_cnt(String.valueOf(map.get("dth_dnv_cnt")));
            	dto.setLo_crd(map.get("lo_crd"));
            	dto.setLa_crd(map.get("la_crd"));
            	
            	li.add(dto);
			}
            
            return li;
        }
        catch(Exception ex)
        {
        	ex.printStackTrace();
        	return null;
        }
		
	}
	
	private static String jsonReadAll(Reader reader) throws IOException{
        StringBuilder sb = new StringBuilder();

        int cp;
        while((cp = reader.read()) != -1){
            sb.append((char) cp);
        }

        return sb.toString();
    }
	
}
