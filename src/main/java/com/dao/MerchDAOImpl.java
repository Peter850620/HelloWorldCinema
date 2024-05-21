package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Merch;

import com.util.HibernateUtil;

public class MerchDAOImpl implements MerchDAO{
	private SessionFactory factory;

	public MerchDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}
	
	//	商品編號查詢
	@Override
	public Merch getById(Integer merchId) {
		return getSession().get(Merch.class, merchId);
	}
	
	//	商品狀態查詢
	@Override
	public List<Merch> getByStatus(String merchStatus) {
		return getSession().createQuery("FROM Merch WHERE merchStatus = :merchStatus", Merch.class)
				.setParameter("merchStatus", merchStatus).list();
	
	}
}
