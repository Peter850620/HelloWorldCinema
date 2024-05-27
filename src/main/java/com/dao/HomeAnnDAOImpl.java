package com.dao;

import static com.util.Constants.PAGE_MAX_RESULT;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.HomeAnn;

import com.util.HibernateUtil;

public class HomeAnnDAOImpl implements HomeAnnDAO {

	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
	private SessionFactory factory;

	public HomeAnnDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}
	
	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public int insert(HomeAnn entity) {
		// 回傳給 service 剛新增成功的自增主鍵值
		return (Integer) getSession().save(entity);
	}

	@Override
	public int update(HomeAnn entity) {
		try {
			getSession().update(entity);
			return 1;
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public int delete(Integer annId) {
		HomeAnn homeAnn = getSession().get(HomeAnn.class, annId);
		if (homeAnn != null) {
			getSession().delete(homeAnn);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
	}

	@Override
	public HomeAnn getByHomeAnn(Integer annId) {
		return getSession().get(HomeAnn.class, annId);
	}

	@Override
	public List<HomeAnn> getAll() {
		return getSession().createQuery("FROM HomeAnn ORDER BY annTime DESC", HomeAnn.class).list();
	}

	@Override
	public List<HomeAnn> getByCompositeQuery(Map<String, String> map, int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		if (map.size() == 0)
			return getAll();

		CriteriaBuilder builder = getSession().getCriteriaBuilder();
		CriteriaQuery<HomeAnn> criteria = builder.createQuery(HomeAnn.class);
		Root<HomeAnn> root = criteria.from(HomeAnn.class);

		List<Predicate> predicates = new ArrayList<>();

		if (map.containsKey("startannTime") && map.containsKey("endannTime"))
			predicates.add(builder.between(root.get("annTime"), Timestamp.valueOf(map.get("startannTime")), Timestamp.valueOf(map.get("endannTime"))));

		for (Map.Entry<String, String> row : map.entrySet()) {
			if ("annId".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("annId"), new BigDecimal(row.getValue())));
			}
			
			if ("annTitle".equals(row.getKey())) {
				predicates.add(builder.like(root.get("annTitle"), "%" + row.getValue() + "%"));
			}

			if ("startannTime".equals(row.getKey())) {
				if (!map.containsKey("endannTime"))
					predicates.add(builder.greaterThanOrEqualTo(root.get("annTime"), Timestamp.valueOf(row.getValue())));
			}

			if ("endannTime".equals(row.getKey())) {
				if (!map.containsKey("startannTime"))
					predicates.add(builder.lessThanOrEqualTo(root.get("annTime"), Timestamp.valueOf(row.getValue())));

			}


		}

		criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
		criteria.orderBy(builder.asc(root.get("annId")));
		TypedQuery<HomeAnn> query = getSession().createQuery(criteria);

		return query.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.getResultList();
	}
	
	@Override
	public int getMapTotal(Map<String, String>map) {
		CriteriaBuilder builder = getSession().getCriteriaBuilder();
		CriteriaQuery<HomeAnn> criteria = builder.createQuery(HomeAnn.class);
		Root<HomeAnn> root = criteria.from(HomeAnn.class);

		List<Predicate> predicates = new ArrayList<>();

		if (map.containsKey("startannTime") && map.containsKey("endannTime"))
			predicates.add(builder.between(root.get("annTime"), Timestamp.valueOf(map.get("startannTime")), Timestamp.valueOf(map.get("endannTime"))));

		for (Map.Entry<String, String> row : map.entrySet()) {
			if ("annId".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("annId"), new BigDecimal(row.getValue())));
			}
			
			if ("annTitle".equals(row.getKey())) {
				predicates.add(builder.like(root.get("annTitle"), "%" + row.getValue() + "%"));
			}

			if ("startannTime".equals(row.getKey())) {
				if (!map.containsKey("endannTime"))
					predicates.add(builder.greaterThanOrEqualTo(root.get("annTime"), Timestamp.valueOf(row.getValue())));
			}

			if ("endannTime".equals(row.getKey())) {
				if (!map.containsKey("startannTime"))
					predicates.add(builder.lessThanOrEqualTo(root.get("annTime"), Timestamp.valueOf(row.getValue())));
			}
		}

		criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
		criteria.orderBy(builder.asc(root.get("annId")));
		TypedQuery<HomeAnn> query = getSession().createQuery(criteria);
		
		List<HomeAnn> resultlist = query.getResultList();
		int total = resultlist.size();
		int pageQty = (total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT)
				: (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}

	@Override
	public List<HomeAnn> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("FROM HomeAnn ORDER BY annTime DESC", HomeAnn.class)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}

	@Override
	public long getTotal() {
		return getSession().createQuery("SELECT count(*) FROM HomeAnn", Long.class).uniqueResult();
	}
}
