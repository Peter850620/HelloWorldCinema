package com.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Mem;
import com.util.HibernateUtil;

public class MemDAOImpl  implements MemDAO{
	
	private SessionFactory factory;
	
	public MemDAOImpl () {
		factory = HibernateUtil.getSessionFactory();
	}
	
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public Mem getByEmail(String memEmail) {

		 String hql = "from Mem where memEmail = :memEmail";
		 org.hibernate.query.Query<Mem> query = getSession().createQuery(hql,Mem.class);
		    query.setParameter("memEmail", memEmail);
		    
		  
		    Mem mem = query.uniqueResult();
		    
		    return mem; 
	}

}
