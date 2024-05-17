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

import com.entity.Mem;
import com.entity.Message;

import com.util.HibernateUtil;

public class MessageDAOImpl implements MessageDAO {

	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
			private SessionFactory factory;

			public MessageDAOImpl() {
				factory = HibernateUtil.getSessionFactory();
			}
			
			// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
			// 以避免請求執行緒共用了同個 Session
			private Session getSession() {
				return factory.getCurrentSession();
			}

			@Override
			public void insert(Message message) {
				getSession().save(message);
			}

			@Override
			public void update(Message message) {
					getSession().update(message);
			}

			@Override
			public int delete(Integer msgId) {
				Message message = getSession().get(Message.class, msgId);
				if (message != null) {
					getSession().delete(message);
					// 回傳給 service，1代表刪除成功
					return 1;
				} else {
					// 回傳給 service，-1代表刪除失敗
					return -1;
				}
			}

			@Override
			public Message getByMessage(Integer msgId) {
				return getSession().get(Message.class, msgId);
			}
			
			@Override
			public List<Message> getByMem(Mem mem, int currentPage){
				int first = (currentPage - 1) * PAGE_MAX_RESULT;
				return getSession().createQuery("from Message where mem = :mem", Message.class)
						.setParameter("mem", mem)
						.setFirstResult(first)
						.setMaxResults(PAGE_MAX_RESULT)
						.list();
			}
			
			@Override
			public List<Message> getAll() {
				return getSession().createQuery("from Message", Message.class).list();
			}

			@Override
			public List<Message> getByCompositeQuery(Map<String, String> map) {
				if (map.size() == 0)
					return getAll();

				CriteriaBuilder builder = getSession().getCriteriaBuilder();
				CriteriaQuery<Message> criteria = builder.createQuery(Message.class);
				Root<Message> root = criteria.from(Message.class);

				List<Predicate> predicates = new ArrayList<>();

				if (map.containsKey("startMsgTime") && map.containsKey("endMsgTime"))
					predicates.add(builder.between(root.get("msgTime"), Timestamp.valueOf(map.get("startMsgTime")), Timestamp.valueOf(map.get("endMsgTime"))));

				for (Map.Entry<String, String> row : map.entrySet()) {
					if ("msgId".equals(row.getKey())) {
						predicates.add(builder.equal(root.get("msgId"), new BigDecimal(row.getValue())));
					}
					
					if ("mem".equals(row.getKey())) {
						predicates.add(builder.equal(root.get("mem"), new BigDecimal(row.getValue())));
					}
					
					if ("msgTitle".equals(row.getKey())) {
						predicates.add(builder.like(root.get("msgTitle"), "%" + row.getValue() + "%"));
					}

					if ("startMsgTime".equals(row.getKey())) {
						if (!map.containsKey("endMsgTime"))
							predicates.add(builder.greaterThanOrEqualTo(root.get("msgTime"), Timestamp.valueOf(row.getValue())));
					}

					if ("endMsgTime".equals(row.getKey())) {
						if (!map.containsKey("startMsgTime"))
							predicates.add(builder.lessThanOrEqualTo(root.get("msgTime"), Timestamp.valueOf(row.getValue())));

					}
					
					if ("msgStatus".equals(row.getKey())) {
						predicates.add(builder.equal(root.get("msgStatus"), row.getValue()));
					}


				}

				criteria.where(builder.and(predicates.toArray(new Predicate[predicates.size()])));
				criteria.orderBy(builder.asc(root.get("msgId")));
				TypedQuery<Message> query = getSession().createQuery(criteria);

				return query.getResultList();
			}

			@Override
			public List<Message> getAll(int currentPage) {
				int first = (currentPage - 1) * PAGE_MAX_RESULT;
				return getSession().createQuery("from Message", Message.class)
						.setFirstResult(first)
						.setMaxResults(PAGE_MAX_RESULT)
						.list();
			}

			@Override
			public long getTotal() {
				return getSession().createQuery("select count(*) from Message", Long.class).uniqueResult();
			}
}
