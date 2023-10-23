package com.traffic.service;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class Service_CarAccident_CCTV {

	private HttpServletRequest request;
	private String apiKey;
	private Double coordx = null;
	private Double coordy = null;
	
	
	public Service_CarAccident_CCTV(String apiKey, HttpServletRequest request) {
		this.apiKey = apiKey;
		this.request = request;
	}

	public String resultCCTV_URL() {
		
		Double coordx = Double.parseDouble(request.getParameter("coordx"));
		Double coordy = Double.parseDouble(request.getParameter("coordy"));
		
		this.coordx = coordx;
		this.coordy = coordy;
		
		// 경도 범위 축소
		Double coordx_min = coordx - 0.03;
		Double coordx_max = coordx + 0.03;
		
		// 위도 범위 축소
		Double coordy_min = coordy - 0.03;
		Double coordy_max = coordy + 0.03;
		
		// 위도, 경도 범위 축소된 CCTV 리스트
		// 여기 나온 리스트들 중에서 가장 가까운 CCTV를 호출할것임..
		String url = "https://openapi.its.go.kr:9443/cctvInfo?apiKey=" + apiKey + "&type=ex&cctvType=2&minX=" + coordx_min +"&maxX=" + coordx_max +"&minY=" + coordy_min + "&maxY=" + coordy_max + "&getType=json";
		
		// coordx, coordy와 가까운 CCTV 정보 가져옴..
		String cctv_URL = result_CCTV_Info(url); 
		
		// cctv 주소를 보내줌..
		return cctv_URL;
		
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
	
	private String result_CCTV_Info(String url) {
		
        try{
        	
        	// { } : JSONObject
        	// [ ] : JSONArray
        	
        	InputStream is = new URL(url).openStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            
			String jsonText = jsonReadAll(br);
	        
	        JSONParser jsonParser = new JSONParser();
	        Object obj = jsonParser.parse(jsonText);
	        
	        JSONObject jsonObject = (JSONObject)obj;
	        JSONArray data = (JSONArray)((JSONObject)jsonObject.get("response")).get("data");
	        
	        // 근방의 CCTV 정보가 없다면 return;
	        if(data == null) {
	        	return "ERROR_NO_CCTVINFO";
	        }
	        
	        Map<String, String> json_map = null;
	        List<Double> list = new ArrayList<Double>();
	        
	        // 가장 가까운 CCTV 인덱스
	        int minData_index = -1;
	        
	        for (int i = 0; i < data.size(); i++) {
				
	        	// 근방의 CCTV 정보
	        	json_map = (Map<String, String>)data.get(i);
	        	
	        	Double cctv_latitude = Double.parseDouble(String.valueOf(json_map.get("coordx")));
	        	Double cctv_longitude = Double.parseDouble(String.valueOf(json_map.get("coordy")));
	        
	        	Double distance = getDistance(coordx, coordy, cctv_latitude, cctv_longitude);
	        	
	        	list.add(distance);
				
				if(distance.equals(Collections.min(list)))
				{
					minData_index = i;
				}
			}
	        
	        String cctv_url = ((Map<String, String>)data.get(minData_index)).get("cctvurl");
	        
	        return cctv_url;
        }
        catch(Exception ex)
        {
        	ex.printStackTrace();
        	return null;
        }
		
	}
	
	private Double getDistance(Double lat, Double lnt, Double lat2, Double lnt2) {
	    double theta = lnt - lnt2;
	    double dist = Math.sin(deg2rad(lat))* Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat))*Math.cos(deg2rad(lat2))*Math.cos(deg2rad(theta));
	    dist = Math.acos(dist);
	    dist = rad2deg(dist);
	    dist = dist * 60*1.1515*1609.344;

	    return dist / 1000;
	}

	
	//10진수를 radian(라디안)으로 변환
	private static double deg2rad(double deg){
	    return (deg * Math.PI/180.0);
	}
	
	//radian(라디안)을 10진수로 변환
	private static double rad2deg(double rad){
	    return (rad * 180 / Math.PI);
	}
	
}
