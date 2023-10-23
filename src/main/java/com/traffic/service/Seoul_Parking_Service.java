package com.traffic.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.traffic.dao.user.IDao_Seoul_Parking;
import com.traffic.dto.user.DTO_Seoul_Parking;
import com.traffic.usetools.SearchVO;

public class Seoul_Parking_Service implements Interface_TrafficService {
	
	IDao_Seoul_Parking dao;
	
	public Seoul_Parking_Service(SqlSession sqlSession) {
		dao = sqlSession.getMapper(IDao_Seoul_Parking.class);
	}

	@Override
	public void execute(Model model) {
		
		System.out.println("Seoul_Parking_Service");
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
		
		String searchType = request.getParameter("searchType") != null ? request.getParameter("searchType") : "1";
		String keyword = request.getParameter("keyword")  != null &&  ! request.getParameter("keyword").equals("")
				? request.getParameter("keyword") : "";

		System.out.println("page : "+currentPage);
		System.out.println("searchType : "+searchType);
		System.out.println("keyword : "+keyword);
		
		SearchVO vo = new SearchVO();
		vo.setPage(currentPage);
		vo.pageCalculate(dao.seoul_parking_paging(searchType, keyword));
		
		List<DTO_Seoul_Parking> seoul_parking = dao.seoul_parking(vo.getRowStart(), vo.getRowEnd(), searchType, keyword);
		
		model.addAttribute("vo", vo);
		model.addAttribute("searchType",searchType);
		model.addAttribute("keyword",keyword);
		model.addAttribute("seoul_parking",seoul_parking);
		model.addAttribute("pageStart", vo.getPageStart());
	    model.addAttribute("pageEnd", vo.getPageEnd());
		
	}

}
