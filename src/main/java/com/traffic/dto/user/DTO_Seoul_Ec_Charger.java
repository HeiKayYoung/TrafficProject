package com.traffic.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DTO_Seoul_Ec_Charger {

	private String ec_city;
	private String ec_charge;
	private int ec_charge_id;
	private String ec_charge_type;
	private String ec_charge_facility;
	private String ec_charge_parking;
	private String ec_location;
	private String ec_state;
	private String ec_address;
	private String ec_time;
	private String ec_user;
	private String ec_kw;
	private String ec_facility2;
	private String ec_note;
	
	private String prevnum;
	private String prevtitle;
	private String nextnum;
	private String nexttitle;
	
}
