package com.traffic.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Notice;
import com.traffic.dto.user.DTO_Notice;

public class Service_N_review_content implements Interface_TrafficService {

	private SqlSession sqlSession;
	
	public Service_N_review_content(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String n_no = request.getParameter("n_no");
		
		IDao_Notice dao = sqlSession.getMapper(IDao_Notice.class);
		
		dao.uphit_review(n_no);
		
		DTO_Notice dto = dao.n_review_content(n_no);
		
		model.addAttribute("n_review_content", dto);
	}

}
