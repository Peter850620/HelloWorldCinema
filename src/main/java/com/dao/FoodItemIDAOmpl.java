package com.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.FoodItem;
import com.util.HibernateUtil;

public class FoodItemIDAOmpl implements FoodItemDAO {
	
	private SessionFactory factory;
	
	public FoodItemIDAOmpl() {
		
		factory=HibernateUtil.getSessionFactory();
		
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}


	@Override
	public int insert(FoodItem entity) {
		
		return 0;
	}

	@Override
	public int update(FoodItem foodItem) {
		
		try {
	getSession().update(foodItem);
	return 1;
	
		}catch (Exception e) {
			
			return -1;
			
		}
	}

	@Override
	public int delete(Integer FoodId) {
	
		return 0;
	}

	@Override
	public FoodItem getById(Integer FoodSeq) {
		
		return getSession().get(FoodItem.class,FoodSeq);
	}

	@Override
	public List<FoodItem> getAll() {
	
		return null;
	}

	@Override
	public List<FoodItem> getByCompositeQuery(Map<String, String> map) {
	
		return null;
	}
	
	
	@Override
	public List<FoodItem> getFoodbyBookingNo(Integer bookingNo) {
		 List<FoodItem> foodItems= getSession().createQuery("From FoodItem where booking.bookingNo= :bookingNo", FoodItem.class)
				 .setParameter("bookingNo", bookingNo)
				 .list();
		 
		 return foodItems;
	}


	
	

}
