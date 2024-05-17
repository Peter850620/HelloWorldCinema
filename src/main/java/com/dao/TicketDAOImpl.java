package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Ticket;
import com.util.HibernateUtil;

public class TicketDAOImpl implements TicketDAO {

	private SessionFactory factory;

	public TicketDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public void insert(Ticket ticket) {
		getSession().save(ticket);
	}

	@Override
	public void update(Ticket ticket) {
		getSession().update(ticket);
	}

//		票種編號查詢
	@Override
	public Ticket getById(Integer tkId) {
		return getSession().get(Ticket.class, tkId);
	}

//		票種名稱查詢
	@Override
	public List<Ticket> getByName(String tkName) {
		return getSession().createQuery("FROM Ticket WHERE tkName = :tkName", Ticket.class)
				.setParameter("tkName", tkName).list();
	}

//		票種狀態查詢
	@Override
	public List<Ticket> getByStatus(String tkStatus) {
		return getSession().createQuery("FROM Ticket WHERE tkStatus = :tkStatus", Ticket.class)
				.setParameter("tkStatus", tkStatus).list();

	}

//		查詢全部
	@Override
	public List<Ticket> getAll() {
		List<Ticket> list = getSession().createQuery("FROM Ticket", Ticket.class).list();
		return list;

	}

}
