package com.dao;

import java.util.List;

import com.entity.Food;

public interface FoodDAO {
	public void insert(Food food);
	public void update(Food food);
	public void delete(Integer foodId);
    public Food findByPrimaryKey(Integer foodId);
    public List<Food> getAll();	
    public List<Food> getAllfoodForbooking();	
}
