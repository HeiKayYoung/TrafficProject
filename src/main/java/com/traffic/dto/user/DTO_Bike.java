package com.traffic.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DTO_Bike {

	private int join_date;
	private String join_age;
	private int tot_join;
	private int join_month;
	
	private int no;
	private String bikeimg;
	private String title;
	private String howride;
	
	private int year;
	private int month;
	private int day;
	private String count;
	private String num;
}
