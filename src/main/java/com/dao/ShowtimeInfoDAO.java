package com.dao;


import java.sql.Time;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;

public interface ShowtimeInfoDAO {
	
    public ShowtimeInfo getshowtimeId(Integer showtimeId);
    

	
	public List<Date> getPlaydatesById(Integer movieId);
    
    public List<ShowtimeInfo> getShowtimeByPlaydate(Integer movieId, Date playdate);
    
    //	博雅 複合查詢
    public List<ShowtimeInfo> getDate(String screenId, Date playdate, Integer movieId);	
    
    // 博雅 檢查場次開始結束時間是否與其他場次重疊
    public List<ShowtimeInfo> checkTime(String screenId, Date playdate, Time showtime, Time sendtime);	

	
	int insert(ShowtimeInfo entity);

	int update(ShowtimeInfo rntity);
	
	int delete(Integer  showtimeId);
	 
	ShowtimeInfo getById(Integer  showtimeId);
	
	List<ShowtimeInfo> getAll();
	
	List<ShowtimeInfo> getByCompositeQuery(Map<String, String> map);
	
	List<ShowtimeInfo> getAll(int currentPage);
	
	long getTotal();
	
	public String starTime(Time starTime);
	

	


	String getSeatStatus(String showtimeId);
	
    

}