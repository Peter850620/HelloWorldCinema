package com.dao;

import static com.util.Constants.PAGE_MAX_RESULT;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Mem;
import com.entity.Movie;
import com.entity.Review;


import com.util.HibernateUtil;


public class ReviewDAOImpl implements ReviewDAO {
	
	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
		private SessionFactory factory;
		

		public ReviewDAOImpl() {
			factory = HibernateUtil.getSessionFactory();
		}
		
		// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
		// 以避免請求執行緒共用了同個 Session
		private Session getSession() {
			return factory.getCurrentSession();
		}

		@Override
		public void insert(Review review) {
	        	getSession().save(review);
			
		}

		@Override
		public void update(Review review) {
				getSession().update(review);
		}

		@Override
		public int delete(Integer reviewId) {
			Review review = getSession().get(Review.class, reviewId);
			if (review != null) {
				getSession().delete(review);
				// 回傳給 service，1代表刪除成功
				return 1;
			} else {
				// 回傳給 service，-1代表刪除失敗
				return -1;
			}
		}

		@Override
		public Review getOneReview(Integer reviewId) {
			return getSession().get(Review.class, reviewId);
		}
		
		@Override
		public List<Review> getByMovie(Movie movie) {
			return getSession().createQuery("from Review where movie = :movie", Review.class)
			.setParameter("movie", movie).list();
		}
		
		@Override
		public List<Review> getByMem(Mem mem, int currentPage) {
			int first = (currentPage - 1) * PAGE_MAX_RESULT;
			return getSession().createQuery("from Review where mem = :mem", Review.class)
			.setParameter("mem", mem)
			.setFirstResult(first)
			.setMaxResults(PAGE_MAX_RESULT)
			.list();
		}

		@Override
		public List<Review> getAll() {
			return getSession().createQuery("from Review", Review.class).list();
		}

		@Override
		public List<Review> getByCompositeQuery(Map<String, String> map, int currentPage) {
			int first = (currentPage - 1) * PAGE_MAX_RESULT;
			if (map.size() == 0)
				return getAll();

			CriteriaBuilder builder = getSession().getCriteriaBuilder();
			CriteriaQuery<Review> criteria = builder.createQuery(Review.class);
			Root<Review> root = criteria.from(Review.class);

			List<Predicate> predicates = new ArrayList<>();

			if (map.containsKey("startreviewDate") && map.containsKey("endreviewDate"))
				predicates.add(builder.between(root.get("reviewDate"), Timestamp.valueOf(map.get("startreviewDate")), Timestamp.valueOf(map.get("endreviewDate"))));

			for (Map.Entry<String, String> row : map.entrySet()) {
				if ("reviewId".equals(row.getKey())) {
					predicates.add(builder.equal(root.get("reviewId"), new BigDecimal(row.getValue())));
				}
				if ("mem".equals(row.getKey())) {
					predicates.add(builder.equal(root.get("mem"), new BigDecimal(row.getValue())));
				}

				if ("movie".equals(row.getKey())) {
					predicates.add(builder.equal(root.get("movie"), new BigDecimal(row.getValue())));
				}

				if ("startreviewDate".equals(row.getKey())) {
					if (!map.containsKey("endreviewDate"))
						predicates.add(builder.greaterThanOrEqualTo(root.get("reviewDate"), Timestamp.valueOf(row.getValue())));
				}

				if ("endreviewDate".equals(row.getKey())) {
					if (!map.containsKey("startreviewDate"))
						predicates.add(builder.lessThanOrEqualTo(root.get("reviewDate"), Timestamp.valueOf(row.getValue())));

				}
				
				if ("reviewStatus".equals(row.getKey())) {
					predicates.add(builder.equal(root.get("reviewStatus"), row.getValue()));
				}

			}

			criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
			criteria.orderBy(builder.asc(root.get("reviewId")));
			TypedQuery<Review> query = getSession().createQuery(criteria);

			return query.setFirstResult(first)
					.setMaxResults(PAGE_MAX_RESULT)
					.getResultList();
		}
		
		@Override
		public int getMapTotal(Map<String, String>map) {
			CriteriaBuilder builder = getSession().getCriteriaBuilder();
			CriteriaQuery<Review> criteria = builder.createQuery(Review.class);
			Root<Review> root = criteria.from(Review.class);

			List<Predicate> predicates = new ArrayList<>();

			if (map.containsKey("startreviewDate") && map.containsKey("endreviewDate"))
				predicates.add(builder.between(root.get("reviewDate"), Timestamp.valueOf(map.get("startreviewDate")), Timestamp.valueOf(map.get("endreviewDate"))));

			for (Map.Entry<String, String> row : map.entrySet()) {
				if ("reviewId".equals(row.getKey())) {
					predicates.add(builder.equal(root.get("reviewId"), new BigDecimal(row.getValue())));
				}
				if ("mem".equals(row.getKey())) {
					predicates.add(builder.equal(root.get("mem"), new BigDecimal(row.getValue())));
				}

				if ("movie".equals(row.getKey())) {
					predicates.add(builder.equal(root.get("movie"), new BigDecimal(row.getValue())));
				}

				if ("startreviewDate".equals(row.getKey())) {
					if (!map.containsKey("endreviewDate"))
						predicates.add(builder.greaterThanOrEqualTo(root.get("reviewDate"), Timestamp.valueOf(row.getValue())));
				}

				if ("endreviewDate".equals(row.getKey())) {
					if (!map.containsKey("startreviewDate"))
						predicates.add(builder.lessThanOrEqualTo(root.get("reviewDate"), Timestamp.valueOf(row.getValue())));

				}
				
				if ("reviewStatus".equals(row.getKey())) {
					predicates.add(builder.equal(root.get("reviewStatus"), row.getValue()));
				}

			}

			criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
			criteria.orderBy(builder.asc(root.get("reviewId")));
			TypedQuery<Review> query = getSession().createQuery(criteria);

			List<Review> resultlist = query.getResultList();
			int total = resultlist.size();
			int pageQty = (total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT)
					: (total / PAGE_MAX_RESULT + 1));
			return pageQty;
		}

		@Override
		public List<Review> getAll(int currentPage) {
			
			int first = (currentPage - 1) * PAGE_MAX_RESULT;
			return getSession().createQuery("from Review", Review.class)
					.setFirstResult(first)
					.setMaxResults(PAGE_MAX_RESULT)
					.list();
		}

		@Override
		public long getTotal() {
			return getSession().createQuery("select count(*) from Review", Long.class).uniqueResult();
		}
		


}
