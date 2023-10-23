package com.traffic.dao.user;

import java.util.List;

import com.traffic.dto.user.DTO_Bike;

public interface IDao_Bike {

	public List<DTO_Bike> new_member2021();
	public List<DTO_Bike> new_member2022();
	public List<DTO_Bike> new_member2023();
	public List<DTO_Bike> ride_bike();
	public List<DTO_Bike> install_bike();
	public List<DTO_Bike> install_bike2(int year);
	public List<DTO_Bike> use_year_bike();
	public List<DTO_Bike> use_year_bike2(int year);
	public List<DTO_Bike> use_month_bike();
	public List<DTO_Bike> use_month_bike2(int year, int month);
	
	
}
