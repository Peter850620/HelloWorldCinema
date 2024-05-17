package com.service;

import java.util.List;

import com.dao.ShowtimeInfoDAO;
import com.dao.ShowtimeInfoDAOImpl;
import com.entity.Food;
import com.entity.ShowtimeInfo;

public class ShowtimeInfoService {
	private ShowtimeInfoDAO dao;

	public ShowtimeInfoService() {
		dao = new ShowtimeInfoDAOImpl();
	}

//	public ShowtimeInfo addfood() {
//		ShowtimeInfo showtimeinfo = new ShowtimeInfo();
//		
//		showtimeinfo.setMovie(null);
//	}
	
	public List<ShowtimeInfo> getAll() {
		return dao.getAll();
	}
}
