package com.dao;

import java.util.List;

import com.entity.OrderItem;

public interface OrderItemDAO {
	
	
	public int cancel(String seatNo,Integer bookingNo);
	public int update(OrderItem entity);
	public OrderItem getKeyId(Integer tkSeq);
	
	public String qrUpdateSeats(String seatNo,Integer bookingNo);
	public List<OrderItem> findSeatByBookingNo(Integer bookingNo);
	public OrderItem qrfinddetails(String seatNo,Integer bookingNo);


}
