package com.dao;

import java.util.List;
import java.util.Date;
import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;

public interface ShowtimeInfoDAO {
	
    public ShowtimeInfo getshowtimeId(Integer showtimeId);
    
	public List<ShowtimeInfo> getAll();
	
	public List<Date> getPlaydatesById(Integer movieId);
    
    public List<ShowtimeInfo> getShowtimeByPlaydate(Integer movieId, Date playdate);
    
    public List<ShowtimeInfo> getDate(Screen screen, Date[] playdate, Movie movie);	
    

}