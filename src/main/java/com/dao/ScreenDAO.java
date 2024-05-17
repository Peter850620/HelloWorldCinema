package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Screen;

public interface ScreenDAO {
	
    public Screen findByPrimaryKey(Integer screenId);
    
	public List<Screen> getAll();
	
	
	int insert(Screen entity);

	int update(Screen entity);
	
	int delete(Integer screenId);
	
	
	 
	Screen getById(String screenId);
	
	
	
	List<Screen> getByCompositeQuery(Map<String, String> map);

}