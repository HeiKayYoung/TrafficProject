package com.traffic.controller.user;

import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.traffic.service.Interface_TrafficService;
import com.traffic.service.Service_N_content;
import com.traffic.service.Service_N_review_content;
import com.traffic.service.Service_N_review_list;
import com.traffic.service.Service_N_review_update;
import com.traffic.service.Service_N_review_write;
import com.traffic.service.Service_Notice;

@Controller
@RequestMapping("user")
public class Controller_Notice {
	
	@Autowired
	private SqlSession sqlSession;
	
	Interface_TrafficService trafficservice;
	
	@RequestMapping("notice")
	public String notice(Model model, HttpServletRequest request) {
		
		System.out.println("notice()");
		trafficservice = new Service_Notice(sqlSession);
		model.addAttribute("request", request);
		trafficservice.execute(model);
		
		return "traffic/notice";
	}
	
	@RequestMapping("n_content")
	public String n_content(Model model, HttpServletRequest request) {
		
		System.out.println("n_content()");
		trafficservice = new Service_N_content(sqlSession);
		model.addAttribute("request", request);
		trafficservice.execute(model);
		
		
		return "traffic/n_content";
	}
	
	@RequestMapping("n_review_list")
	public String n_review(Model model, HttpServletRequest request) {
		
		System.out.println("n_review");
		trafficservice = new Service_N_review_list(sqlSession);
		model.addAttribute("request", request);
		trafficservice.execute(model);
		System.out.println(trafficservice);
		
		return "traffic/n_review_list";
	}
	
	@RequestMapping("n_review_write_view")
	public String n_review_write_view() {
		
		return "traffic/n_review_write_view";
	}
	
	@RequestMapping("n_review_write")
	public String n_review_write(Model model, HttpServletRequest request) {
		
		System.out.println("n_review_write");
		trafficservice = new Service_N_review_write(sqlSession);
		model.addAttribute("request", request);
		trafficservice.execute(model);
		
		return "redirect:n_review_list";
	}
	
	@RequestMapping("n_review_content")
	public String n_review_content(Model model, HttpServletRequest request) {
		
		System.out.println("n_review_content");
		trafficservice = new Service_N_review_content(sqlSession);
		model.addAttribute("request", request);
		trafficservice.execute(model);
		
		return "traffic/n_review_content";
	}
	
	@RequestMapping("n_review_update_form")
	public String n_review_update_form(Model model, HttpServletRequest request) {
		
		System.out.println("n_review_update_form");
		
		return "traffic/n_review_update_form";
	}
	
	@RequestMapping("n_review_update")
	public String n_review_update(Model model, HttpServletRequest request) {
		
		System.out.println("n_review_update");
		trafficservice = new Service_N_review_update(sqlSession);
		model.addAttribute("request", request);
		trafficservice.execute(model);
		
		return "redirect:n_review_list";
	}
//	@RequestMapping("download")
//	public String download(Model model, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//		
//		System.out.println("download");
//		String path=request.getParameter("p");
//		String fname=request.getParameter("f");
//		String n_no=request.getParameter("n_no");
//		
//		//down처리
//		response.setHeader("Content-Disposition",
//				"Attachment;filename="+URLEncoder.encode(fname,"utf-8"));
//		String attachPath="resources\\upload\\";
//		String realPath=request.getSession().getServletContext().getRealPath(attachPath)+"\\"+fname;
//		System.out.println("realpath: "+realPath);
//		
////		stream연결
//		FileInputStream fin=new FileInputStream(realPath);
//		ServletOutputStream sout=response.getOutputStream();
//		
//		byte[] buf=new byte[1024];
//		int size=0;
//		while ((size=fin.read(buf,0,1024))!=-1) {
//			sout.write(buf,0,size);
//		}
//		fin.close();
//		sout.close();
//		
//		return "notice?n_no="+n_no;
//	}
	
}
