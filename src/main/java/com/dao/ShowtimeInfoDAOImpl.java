package com.dao;

import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Food;
import com.entity.Screen;
import com.util.HibernateUtil;
import com.entity.ShowtimeInfo;

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

	public static void main(String[] args) {
		ShowtimeInfoDAOImpl ShowtimeInfoDAO = new ShowtimeInfoDAOImpl();
		List<ShowtimeInfo> ShowtimeInfoList = ShowtimeInfoDAO.getAll();
		for (ShowtimeInfo show : ShowtimeInfoList) {
//		System.out.println(show.getMovie().getMovieName());
			System.out.println( show );

		}
	}

}
