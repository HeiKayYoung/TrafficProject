package com.traffic.dao.user;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.traffic.dto.user.DTO_Cosine_Similarity_admin;
import com.traffic.dto.user.DTO_Subway;
import com.traffic.dto.user.DTO_Subway_congestion;
import com.traffic.dto.user.DTO_Subway_sabli_fac;
import com.traffic.dto.user.DTO_Subway_safety;

public interface IDao_Subway {

	public ArrayList<DTO_Subway> airqulity();
	public ArrayList<DTO_Subway> airqulityRow();
	public ArrayList<DTO_Subway_safety> ssafety_info_list();
	public void ssafety_info_detail_count(int ssafety_no);
	public DTO_Subway_safety ssafety_info_detail(int ssafety_no);
	
	public ArrayList<DTO_Subway_sabli_fac> ssabli_fac_ev();
	public ArrayList<DTO_Subway_sabli_fac> ssabli_fac_wl();
	public ArrayList<DTO_Subway_sabli_fac> ssabli_fac_bf();
	public ArrayList<DTO_Subway_sabli_fac> ssabli_fac_em();
	
	public ArrayList<DTO_Subway_sabli_fac> ssabli_ev_info(@Param("searchEvKeyword") String searchEvKeyword);
	public ArrayList<DTO_Subway_sabli_fac> ssabli_wl_info(@Param("searchWlKeyword") String searchWlKeyword);

	public ArrayList<DTO_Subway_congestion> scongestion_info(@Param("congesttime") String congesttime);
}
