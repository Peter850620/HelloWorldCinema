package com.service;

import java.util.Date;
import java.util.List;

import com.dao.ShowtimeInfoDAO;
import com.dao.ShowtimeInfoDAOImpl;
import com.entity.ShowtimeInfo;

public class ShowtimeInfoService_13 {

	private ShowtimeInfoDAO dao;
	
	public ShowtimeInfoService_13() {
		dao = new ShowtimeInfoDAOImpl();
	}

    
    public List<Date> getPlaydatesById(Integer movieId) {
        return dao.getPlaydatesById(movieId);
    }

    public List<ShowtimeInfo> getShowtimeByPlaydate(Integer movieId, Date playdate){
        
        return dao.getShowtimeByPlaydate(movieId, playdate);
    }
}
