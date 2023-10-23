package com.traffic.dao.user;

import java.util.List;

import com.traffic.dto.user.DTO_Traffic_CarAccident;

public interface IDao_CarAccident_Chart {

	List<DTO_Traffic_CarAccident> searchChartFirstType();

	List<DTO_Traffic_CarAccident> searchChartSecondType(String sido);

	List<DTO_Traffic_CarAccident> searchChartYearType();

	List<DTO_Traffic_CarAccident> searchAccidentYearType(String searchYearCd);

	List<DTO_Traffic_CarAccident> searchAccidentAgeType(String searchAgeCd);

	List<DTO_Traffic_CarAccident> searchYearType();

	List<DTO_Traffic_CarAccident> searchAgeType();
	
}
