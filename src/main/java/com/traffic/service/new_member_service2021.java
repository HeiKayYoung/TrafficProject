package com.traffic.service;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Bike;
import com.traffic.dto.user.DTO_Bike;

public class new_member_service2021 implements Interface_TrafficService {

	private SqlSession sqlSession;

	public new_member_service2021(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println("New Member Service 2021");

		IDao_Bike dao = sqlSession.getMapper(IDao_Bike.class);
		List<Integer> month = new ArrayList();

		List<DTO_Bike> dtos = dao.new_member2021();

		for (int i = 1; i <= 12; i++) {
			boolean found = false;

			// 議고쉶�맂 �뜲�씠�꽣 以묒뿉�꽌 �빐�떦 �썡 �뜲�씠�꽣瑜� 李얠쓬
			for (DTO_Bike dto : dtos) {
				int monthly = dto.getJoin_month();
				if (monthly == i) {
					month.add(dto.getTot_join());
					found = true;
					break;
				}
			}
			if (!found) {
				month.add(0);
			}
		}
		model.addAttribute("month", month);
	}
}
