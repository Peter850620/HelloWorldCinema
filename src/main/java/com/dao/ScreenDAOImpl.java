package com.dao;

import java.util.List;
import java.util.Map;

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
	
	@Override
	public int insert(Screen entity) {
	getSession().save(entity);
		return 0;
	}

	@Override
	public int update(Screen entity) {
		getSession().update(entity);
		return 0;
	}

	@Override
	public int delete(Integer screenId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Screen getById(String screenId) {
		
		return getSession().get(Screen.class, screenId);
	
	}

	

	@Override
	public List<Screen> getByCompositeQuery(Map<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}
	

}
