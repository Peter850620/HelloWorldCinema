package com.service;

import java.util.List;

import com.dao.ScreenDAO;
import com.dao.ScreenDAOImpl;
import com.entity.Screen;

public class ScreenServicePeter {
	private ScreenDAO dao;
	
	public ScreenServicePeter() {
		dao = new ScreenDAOImpl();
	}
	
	public List<Screen> getScreenId() {
		return dao.getAll();
	}
	
	public Screen getSeatNo(Integer screenId) {
		return dao.findByPrimaryKey(screenId);
	}
}
