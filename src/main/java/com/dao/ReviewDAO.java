package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Mem;
import com.entity.Movie;
import com.entity.Review;

public interface ReviewDAO {
	
	void insert(Review review);

	void update(Review review);

	int delete(Integer reviewId);
	 
	Review getOneReview(Integer reviewId);

	List<Review> getByMovie(Movie movie);
	
	List<Review> getByMem(Mem mem, int currentPage);
	
	List<Review> getAll();
	
	List<Review> getByCompositeQuery(Map<String, String> map, int currentPage);
	
	int getMapTotal(Map<String, String>map);
	
	List<Review> getAll(int currentPage);
	
	long getTotal();
	
	

}
