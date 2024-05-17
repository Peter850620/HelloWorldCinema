package com.dao;

import java.util.List;


import com.entity.ShowtimeInfo;

public interface ShowtimeInfoDAO {
	
    public ShowtimeInfo getshowtimeId(Integer showtimeId);
    
	public List<ShowtimeInfo> getAll();

}