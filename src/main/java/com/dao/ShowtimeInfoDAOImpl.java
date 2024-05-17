package com.dao;

import java.sql.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.entity.Food;
import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;
import com.util.HibernateUtil;

public class ShowtimeInfoDAOImpl implements ShowtimeInfoDAO {

	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
	private SessionFactory factory;

	public ShowtimeInfoDAOImpl() {
			factory = HibernateUtil.getSessionFactory();
		}

	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public void insert(ShowtimeInfo showtimeinfo) {
		getSession().save(showtimeinfo);
	}

	@Override
	public void update(ShowtimeInfo showtimeinfo) {
		getSession().update(showtimeinfo);
	}

	@Override
	public void delete(Integer showtimeId) {
		// TODO Auto-generated method stub

	}

	@Override
	public ShowtimeInfo findByPrimaryKey(Integer showtimeId) {
		return getSession().get(ShowtimeInfo.class, showtimeId);
			
	}

	@Override
	public List<ShowtimeInfo> getDate(Screen screen, Date[] playdate, Movie movie) {
			Query<ShowtimeInfo> query = getSession().createQuery("FROM ShowtimeInfo, screen, movie "
					+ "WHERE screenId = :screenId AND movieId = :movieId AND playdate between :playdate1 AND :playdate2",
					ShowtimeInfo.class);
			query.setParameter("screenId", screen.getScreenId());
			query.setParameter("playdate1", playdate[0]);
			query.setParameter("playdate2", playdate[0]);
			query.setParameter("movieId", movie.getMovieId());
			List<ShowtimeInfo> list = query.list();
			return list;
	}

	@Override
	public List<ShowtimeInfo> getAll() {
		List<ShowtimeInfo> list = getSession().createQuery("FROM ShowtimeInfo", ShowtimeInfo.class).list();
		return list;
	}

}
