package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.FoodItem;

public interface FoodItemDAO  {
	
	int insert(FoodItem entity);

	int update(FoodItem entity);
	
	int delete(Integer  FoodId);
	
	
	 
	FoodItem getById(Integer  FoodId);
	
	List<FoodItem> getAll();
	
	List<FoodItem> getByCompositeQuery(Map<String, String> map);
	
	
	 List<FoodItem> getFoodbyBookingNo(Integer bookingNo);
	 
	 // 餐點QRCODE
	 String qrUpdateStatus(Integer bookingNo);
}
