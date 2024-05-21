package com.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.entity.OrderItem;
import com.util.HibernateUtil;

public class OrderItemDAOImpl implements OrderItemDAO {
	
	private SessionFactory factory;
	
	
	public OrderItemDAOImpl() {
		factory=HibernateUtil.getSessionFactory();
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}


	public int cancel(String seatNo,Integer bookingNo) {
	    // 獲取 OrderItem 實體
		String hql = "FROM OrderItem WHERE seatNo = :seatNo AND booking.bookingNo = :bookingNo";
		Query<OrderItem> query = getSession().createQuery(hql, OrderItem.class)
		.setParameter("seatNo", seatNo)
	    .setParameter("bookingNo", bookingNo);
		OrderItem orderItem = query.uniqueResult();

	    if (orderItem != null) {
	        // 更新 entryStatus 
	        orderItem.setEntryStatus("已取消");
	        // 保存更新
	        getSession().update(orderItem);
	      
	    }
	    return 1;  
	}
	
	public OrderItem getKeyId(Integer tkSeq) {
		return getSession().get(OrderItem.class, tkSeq);
		
		
	}
	
	
	public String qrUpdateSeats(String seatNo,Integer bookingNo) {
	    // 獲取 OrderItem 實體
		String hql = "FROM OrderItem WHERE seatNo = :seatNo AND booking.bookingNo = :bookingNo";
		Query<OrderItem> query = getSession().createQuery(hql, OrderItem.class)
		.setParameter("seatNo", seatNo)
	    .setParameter("bookingNo", bookingNo);
		OrderItem orderItem = query.uniqueResult();
		
		
		 if (orderItem == null) {
		        return "Error: OrderItem not found.";
		    }
		 
		String currentStatus=orderItem.getEntryStatus();
		
		
		if(currentStatus.equals("未使用")) {
		
		orderItem.setEntryStatus("已使用");
		
		  getSession().update(orderItem);
		  
		  return "ok";
		}else{
			
			return "Declined! Please check with the counter.";
			
		}
		
		
	
}
	
}


