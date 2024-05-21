package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.entity.MerchItem;
import com.util.HibernateUtil;

public class MerchItemDAOImpl implements MerchItemDAO{

	private SessionFactory factory;

	public MerchItemDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}
//	新增
	@Override
	public void insert(MerchItem merchItem) {
		getSession().save(merchItem);
	}
	
//	修改
	@Override
	public void update(MerchItem merchItem) {
			getSession().update(merchItem);
	}
	
//	刪除
	@Override
	public void delete(Integer merchSeq) {
		// TODO Auto-generated method stub
		
	}
	
//	訂單編號查詢
	@Override
	public List<MerchItem> getByNo(Integer merchNo) {
		return getSession().createQuery("FROM MerchItem WHERE merchOrder.merchNo = :merchNo", MerchItem.class)
			.setParameter("merchNo", merchNo)
			.list();
	}

//	明細項次查詢
	@Override
	public MerchItem getBySeq(Integer merchSeq) {
		return getSession().get(MerchItem.class, merchSeq);
	}

	
	
}
