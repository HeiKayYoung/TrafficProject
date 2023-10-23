package com.traffic.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DTO_Subway {

	private String s_district;
	private String s_line;
	private String s_name;
	private double s_dust;
	private double s_pdust;
	private double s_co2;
	private double s_h2co;
	private double s_co;
	private double total;
}
