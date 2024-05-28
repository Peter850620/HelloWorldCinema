package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Report;
import com.entity.Review;

public interface ReportDAO {

	void insert(Report report);

	void update(Report report);
	
	int delete(Integer rptId);
	 
	Report getByReport(Integer rptId);
	
	List<Report> getAll();
	
	List<Report> getByCompositeQuery(Map<String, String> map, int currentPage);
	
	int getMapTotal(Map<String, String>map);
	
	List<Report> getAll(int currentPage);
	
	List<Report> getByReview(Review reviewId);
	
	long getTotal();
}
