package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.HomeAnn;

public interface HomeAnnDAO {

	int insert(HomeAnn entity);

	int update(HomeAnn entity);
	
	int delete(Integer annId);
	 
	HomeAnn getByHomeAnn(Integer annId);
	
	List<HomeAnn> getAll();
	
	List<HomeAnn> getByCompositeQuery(Map<String, String> map, int currentPage);
	
	int getMapTotal(Map<String, String>map);
	
	List<HomeAnn> getAll(int currentPage);
	
	long getTotal();
}
