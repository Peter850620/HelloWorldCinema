package com.service;

import static com.util.Constants.PAGE_MAX_RESULT;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Session;

import com.entity.Mem;
import com.entity.Movie;
import com.entity.Review;
import com.dao.ReviewDAO;
import com.dao.ReviewDAOImpl;

import com.util.HibernateUtil;

public class ReviewServiceImpl implements ReviewService {

	// 一個 service 實體對應一個 dao 實體
	private ReviewDAO dao;

	public ReviewServiceImpl() {
		dao = new ReviewDAOImpl();
	}

	@Override
	public void addReview(Review review) {
			dao.insert(review);
	}

	@Override
	public void updateReview(Review review) {
			dao.update(review);
	}

	// 刪除方法
	@Override
	public void deleteReview(Integer reviewId) {
		// TODO Auto-generated method stub

	}

	@Override
	public Review getOneReview(Integer reviewId) {
			Review review = dao.getOneReview(reviewId);
			return review;
	}

	// 依照電影分類評論區
	@Override
	public List<Review> getByMovie(Movie movie) {
			List<Review> list = dao.getByMovie(movie);
			return list;
	}
	
	@Override
	public List<Review> getByMem(Mem mem, int currentPage) {
			List<Review> list = dao.getByMem(mem, currentPage);
			return list;
	}

	public List<Review> getAll() {
			List<Review> list = dao.getAll();
			return list;
	}

	@Override
	public List<Review> getAllReviews(int currentPage) {
			List<Review> list = dao.getAll(currentPage);
			return list;
	}

	@Override
	public List<Review> getByCompositeQuery(Map<String, String[]> map, int currentPage) {
		Map<String, String> query = new HashMap<>();
		// Map.Entry即代表一組key-value
		Set<Map.Entry<String, String[]>> entry = map.entrySet();

		for (Map.Entry<String, String[]> row : entry) {
			String key = row.getKey();
			// 因為請求參數裡包含了action，做個去除動作
			if ("action".equals(key)) {
				continue;
			}
			// 若是value為空即代表沒有查詢條件，做個去除動作
			String value = row.getValue()[0];
			if (value.isEmpty() || value == null) {
				continue;
			}
			query.put(key, value);
		}
			System.out.println(query);
			List<Review> list = dao.getByCompositeQuery(query, currentPage);
			return list;
	}
	
	@Override
	public int getCompositeQueryTotal(Map<String, String[]> map) {
		Map<String, String> query = new HashMap<>();
		// Map.Entry即代表一組key-value
		Set<Map.Entry<String, String[]>> entry = map.entrySet();

		for (Map.Entry<String, String[]> row : entry) {
			String key = row.getKey();
			// 因為請求參數裡包含了action，做個去除動作
			if ("action".equals(key)) {
				continue;
			}
			// 若是value為空即代表沒有查詢條件，做個去除動作
			String value = row.getValue()[0];
			if (value.isEmpty() || value == null) {
				continue;
			}
			query.put(key, value);
		}
			System.out.println(query);
			int queryTotal = dao.getMapTotal(query);
			return queryTotal;
	}

	@Override
	public int getPageTotal() {
			long total = dao.getTotal();
			int pageQty = (int) (total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT)
					: (total / PAGE_MAX_RESULT + 1));
			return pageQty;
	}

}
