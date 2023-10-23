package com.traffic.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DTO_Traffic_CarAccident {
	
	private String code;
	private String codename;
	
	private String subcode;
	private String subcodename;
	
	// TOP 100
	private String spot_nm; 		// 사고다발지역 주소
	private String occrrnc_cnt;		// 총 사고건수
	private String sl_dnv_cnt;			// 총 경상자수
	private String se_dnv_cnt;			// 총 중상자수
	private String dth_dnv_cnt;		// 총 사망자수
	private String lo_crd;			// 위치 위도
	private String la_crd;			// 위치 경도
	
	////////////////////////////////////////////////////////////////////////////////////////
	
	
	// 비율
	private String cnt_027_01; // 과속
	private String cnt_027_02; // 중앙선 침
	private String cnt_027_03; // 신호위반
	private String cnt_027_04; // 안전거리 미확보
	private String cnt_027_05; // 안전운전 의무 불이행
	private String cnt_027_06; // 교차로 통행방법 위반
	private String cnt_027_07; // 보행자 보호의무 위반
	private String cnt_027_99; // 기타
	
	private String cnt_014_01; // 차대 사람
	private String cnt_014_02; // 차대 차
	private String cnt_014_03; // 차량 단독
	private String cnt_014_04; // 철길 건널목
	
	
	// 실시간 공사 / 사고 정보
	private String type;
	private String eventType;
	private String eventDetailType;
	private String startDate;
	private String coordX;
	private String coordY;
	private String linkId;
	private String roadName;
	private String roadNo;
	private String roadDrcType;
	private String lanesBlockType;
	private String lanesBlocked;
	private String message;
	private String endDate;
	
	
	// 
	private String year;
	private String age;
	private String injured_cnt;
	private String casualties_cnt;
	private String dead_cnt;
//	private String sum_injured_cnt;
//	private String sum_casualties_cnt;
//	private String sum_dead_cnt;
	
}
