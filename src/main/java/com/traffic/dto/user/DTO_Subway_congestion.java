package com.traffic.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DTO_Subway_congestion {
	
	private int statn_id;
	private int statn_link;
	private double congest;
	
	private double time8;
	private double time9;
	private double time18;
	private double time19;
	
	
	private String week;
	private int route;
	private String statn_nm;
	private String in_outway;
	
	
}
