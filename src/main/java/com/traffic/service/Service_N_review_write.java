package com.traffic.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Notice;
import com.traffic.dto.user.DTO_Notice;

public class Service_N_review_write implements Interface_TrafficService {

	private SqlSession sqlSession;
	
	public Service_N_review_write(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	

	@Override
	public void execute(Model model) {
		System.out.println("execute n_review_write");
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		String n_title = request.getParameter("n_title");
		String n_content = request.getParameter("n_content");
		
		IDao_Notice dao = sqlSession.getMapper(IDao_Notice.class);
		
		dao.n_review_write(n_title, n_content);
	}

}
