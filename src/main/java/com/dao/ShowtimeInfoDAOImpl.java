package com.dao;

import java.util.Date;
import java.util.List;

import java.sql.Time;
import java.text.SimpleDateFormat;

import java.util.Locale;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;
import com.util.HibernateUtil;

public class ShowtimeInfoDAOImpl implements ShowtimeInfoDAO {

	private SessionFactory factory;

	public ShowtimeInfoDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public List<ShowtimeInfo> getAll() {
		List<ShowtimeInfo> list = getSession().createQuery("FROM ShowtimeInfo", ShowtimeInfo.class).list();
		return list;
	}

	@Override
	public ShowtimeInfo getshowtimeId(Integer showtimeId) {

		return getSession().get(ShowtimeInfo.class, showtimeId);
	}

	// playdate，根據movieId取得>=今天的所有playdate並去除重複值
	@Override
	public List<Date> getPlaydatesById(Integer movieId) {
		List<Date> playdates = getSession().createQuery(
				"SELECT DISTINCT playdate FROM ShowtimeInfo WHERE movie.movieId = :movieId AND playdate >= :today",
				Date.class).setParameter("movieId", movieId).setParameter("today", new Date()).list();
		return playdates;
	}

//	showtime
	@Override
	public List<ShowtimeInfo> getShowtimeByPlaydate(Integer movieId, Date playdate) {
		List<ShowtimeInfo> showtimes = getSession()
				.createQuery("SELECT DISTINCT playdate FROM ShowtimeInfo WHERE movie.movieId = :movieId AND playdate >= :today",
						ShowtimeInfo.class)
				.setParameter("movieId", movieId).setParameter("playdate", playdate).list();
		return showtimes;

	}
	
	//	博雅實作，後台場次複合查詢(影廳、播放日期、電影)
	@Override
	public List<ShowtimeInfo> getDate(String screenId, Date playdate, Integer movieId) {
		Query<ShowtimeInfo> query = getSession().createQuery("FROM ShowtimeInfo "
				+ "WHERE (screen.screenId = :screenId OR :screenId IS NULL) AND movie.movieId = :movieId AND playdate = (:playdate OR :playdate IS NULL))",
				ShowtimeInfo.class);
		query.setParameter("screenId", screenId);
		query.setParameter("playdate", playdate);
		query.setParameter("movieId", movieId);
		List<ShowtimeInfo> list = query.list();
		return list;
	}
	
	
	//=============智方實作====================
	@Override
	public int insert(ShowtimeInfo entity) {
		return (Integer) getSession().save(entity);
	}

	@Override
	public int update(ShowtimeInfo entity) {
		Integer showtimeId=entity.getShowtimeId();
		ShowtimeInfo showtimeInfo = getSession().get(ShowtimeInfo.class, showtimeId);
		
		
		try {
			getSession().update(showtimeInfo);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}
	

	@Override
	public int delete(Integer  showtimeId) {
	
		ShowtimeInfo showtimeInfo = getSession().get(ShowtimeInfo.class, showtimeId);
		if (showtimeInfo != null) {
			getSession().delete(showtimeInfo);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
	}

	@Override
	public ShowtimeInfo getById(Integer showtimeId) {
		
		return getSession().get(ShowtimeInfo.class, showtimeId);
	}


	

	@Override
	public List<ShowtimeInfo> getByCompositeQuery(Map<String, String> map) {
		
		return null;
	}

	@Override
	public List<ShowtimeInfo> getAll(int currentPage) {
		
		return null;
	}

	@Override
	public long getTotal() {
		
		return 0;
	}
	
	
	public String starTime(Time starTime) {

		   SimpleDateFormat formatter = new SimpleDateFormat("h:mma",Locale.US);

		   String formattedTime = formatter.format(starTime).toLowerCase();
		   
		   
		   return formattedTime;
		   
	}
	@Override
	public String getSeatStatus(String showtimeId) {
	    String seatStatus = null;
	    Session session = HibernateUtil.getSessionFactory().getCurrentSession(); // 直接獲取當前的 Session
	    ShowtimeInfo showtime = (ShowtimeInfo) session.createQuery("FROM ShowtimeInfo WHERE showtimeId = :showtimeId")
	        .setParameter("showtimeId", showtimeId)
	        .uniqueResult();
	    if (showtime != null) {
	        seatStatus = showtime.getSeatStatus();
	    }
	    return seatStatus;
	}



	public static void main(String[] args) {
		ShowtimeInfoDAOImpl ShowtimeInfoDAO = new ShowtimeInfoDAOImpl();
		List<ShowtimeInfo> ShowtimeInfoList = ShowtimeInfoDAO.getAll();
		for (ShowtimeInfo show : ShowtimeInfoList) {
//		System.out.println(show.getMovie().getMovieName());
			System.out.println(show);

		}
	}
}
