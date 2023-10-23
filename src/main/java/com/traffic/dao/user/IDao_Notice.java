package com.traffic.dao.user;

import java.util.List;

import com.traffic.dto.user.DTO_Notice;

public interface IDao_Notice {

	List<DTO_Notice> notice(String keyword, Integer rowStart, Integer rowEnd);
	public Integer pageCalculate(String keyword);
	public void uphit(String n_no);
	public DTO_Notice n_contentview(String n_no);
	List<DTO_Notice> review_list(String keyword, Integer rowStart, Integer rowEnd);
	public Integer pageCalculate_review(String keyword);
	public void uphit_review(String n_no);
	public void n_review_write(String n_title, String n_content);
	public DTO_Notice n_review_content(String n_no);
	public void n_review_update(String n_no, String n_title, String n_content);
}
