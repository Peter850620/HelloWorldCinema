package com.dao;

import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.entity.Mem;
import com.entity.MerchItem;
import com.entity.MerchOrder;
import com.entity.Ticket;
import com.util.HibernateUtil;

public class MerchOrderDAOImpl implements MerchOrderDAO {

	private SessionFactory factory;

	public MerchOrderDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public void insert(MerchOrder merchOrder, Set<MerchItem> merchItems) {
	    Session session = getSession();
	    
	    // Save the merchandise order
	    session.save(merchOrder);

	    // Set the merchandise order for each merchandise item and save them
	    for (MerchItem merchItem : merchItems) {
	        merchItem.setMerchOrder(merchOrder);
	        session.save(merchItem);
	    }
	}
	
//	修改
	@Override
	public void update(MerchOrder merchOrder) {
		getSession().update(merchOrder);
	}

//	訂單編號查詢
	@Override
	public MerchOrder getByNo(Integer merchNo) {
		return getSession().get(MerchOrder.class, merchNo);
	}

//	會員編號查詢
	@Override
	public List<MerchOrder> getById(Integer memId) {
		return getSession().createQuery("FROM MerchOrder WHERE mem.memId = :memId", MerchOrder.class)
				.setParameter("memId", memId).list();
	}

//	電話號碼查詢
	@Override
	public MerchOrder getByMobile(String receiptMobile) {
		return getSession().createQuery("FROM MerchOrder WHERE receiptMobile = :receiptMobile", MerchOrder.class)
				.setParameter("receiptMobile", receiptMobile).uniqueResult();
	}

//	所有訂單
	@Override
	public List<MerchOrder> getAll() {
		return getSession().createQuery("FROM MerchOrder", MerchOrder.class).list();
	}
}
