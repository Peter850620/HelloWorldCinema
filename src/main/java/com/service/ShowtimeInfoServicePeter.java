package com.service;

import java.sql.Time;
import java.sql.Date;
import java.util.List;

import com.dao.ShowtimeInfoDAO;
import com.dao.ShowtimeInfoDAOImpl;
import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;

public class ShowtimeInfoServicePeter {
	private ShowtimeInfoDAO dao;

	public ShowtimeInfoServicePeter() {
		dao = new ShowtimeInfoDAOImpl();
	}

	public ShowtimeInfo addShowtimeInfo(Screen screen, Date playdate, Movie movie, Time showtime, Time endtime, String seatStatus, String showtimeStatus) {
		ShowtimeInfo showtimeinfo = new ShowtimeInfo();

		showtimeinfo.setScreen(screen);
		showtimeinfo.setPlaydate(playdate);
		showtimeinfo.setMovie(movie);
		showtimeinfo.setShowtime(showtime);
		showtimeinfo.setEndtime(endtime);
		showtimeinfo.setSeatStatus(seatStatus);
		showtimeinfo.setShowtimeStatus(showtimeStatus);
		dao.insert(showtimeinfo);
		
		return showtimeinfo;
	}
	
		public ShowtimeInfo updateShowtimeInfo(Integer showtimeId, Screen screenId, Date playdate, Time showtime, Time endtime) {
			ShowtimeInfo showtimeinfo = dao.getById(showtimeId);
			
			showtimeinfo.setScreen(screenId);
			showtimeinfo.setPlaydate(playdate);
			showtimeinfo.setShowtime(showtime);
			showtimeinfo.setEndtime(endtime);
			dao.update(showtimeinfo);
			
			return showtimeinfo;
	}
	
	public ShowtimeInfo getById(Integer showtimeId){
		ShowtimeInfo showtimeInfo = dao.getshowtimeId(showtimeId);
		
		return showtimeInfo; 
	}
	
	public List<ShowtimeInfo> getDate(String screenId, Date playdate, Integer movieId) {
		return dao.getDate(screenId, playdate, movieId);
	}
	
	public List<ShowtimeInfo> checkShowtimeInfoTime(String screenId, Date playdate, Time showtime, Time endtime){
		return dao.checkTime(screenId, playdate, showtime, endtime);
		
	}
	
	public List<ShowtimeInfo> getAll() {
		return dao.getAll();
	}
}
