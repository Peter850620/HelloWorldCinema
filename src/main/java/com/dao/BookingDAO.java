package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Booking;

public interface BookingDAO {
	

	int insert(Booking entity);

	int update(Booking entity);
	
	int cancel(Integer bookingNo);
	 
	Booking getById(Integer showtimeId);
	
	Booking getOneBooking(Integer bookingNo);
	
	List<Booking> getMemBookings(Integer memId,Integer currentPage,String orderBy);
	
	long getTotal(Integer memId);
	
	List<Booking> getByCompositeQuery(Map<String, String> map);
	
	
	//針對前台會員訂單
	List<Booking> getAll(Integer page,String  pickupOption, Integer bookingNo,String bookingDate);
	
	public long getTotalOfBookings(String pickupOption, Integer bookingNo,String bookingDate) ;
	
	//無任何條件查詢訂單筆數
	public long getTotalOfBookings() ;
}
