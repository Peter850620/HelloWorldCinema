package com.service;

import java.util.Date;
import java.util.List;

import com.dao.ShowtimeInfoDAO;
import com.dao.ShowtimeInfoDAOImpl;
import com.entity.Food;
import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;

public class ShowtimeInfoServicePeter {
	private ShowtimeInfoDAO dao;

	public ShowtimeInfoServicePeter() {
		dao = new ShowtimeInfoDAOImpl();
	}

//	public ShowtimeInfo addfood() {
//		ShowtimeInfo showtimeinfo = new ShowtimeInfo();
//		
//		showtimeinfo.setMovie(null);
//	}
	
	public List<ShowtimeInfo> getDate(String screenId, Date playdate, Integer movieId) {
		return dao.getDate(screenId, playdate, movieId);
	}
	
	public List<ShowtimeInfo> getAll() {
		return dao.getAll();
	}
}
