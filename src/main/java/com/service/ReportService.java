package com.service;

import java.util.List;
import java.util.Map;

import com.entity.Report;
import com.entity.Review;

public interface ReportService {

	void addReport(Report report);
	
	void updateReport(Report report);
	
	void deleteReport(Integer rptId);
	
	Report getByReport(Integer rptId);
	
	List<Report> getAll();
	
	List<Report> getAllReports(int currentPage);
	
	int getPageTotal();
	
	List<Report> getByCompositeQuery(Map<String, String[]> map, int currentPage);
	
	int getCompositeQueryTotal(Map<String, String[]> map);
	
	void updateRelatedReport(Review review, String rptStatus);
}
