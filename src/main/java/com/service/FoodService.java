package com.service;

import java.util.List;

import com.dao.FoodDAO;
import com.dao.FoodDAOImpl;
import com.entity.Food;


public class FoodService {
	private FoodDAO dao;

	public FoodService() {
		dao = new FoodDAOImpl();
	}

	public Food addfood(String foodName, String foodDetails, Integer foodPrice, byte[] foodPic, String foodStatus) {

		Food food = new Food();

		food.setFoodName(foodName);
		food.setFoodDetails(foodDetails);
		food.setFoodPrice(foodPrice);
		food.setFoodPic(foodPic);
		food.setFoodStatus(foodStatus);
		dao.insert(food);

		return food;
	}

	public Food updateFood(Integer foodId, String foodName, String foodDetails, Integer foodPrice, byte[] foodPic,
			String foodStatus) {

		Food food = dao.findByPrimaryKey(foodId);

		food.setFoodName(foodName);
		food.setFoodDetails(foodDetails);
		food.setFoodPrice(foodPrice);
		food.setFoodPic(foodPic);
		food.setFoodStatus(foodStatus);
		dao.update(food);

		return food;
	}

	public void deleteFood(Integer foodId) {
		dao.delete(foodId);
	}

	public Food getOneFood(Integer foodId) {
		return dao.findByPrimaryKey(foodId);
	}

	public List<Food> getAll() {
		return dao.getAll();
	}	
}
