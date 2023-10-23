package com.traffic.service;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Bike;
import com.traffic.dto.user.DTO_Bike;

public class new_member_service2022 implements Interface_TrafficService {

	private SqlSession sqlSession;

	public new_member_service2022(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println("New Member Service 2022");

        IDao_Bike dao = sqlSession.getMapper(IDao_Bike.class);
        List<Integer> month = new ArrayList();

        List<DTO_Bike> dtos = dao.new_member2022();
        for (DTO_Bike dto : dtos) {
			int member = dto.getTot_join();
			month.add(member);
		}
        model.addAttribute("month", month);
	}
}
