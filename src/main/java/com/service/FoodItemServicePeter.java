package com.service;


import java.util.List;

import com.dao.FoodItemDAO;
import com.dao.FoodItemIDAOmpl;
import com.entity.FoodItem;

public class FoodItemServicePeter {
	private FoodItemDAO dao;

	public FoodItemServicePeter() {
		dao = new FoodItemIDAOmpl();
	}
	
	public List<FoodItem> getFoodItems(Integer bookingNo) {
		return dao.getFoodbyBookingNo(bookingNo);
	}
	
	public String updateStatus(Integer bookingNo) {
		return dao.qrUpdateStatus(bookingNo);
	}
	
	public String updateByBookingNo(Integer bookingNo) {
		return dao.qrUpdateStatus(bookingNo);
	}
}
