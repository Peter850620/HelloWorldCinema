package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Report;

public interface ReportDAO {

	void insert(Report report);

	void update(Report report);
	
	int delete(Integer rptId);
	 
	Report getByReport(Integer rptId);
	
	List<Report> getAll();
	
	List<Report> getByCompositeQuery(Map<String, String> map);
	
	List<Report> getAll(int currentPage);
	
	long getTotal();
}
