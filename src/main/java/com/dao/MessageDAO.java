package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Mem;
import com.entity.Message;

public interface MessageDAO {

	void insert(Message entity);

	void update(Message entity);
	
	int delete(Integer msgId);
	 
	Message getByMessage(Integer msgId);
	
	List<Message> getByMem(Mem mem, int currentPage);
	
	List<Message> getAll();
	
	List<Message> getByCompositeQuery(Map<String, String> map);
	
	List<Message> getAll(int currentPage);
	
	long getTotal();
}
