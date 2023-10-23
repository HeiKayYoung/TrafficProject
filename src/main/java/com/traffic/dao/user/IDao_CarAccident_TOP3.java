package com.traffic.dao.user;

import java.util.List;

import com.traffic.dto.user.DTO_Traffic_CarAccident;

public interface IDao_CarAccident_TOP3 {

	List<DTO_Traffic_CarAccident> searchFirstType();

	List<DTO_Traffic_CarAccident> searchSecondType(String sido);

	List<DTO_Traffic_CarAccident> searchYearType();

	
}
