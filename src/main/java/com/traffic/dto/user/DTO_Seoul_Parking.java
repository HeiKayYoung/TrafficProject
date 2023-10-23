package com.traffic.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DTO_Seoul_Parking {

	private String p_code;
	private String p_name;
	private String p_address;
	private String p_kind;
	private String p_kind_name;
	private String p_management;
	private String p_management_name;
	private String p_tel;
	private String p_data_agree;
	private String p_data;
	private String p_total_space;
	private String p_paid_and_free;
	private String p_paid_and_free_name;
	private String p_free_night_check;
	private String p_free_night;
	private String p_week_open_time;
	private String p_week_end_time;
	private String p_weekend_open_time;
	private String p_weekend_end_time;
	private String p_holiday_open_time;
	private String p_holiday_end_time;
	private String p_last_data_time;
	private String p_saturday_paid_and_free;
	private String a;
	private String p_holiday_paid_and_free;
	private String a2;
	private String p_month_price;
	private String a3;
	private String p_default_price;
	private String p_default_time_min;
	private String p_add_price;
	private String p_add_price_min;
	private String p_bus_default_price;
	private String p_bus_default_time_min;
	private String p_bus_add_time_min;
	private String p_bus_add_price;
	private String p_day_max_price;
	private String p_latitude;
	private String p_hardness;
	
	private int prevnum;
	private String prevtitle;
	private int nextnum;
	private String nexttitle;
	
}
