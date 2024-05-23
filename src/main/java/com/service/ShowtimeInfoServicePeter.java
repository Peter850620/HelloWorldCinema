package com.service;

import java.sql.Time;
import java.sql.Date;
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

	public ShowtimeInfo addShowtimeInfo(Screen screenId, Date playdate, Movie movieId, Time showtime, Time endtime, String seatStatus) {
		ShowtimeInfo showtimeinfo = new ShowtimeInfo();

		showtimeinfo.setScreen(screenId);
		showtimeinfo.setPlaydate(playdate);
		showtimeinfo.setMovie(movieId);
		showtimeinfo.setShowtime(showtime);
		showtimeinfo.setEndtime(endtime);
		showtimeinfo.setSeatStatus(seatStatus);
		dao.insert(showtimeinfo);
		
		return showtimeinfo;
	}
	
	public List<ShowtimeInfo> getDate(String screenId, Date playdate, Integer movieId) {
		return dao.getDate(screenId, playdate, movieId);
	}
	
	public List<ShowtimeInfo> getAll() {
		return dao.getAll();
	}
}
