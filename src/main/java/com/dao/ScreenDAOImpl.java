package com.dao;

import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Screen;
import com.util.HibernateUtil;

public class ScreenDAOImpl implements ScreenDAO {

	private SessionFactory factory;

	public ScreenDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public List<Screen> getAll() {
		
			List<Screen> list = getSession().createQuery("FROM Screen", Screen.class).list();
			return list;
	}

	@Override
    public Screen findByPrimaryKey(Integer screenId){

		return getSession().get(Screen.class,screenId);

	}
	

}
