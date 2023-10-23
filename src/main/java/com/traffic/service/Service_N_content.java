package com.traffic.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Notice;
import com.traffic.dto.user.DTO_Notice;

public class Service_N_content implements Interface_TrafficService {

	private SqlSession sqlSession;
	
	public Service_N_content(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	

	@Override
	public void execute(Model model) {
		System.out.println("execute service n_content");
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		 
		String n_no = request.getParameter("n_no");
		System.out.println(n_no);
		IDao_Notice dao = sqlSession.getMapper(IDao_Notice.class);
		System.out.println(dao + "dao session");
		
		dao.uphit(n_no);
		System.out.println(dao + "uphit");
		
		DTO_Notice dto = dao.n_contentview(n_no);
		
		model.addAttribute("n_content", dto);
	}

}
