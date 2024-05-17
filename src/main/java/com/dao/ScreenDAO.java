package com.dao;

import java.util.List;


import com.entity.Screen;

public interface ScreenDAO {
	
    public Screen findByPrimaryKey(Integer screenId);
    
	public List<Screen> getAll();

}