package com.dao;

import java.sql.Date;
import java.util.List;

import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;

public interface ShowtimeInfoDAO {
	public void insert(ShowtimeInfo showtimeinfo);
	public void update(ShowtimeInfo showtimeinfo);
	public void delete(Integer showtimeId);
    public ShowtimeInfo findByPrimaryKey(Integer showtimeId);
    public List<ShowtimeInfo> getDate(Screen screen, Date[] playdate, Movie movie);	
    public List<ShowtimeInfo> getAll();	
}
