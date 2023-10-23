package com.traffic.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DTO_Subway_sabli_fac {
	
	private int statn_id;
	private String statn_nm;
	private String route;
	private String statn_ev;
	private String statn_wl;
	private String statn_em;
	private String statn_bf;
	
	
	private double crdnt_y;
	private double crdnt_x;
	
	private String ev_nv;
	private String ev_loca;
	private String ev_ml;
	
	private String wl_nv;
	private String wl_loca;
	private String wl_ml;
	
	
}
