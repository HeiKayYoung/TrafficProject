package com.traffic.controller.user;

import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tech.db.DBConPostgres;
import com.traffic.dto.user.DTO_Subway_congestion;
import com.traffic.service.main.Interface_Traffic_main_Service;
import com.traffic.service.main.Service_scongestion_info;
import com.traffic.service.main.Service_subway_airquality_user;
import com.traffic.service.main.Service_subway_disabil_fac;
import com.traffic.service.main.Service_subway_safety_detail;
import com.traffic.service.main.Service_subway_safety_info;
import com.traffic.service.main.Service_subway_safety_info_cn;
import com.traffic.service.main.Service_subway_safety_info_en;

@Controller
@RequestMapping("user")
public class Controller_Subway {

	@Autowired
	private SqlSession sqlSession;
	private Interface_Traffic_main_Service service;

	@RequestMapping("/sairquality")
	public String sairquality(Model model) {

		service = new Service_subway_airquality_user(sqlSession);
		service.execute(model);

		return "traffic/sairquality";

	}

	@RequestMapping("/ssafety_info")
	public String ssafety_info(Model model) {

		service = new Service_subway_safety_info(sqlSession);
		service.execute(model);

		return "traffic/ssafety_info";

	}
	
	@RequestMapping("/ssafety_info_en")
	public String ssafety_info_en(Model model) {
		
		service = new Service_subway_safety_info_en(sqlSession);
		service.execute(model);
		
		return "traffic/ssafety_info_en";
		
	}
	
	@RequestMapping("/ssafety_info_cn")
	public String ssafety_info_cn(Model model) {
		
		service = new Service_subway_safety_info_cn(sqlSession);
		service.execute(model);
		
		return "traffic/ssafety_info_cn";
		
	}

	@RequestMapping("/ssafety_info_detail")
	public String ssafety_info_detail(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);

		service = new Service_subway_safety_detail(sqlSession);
		service.execute(model);

		return "traffic/ssafety_info_detail";

	}

	@RequestMapping("/s_info_disability_fac")
	public String s_info_disability_fac(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);

		service = new Service_subway_disabil_fac(sqlSession);
		service.execute(model);

		return "traffic/s_info_disability_fac";

	}

	@RequestMapping("/s_info_disability_fac_ev")
	public String s_info_disability_fac_ev(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);

		service = new Service_subway_disabil_fac(sqlSession);
		service.execute(model);

		return "traffic/s_info_disability_fac_ev";

	}

	@RequestMapping("/s_info_disability_fac_wl")
	public String s_info_disability_fac_wl(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);

		service = new Service_subway_disabil_fac(sqlSession);
		service.execute(model);

		return "traffic/s_info_disability_fac_wl";

	}
	
	@RequestMapping("/scongestion")
	public String scongestion(Model model, HttpServletRequest request) throws Exception {

		
		  model.addAttribute("request",request);
		  
		  service = new Service_scongestion_info(sqlSession); 
		  service.execute(model);
		  
//		insertLinkIdSpeed();

//		postres에 접속

			Connection connection = DBConPostgres.getConnection();

			Statement stmt = null;

			String sql = "";
			stmt = connection.createStatement();

			Map<String, Object> map = model.asMap();
			ArrayList<DTO_Subway_congestion> list = null;

			if (map.containsKey("conge_info")) {
				Object congeInfoObj = map.get("conge_info");

				if (congeInfoObj instanceof ArrayList<?>) {
					list = (ArrayList<DTO_Subway_congestion>) congeInfoObj;
				}
			}

			if (list != null) {
				for (DTO_Subway_congestion dto : list) {

					if (dto.getTime8() != 0) {
						sql = "update subway_line2 set congest='" + dto.getTime8() + "' where statn_link='"
								+ dto.getStatn_link() + "'";
					} else if (dto.getTime9() != 0) {
						sql = "update subway_line2 set congest='" + dto.getTime9() + "' where statn_link='"
								+ dto.getStatn_link() + "'";
					} else if (dto.getTime18() != 0) {
						sql = "update subway_line2 set congest='" + dto.getTime18() + "' where statn_link='"
								+ dto.getStatn_link() + "'";
					} else if (dto.getTime19() != 0) {
						sql = "update subway_line2 set congest='" + dto.getTime19() + "' where statn_link='"
								+ dto.getStatn_link() + "'";
					}
				
					System.out.println("UPDATE SUBWAY_LINE2 SET CONGEST controller=" + dto.getTime8() + " WHERE statn_link="
							+ dto.getStatn_link());
					System.out.println("UPDATE SUBWAY_LINE2 SET CONGEST controller=" + dto.getTime9() + " WHERE statn_link="
							+ dto.getStatn_link());
					System.out.println("UPDATE SUBWAY_LINE2 SET CONGEST controller=" + dto.getTime18() + " WHERE statn_link="
							+ dto.getStatn_link());
					System.out.println("UPDATE SUBWAY_LINE2 SET CONGEST controller=" + dto.getTime19() + " WHERE statn_link="
							+ dto.getStatn_link());

					stmt.executeUpdate(sql);

				}
			} else {
				// conge_info가 없거나 형변환 오류가 발생한 경우에 대한 처리
			}
		 
		 
		return "traffic/scongestion";

	}


}
