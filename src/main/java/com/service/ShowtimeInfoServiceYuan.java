package com.service;

import java.util.Date;
import java.util.List;

import com.dao.ShowtimeInfoDAO;
import com.dao.ShowtimeInfoDAOImpl;
import com.entity.ShowtimeInfo;

public class ShowtimeInfoServiceYuan {

	private ShowtimeInfoDAO dao;
	
	public ShowtimeInfoServiceYuan() {
		dao = new ShowtimeInfoDAOImpl();
	}

    
    public List<Date> getPlaydatesById(Integer movieId) {
        return dao.getPlaydatesById(movieId);
    }

    public List<ShowtimeInfo> getShowtimeByPlaydate(Integer movieId, Date playdate){
        
        return dao.getShowtimeByPlaydate(movieId, playdate);
    }
}
