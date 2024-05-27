package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Food;
import com.util.HibernateUtil;

public class FoodDAOImpl implements FoodDAO {

	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
	private SessionFactory factory;

	public FoodDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public void insert(Food food) {
		getSession().save(food);
	}

	@Override
	public void update(Food food) {
		getSession().update(food);
	}

	@Override
	public void delete(Integer foodId) {
		// TODO Auto-generated method stub

	}

	@Override
	public Food findByPrimaryKey(Integer foodId) {
		return getSession().get(Food.class, foodId);
	}

	@Override
	public List<Food> getAll() {
		List<Food> list = getSession().createQuery("FROM Food", Food.class).list();
		return list;
	}
	

	@Override
	public List<Food> getAllfoodForbooking() {
	List<Food> list = getSession()
			    .createQuery("FROM Food WHERE foodStatus = :status", Food.class)
			    .setParameter("status", "上架")
			    .list();
	
	return list;
	}
}
