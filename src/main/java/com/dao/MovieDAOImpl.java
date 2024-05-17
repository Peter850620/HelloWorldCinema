package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Movie;
import com.util.HibernateUtil;

public class MovieDAOImpl implements MovieDAO {

	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
	private SessionFactory factory;

	public MovieDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public List<Movie> getAll() {
		List<Movie> list = getSession().createQuery("FROM Movie", Movie.class).list();
		return list;
	}
//	單一電影資訊
	@Override
	public Movie getByMovieId(Integer movieId) {
		return getSession().get(Movie.class, movieId);
	}

//	電影資訊列表
	@Override
	public List<Movie> getByStatus(String movieStatus) {
		return getSession().createQuery("FROM Movie WHERE movieStatus = :status", Movie.class)
				.setParameter("status", movieStatus).list();
	}

	public static void main(String[] args) {
		MovieDAOImpl movieDAO = new MovieDAOImpl();
		List<Movie> movieList = movieDAO.getAll();
		System.out.println(movieList);
	}

}
