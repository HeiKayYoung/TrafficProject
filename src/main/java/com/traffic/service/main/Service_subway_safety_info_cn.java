package com.traffic.service.main;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Subway;
import com.traffic.dto.user.DTO_Subway_safety;

public class Service_subway_safety_info_cn implements  Interface_Traffic_main_Service  {
	private SqlSession sqlSession;

	public Service_subway_safety_info_cn(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	@Override
	public void execute(Model model) {
		IDao_Subway dao = sqlSession.getMapper(IDao_Subway.class);
		
		ArrayList<DTO_Subway_safety> ssafetyL = dao.ssafety_info_list();
		
//		model.addAttribute("ssafetyL",ssafetyL);
		
		

		 // DTO_Subway_safety 리스트를 번역 가능한 텍스트로 변환
        for (DTO_Subway_safety safety : ssafetyL) {
            String textToTranslate = safety.getSsafety_title();
            try {
                textToTranslate = URLEncoder.encode(textToTranslate, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                throw new RuntimeException("인코딩 실패", e);
            }

            String translatedText = translateText(textToTranslate);
            
         // Extract the translated text from the JSON response
            try {
				String translatedTitle = extractTranslatedText(translatedText);
				
				// 번역된 결과(translatedText)를 ssafety_title에 할당
				safety.setSsafety_title(translatedTitle);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
        }

        // 번역 결과를 모델에 추가
        model.addAttribute("ssafetyL", ssafetyL);

        
    }

    // 이하 코드는 API 호출을 수행하고 결과를 반환하는 메서드입니다.
    private String translateText(String textToTranslate) {
        String clientId = "NiL4Vu3NNrWIvLGeApm1"; // 애플리케이션 클라이언트 아이디값
        String clientSecret = "YLkNOeWdvw"; // 애플리케이션 클라이언트 시크릿값

        String apiURL = "https://openapi.naver.com/v1/papago/n2mt";

        Map<String, String> requestHeaders = new HashMap<String, String>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);

        String responseBody = post(apiURL, requestHeaders, textToTranslate);

        // responseBody가 번역 결과를 포함하므로 그 결과를 반환
        return responseBody;
    }

    private static String post(String apiUrl, Map<String, String> requestHeaders, String textToTranslate){
        HttpURLConnection con = connect(apiUrl);
        String postParams = "source=ko&target=zh-CN&text=" + textToTranslate; //원본언어: 한국어 (ko) -> 목적언어: 중국어 (zh-CN)
        try {
            con.setRequestMethod("POST");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            con.setDoOutput(true);
            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.write(postParams.getBytes());
                wr.flush();
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 응답
                return readBody(con.getInputStream());
            } else {  // 에러 응답
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }

    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }
    
	private String extractTranslatedText(String jsonResponse) {

		try {
			// JSON 파싱
			JSONObject json = new JSONObject(jsonResponse);

			// "result" 객체 내의 "translatedText" 추출
			JSONObject result = json.getJSONObject("message").getJSONObject("result");
			String translatedText = result.getString("translatedText");
			
			System.out.println("translatedText : "+translatedText);

			return translatedText;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}