package com.dao;

import com.entity.OrderItem;

public interface OrderItemDAO {
	
	
	public int cancel(String seatNo,Integer bookingNo);
	
	public OrderItem getKeyId(Integer tkSeq);

}
