package com.service;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.dao.TicketDAO;
import com.dao.TicketDAOImpl;
import com.entity.Ticket;
import com.util.HibernateUtil;

@Transactional
public class TicketService_13 {

	private TicketDAO dao;

	public TicketService_13() {
		dao = new TicketDAOImpl();
	}

	//新增
	public Ticket addTicket(String tkName, String tkInfo,
			Integer tkPrice, String tkStatus) {

        Ticket ticket = null;
        try {


            ticket = new Ticket();
            ticket.setTkName(tkName);
            ticket.setTkInfo(tkInfo);
            ticket.setTkPrice(tkPrice);
            ticket.setTkStatus(tkStatus);

            dao.insert(ticket);


        } catch (HibernateException ex) {

            ex.printStackTrace(); // 可以記錄日誌或者返回錯誤信息給用戶
        }
        return ticket;
    
	}
	// 修改票種
	public Ticket updateTicket(Integer tkId, String tkName, String tkInfo, Integer tkPrice, String tkStatus) {

	    Ticket ticket = null;
	    try {   

	        ticket = dao.getById(tkId);
	        if (ticket != null) {
	            ticket.setTkName(tkName);
	            ticket.setTkInfo(tkInfo);
	            ticket.setTkPrice(tkPrice);
	            ticket.setTkStatus(tkStatus);

	            // 更新資料
	            dao.update(ticket);
	        }


	    } catch (HibernateException ex) {
	       
	        ex.printStackTrace(); // 可以記錄日誌或者返回錯誤信息給用戶
	    }
	    return ticket;
	}



	//查詢票種編號
	public Ticket getById(Integer tkId) {
		return dao.getById(tkId);
	}
	//查詢票種名稱
	public List<Ticket> getByName(String tkName) {
		return dao.getByName(tkName);
	}
	//查詢票種狀態
	public List<Ticket> getByStatus(String tkStatus) {
		return dao.getByStatus(tkStatus);
	}
	//修改單一票種
	public Ticket getOneTicket(Integer tkId) {
		return dao.getById(tkId);
	}
	
	//查詢全部票種
		public List<Ticket> getAll() {
			return dao.getAll();
		}

}
