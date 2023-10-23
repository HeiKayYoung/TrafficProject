package com.traffic.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Notice;
import com.traffic.dto.user.DTO_Notice;
import com.traffic.usetools.SearchVO;

public class Service_Notice implements Interface_TrafficService {
	
	private SqlSession sqlsession;
	
	public Service_Notice(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Override
	public void execute(Model model) {
		System.out.println("execute service notice");
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =  (HttpServletRequest) map.get("request");
		
		String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
		IDao_Notice dao = sqlsession.getMapper(IDao_Notice.class);
		
//		paging 처리
//		검색결과 유지 과정
		int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

		SearchVO vo = new SearchVO();
//		현재 페이지 구하는 식
		vo.setPage(currentPage);
		
//		검색한 결과의 갯수 구하는 식
		vo.pageCalculate(dao.pageCalculate(keyword));
		
		List<DTO_Notice> dto = dao.notice(keyword, vo.getRowStart(), vo.getRowEnd());
		
		model.addAttribute("dto", dto);
		model.addAttribute("keyword", keyword);
		model.addAttribute("vo", vo);

	}

}
