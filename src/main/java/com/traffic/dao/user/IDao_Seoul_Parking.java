package com.traffic.dao.user;

import java.util.List;
import java.util.Map;

import com.traffic.dto.user.DTO_Seoul_Ec_Charger;
import com.traffic.dto.user.DTO_Seoul_Parking;

public interface IDao_Seoul_Parking {

	public List<DTO_Seoul_Parking> seoul_parking(Integer rowStart, Integer rowEnd, String searchType, String keyword);

	public Integer seoul_parking_paging(String searchType, String keyword);

	public List<Map<String, Object>> seoul_parking_chart();

	public DTO_Seoul_Parking seoul_parking_view(String no);

	public Integer ec_charge_paging(String searchType, String keyword);

	public List<DTO_Seoul_Ec_Charger> ec_charge(Integer rowStart, Integer rowEnd,String searchType, String keyword);

	public DTO_Seoul_Ec_Charger ec_view(String title);

	public List<Map<String, Object>> seoul_EC_chart();

	public List<Map<String, Object>> seoul_free_parking_chart();

	public List<Map<String, Object>> seoul_not_free_parking_chart();

	public DTO_Seoul_Parking prev_next(String no);

	public DTO_Seoul_Ec_Charger ec_prev_next(String title);

}
