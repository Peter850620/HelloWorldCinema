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

import com.entity.Report;
import com.entity.Review;
import com.util.HibernateUtil;

public class ReportDAOImpl implements ReportDAO {

	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
	private SessionFactory factory;

	public ReportDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public void insert(Report report) {
		// 回傳給 service 剛新增成功的自增主鍵值
		getSession().save(report);
	}

	@Override
	public void update(Report report) {
		getSession().update(report);
	}

	@Override
	public int delete(Integer rptId) {
		Report report = getSession().get(Report.class, rptId);
		if (report != null) {
			getSession().delete(report);
			// 回傳給 service，1代表刪除成功
			return 1;
		} else {
			// 回傳給 service，-1代表刪除失敗
			return -1;
		}
	}

	@Override
	public Report getByReport(Integer rptId) {
		return getSession().get(Report.class, rptId);
	}
	
	@Override
	public List<Report> getByReview(Review reviewId){
		return getSession().createQuery("FROM Report WHERE review = :review",Report.class)
				.setParameter("review", reviewId).list();
	}

	@Override
	public List<Report> getAll() {
		return getSession().createQuery("FROM Report ORDER BY rptDate DESC", Report.class).list();
	}

	@Override
	public List<Report> getByCompositeQuery(Map<String, String> map, int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		if (map.size() == 0)
			return getAll();

		CriteriaBuilder builder = getSession().getCriteriaBuilder();
		CriteriaQuery<Report> criteria = builder.createQuery(Report.class);
		Root<Report> root = criteria.from(Report.class);

		List<Predicate> predicates = new ArrayList<>();

		if (map.containsKey("startRptDate") && map.containsKey("endRptDate"))
			predicates.add(builder.between(root.get("RptDate"), Timestamp.valueOf(map.get("startRptDate")),
					Timestamp.valueOf(map.get("endRptDate"))));

		for (Map.Entry<String, String> row : map.entrySet()) {
			if ("rptId".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("rptId"), new BigDecimal(row.getValue())));
			}
			
			if ("mem".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("mem"), new BigDecimal(row.getValue())));
			}
			
			if ("review".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("review"), new BigDecimal(row.getValue())));
			}
			
			if ("rptType".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("rptType"), row.getValue()));
			}
			
			if ("rptDetail".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("rptDetail"), row.getValue()));
			}
			
			if ("startRptDate".equals(row.getKey())) {
				if (!map.containsKey("endRptDate"))
					predicates
							.add(builder.greaterThanOrEqualTo(root.get("RptDate"), Timestamp.valueOf(row.getValue())));
			}
			
			if ("endRptDate".equals(row.getKey())) {
				if (!map.containsKey("startRptDate"))
					predicates.add(builder.lessThanOrEqualTo(root.get("RptDate"), Timestamp.valueOf(row.getValue())));
			}
			
			if ("rptStatus".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("rptStatus"), row.getValue()));
			}
			
		}

		criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
		criteria.orderBy(builder.asc(root.get("rptId")));
		TypedQuery<Report> query = getSession().createQuery(criteria);

		return query.setFirstResult(first).setMaxResults(PAGE_MAX_RESULT).getResultList();
	}
	
	@Override
	public int getMapTotal(Map<String, String> map) {
		CriteriaBuilder builder = getSession().getCriteriaBuilder();
		CriteriaQuery<Report> criteria = builder.createQuery(Report.class);
		Root<Report> root = criteria.from(Report.class);

		List<Predicate> predicates = new ArrayList<>();

		if (map.containsKey("startRptDate") && map.containsKey("endRptDate"))
			predicates.add(builder.between(root.get("RptDate"), Timestamp.valueOf(map.get("startRptDate")),
					Timestamp.valueOf(map.get("endRptDate"))));

		for (Map.Entry<String, String> row : map.entrySet()) {
			if ("rptId".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("rptId"), new BigDecimal(row.getValue())));
			}
			
			if ("mem".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("mem"), new BigDecimal(row.getValue())));
			}
			
			if ("review".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("review"), new BigDecimal(row.getValue())));
			}
			
			if ("rptType".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("rptType"), row.getValue()));
			}
			
			if ("rptDetail".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("rptDetail"), row.getValue()));
			}
			
			if ("startRptDate".equals(row.getKey())) {
				if (!map.containsKey("endRptDate"))
					predicates
							.add(builder.greaterThanOrEqualTo(root.get("RptDate"), Timestamp.valueOf(row.getValue())));
			}
			
			if ("endRptDate".equals(row.getKey())) {
				if (!map.containsKey("startRptDate"))
					predicates.add(builder.lessThanOrEqualTo(root.get("RptDate"), Timestamp.valueOf(row.getValue())));
			}
			
			if ("rptStatus".equals(row.getKey())) {
				predicates.add(builder.equal(root.get("rptStatus"), row.getValue()));
			}
			
		}
		
		criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
		criteria.orderBy(builder.asc(root.get("rptId")));
		TypedQuery<Report> query = getSession().createQuery(criteria);

		List<Report> resultlist = query.getResultList();
		int total = resultlist.size();
		int pageQty = (total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}

	@Override
	public List<Report> getAll(int currentPage) {
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		return getSession().createQuery("FROM Report ORDER BY rptDate DESC", Report.class)
				.setFirstResult(first)
				.setMaxResults(PAGE_MAX_RESULT)
				.list();
	}

	@Override
	public long getTotal() {
		return getSession().createQuery("SELECT count(*) FROM Report", Long.class).uniqueResult();
	}

}
