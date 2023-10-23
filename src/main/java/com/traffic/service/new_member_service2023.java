package com.traffic.service;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Bike;
import com.traffic.dto.user.DTO_Bike;

public class new_member_service2023 implements Interface_TrafficService {

	private SqlSession sqlSession;

	public new_member_service2023(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
	    System.out.println("New Member Service 2023");

	    IDao_Bike dao = sqlSession.getMapper(IDao_Bike.class);
	    List<Integer> month = new ArrayList();
	    List<DTO_Bike> dtos = dao.new_member2023();

	    for (int i = 1; i <= 12; i++) {
	        boolean found = false;

	        // �빐�떦 �썡 �뜲�씠�꽣瑜� 李얠쓬
	        for (DTO_Bike dto : dtos) {
	            int monthly = dto.getJoin_month();
	            if (monthly == i) {
	                month.add(dto.getTot_join());
	                found = true;
	                break; // �빐�떦 �썡 �뜲�씠�꽣瑜� 李얠븯�쑝誘�濡� �뜑 �씠�긽 寃��깋�븯吏� �븡怨� 猷⑦봽瑜� 醫낅즺
	            }
	        }
	        if (!found) {
	        	month.add(0);
	        }
	    }
        model.addAttribute("month", month);
	}

}
