package com.traffic.service;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.traffic.dao.user.IDao_CarAccident_Chart;
import com.traffic.dto.user.DTO_Traffic_CarAccident;

public class Service_CarAccident_EventInfo implements Interface_TrafficService{

	// 국가교통정보센터 -> 공사/사고정보 api
	private IDao_CarAccident_Chart dao;
	private String api_Key;
		
	public Service_CarAccident_EventInfo(SqlSession sqlSession, String api_Key) {
		this.dao = sqlSession.getMapper(IDao_CarAccident_Chart.class);
		this.api_Key = api_Key;
	}
	
	
	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
		
	@Override
	public void execute(Model model) {
		
		try {
			
			Map<String, Object> map = model.asMap();
			HttpServletRequest request = (HttpServletRequest)map.get("request");
			
			String type = request.getParameter("type") != null ? request.getParameter("type") : "all";
			String eventType = request.getParameter("eventType") != null ? request.getParameter("eventType") : "acc";
			
			String API_url = "https://openapi.its.go.kr:9443/eventInfo?apiKey=" + api_Key + "&type=" + type + "&eventType=" + eventType + "&minX=124.000000&maxX=132.000000&minY=33.000000%20&maxY=43.000000&getType=xml";
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(API_url);
			
			List<DTO_Traffic_CarAccident> list = new ArrayList<DTO_Traffic_CarAccident>();
			
			doc.getDocumentElement().normalize();
			
			// 파싱할 tag
			NodeList nList = doc.getElementsByTagName("item");
			
			Map<String, String> nodeValues = null;
			
			for(int temp = 0; temp < nList.getLength(); temp++){
				
				nodeValues = new HashMap<String, String>();
				
				Node nNode = nList.item(temp);
				
				if(nNode.getNodeType() == Node.ELEMENT_NODE)
				{
					Element eElement = (Element) nNode;
					NodeList childnodes = eElement.getChildNodes();
					
					for(int temp2 = 0; temp2 < childnodes.getLength(); temp2++){
						
						Node childNode = childnodes.item(temp2);
						
						if(nNode.getNodeType() == Node.ELEMENT_NODE)
						{
							Element childNodeElements = (Element) childNode;
							
							String nodeKey = childNodeElements.getNodeName();
							String nodeValue = getTagValue(childNodeElements.getNodeName(), eElement);

							nodeValues.put(nodeKey, nodeValue);
						}
					}
				}
				
				DTO_Traffic_CarAccident dto = returnDTO(new DTO_Traffic_CarAccident(), nodeValues);
				list.add(dto);
			}
			
			model.addAttribute("list", list);
			model.addAttribute("type", type);
			model.addAttribute("eventType", eventType);
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		
	}
	
	public <T> T returnDTO(T vo, Map<String, String> nodeValueMap)
	{
		try {
			
			String className = vo.getClass().getName();
			Class<?> cls = Class.forName(className);
			Method methods[] = cls.getDeclaredMethods();
			
			Set<String> keySet = nodeValueMap.keySet();
			
			boolean isDataInserted = false;
			
	        for (String key : keySet) {
	        	
	        	String nodeKey = key.toLowerCase();
	            String nodeValue = nodeValueMap.get(key);
	            
				for(int j = 0; j < methods.length; j++)
				{
					String DTO_methodName = methods[j].getName();
					
					if(! DTO_methodName.toLowerCase().contains("set")) {
						continue;
					}
					
					if(methods[j].getName().toLowerCase().contains(nodeKey)) {
						methods[j].invoke(vo, String.valueOf(nodeValue));
						isDataInserted = true;
						break;
					}
				}
	        }
			
	       return isDataInserted == true ? vo : null;
		} 
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
}
