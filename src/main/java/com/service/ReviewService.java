package com.service;

import java.util.List;
import java.util.Map;

import com.entity.Mem;
import com.entity.Movie;
import com.entity.Review;

public interface ReviewService {
	
	void addReview(Review review);
	
	void updateReview(Review review);
	
	void deleteReview(Integer reviewId);
	//X
	Review getOneReview(Integer reviewId);
	
	List<Review> getByMovie(Movie movie);
	
	List<Review> getByMem(Mem mem, int currentPage);
	
	List<Review> getAll();
	
	List<Review> getAllReviews(int currentPage);
	
	int getPageTotal();
	
	List<Review> getByCompositeQuery(Map<String, String[]> map, int currentPage);
	
	int getCompositeQueryTotal(Map<String, String[]> map);
	
	
}
