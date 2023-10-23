package com.traffic.controller.user;

import java.util.List;

import javax.servlet.ServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.traffic.dao.user.IDao_Bike;
import com.traffic.dto.user.DTO_Bike;

@RestController
@RequestMapping("/refresh")
public class RestController_bike {

	@Autowired
	private SqlSession session;
	
	@GetMapping("/year")
	
	public JSONArray execute(ServletRequest request, Model model) {
		System.out.println("Install_Bike RestController");
		
		IDao_Bike dao = session.getMapper(IDao_Bike.class);
		int year = Integer.parseInt(request.getParameter("yearSelect"));
		
		JSONArray arr = new JSONArray();

		for (int i = 1; i <= 12; i++) {
		    boolean found = false;
		    
		    List<DTO_Bike> months = dao.install_bike2(year);
		    System.out.println("year : "+year);
		    
		    for (DTO_Bike month : months) {
		        if (month.getMonth() == i) { 
		            JSONObject obj = new JSONObject();
		            obj.put("Date", i); 
		            if (month.getCount() == null) {
		                obj.put("Count", 0);
		            } else {
		                obj.put("Count", month.getCount());
		            }
		            arr.add(obj);
		            found = true;
		            break;
		        }
		    }
		    
		    if (!found) {
		        // If data for the month was not found, add 0 to the JSON array
		        JSONObject obj = new JSONObject();
		        obj.put("Date", i); // Use the loop counter as the month
		        obj.put("Count", 0);
		        arr.add(obj);
		    }

		}
		System.out.println("arr: "+arr);
		
		return arr;
    }
	@GetMapping("/use_year")
	
	public JSONArray use_year(ServletRequest request, Model model) {
		System.out.println("use year RestController");
		
		IDao_Bike dao = session.getMapper(IDao_Bike.class);
		int year = Integer.parseInt(request.getParameter("yearSelect"));
		
		JSONArray arr = new JSONArray();

		for (int i = 1; i <= 12; i++) {
		    boolean found = false;
		    
		    List<DTO_Bike> months = dao.use_year_bike2(year);
		    
		    for (DTO_Bike month : months) {
		        if (month.getMonth() == i) { 
		            JSONObject obj = new JSONObject();
		            obj.put("Date", i); 
		            if (month.getNum() == null) {
		                obj.put("Num", 0);
		            } else {
		                obj.put("Num", month.getNum());
		            }
		            arr.add(obj);
		            found = true;
		            break;
		        }
		    }
		    
		    if (!found) {
		        // If data for the month was not found, add 0 to the JSON array
		        JSONObject obj = new JSONObject();
		        obj.put("Date", i); // Use the loop counter as the month
		        obj.put("Num", 0);
		        arr.add(obj);
		    }

		}
		System.out.println("arr: "+arr);
		
		return arr;
    }
	
@GetMapping("/use_month")
	
	public JSONArray use_month(ServletRequest request, Model model) {
		System.out.println("use month RestController");
		
		IDao_Bike dao = session.getMapper(IDao_Bike.class);
		int year = Integer.parseInt(request.getParameter("yearSelect"));
		int month = Integer.parseInt(request.getParameter("monthSelect"));
		
		JSONArray arr = new JSONArray();

		System.out.println(year+"년 "+month+"월");

		    
		    List<DTO_Bike> dtos = dao.use_month_bike2(year, month);
		    
		    for (DTO_Bike dto : dtos) {
		   
		            JSONObject obj = new JSONObject();
	
		            obj.put("Date", dto.getDay()); 
		            		if (dto.getNum() == null) {
		            			obj.put("Num", 0);
		            		} else {
		            			obj.put("Num", dto.getNum());
		            		}
		            		arr.add(obj);
					}
		System.out.println("arr: "+arr);
		
		return arr;
    }
}
