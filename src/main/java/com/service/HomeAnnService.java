package com.service;

import java.util.List;
import java.util.Map;

import com.entity.HomeAnn;

public interface HomeAnnService {

	void addHomeAnn(HomeAnn homeAnn);
	
	void updateHomeAnn(HomeAnn homeAnn);
	
	void deleteHomeAnn(Integer annId);
	//X
	HomeAnn getByHomeAnn(Integer annId);
	
	List<HomeAnn> getAll();
	
	List<HomeAnn> getAllHomeAnns(int currentPage);
	
	int getPageTotal();
	
	List<HomeAnn> getByCompositeQuery(Map<String, String[]> map, int currentPage);
	
	int getCompositeQueryTotal(Map<String, String[]> map);
}
