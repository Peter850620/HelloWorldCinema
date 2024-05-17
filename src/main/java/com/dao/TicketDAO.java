package com.dao;

import java.util.List;



import com.entity.Ticket;


public interface TicketDAO {
	
	public List<Ticket> getAll();
	public void insert(Ticket ticket);
	public void update(Ticket ticket);
	public Ticket getById(Integer tkId);
	public List<Ticket> getByName(String tkName);
	public List<Ticket> getByStatus(String tkStatus);

}
