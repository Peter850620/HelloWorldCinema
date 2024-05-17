package com.service;

import java.util.List;
import java.util.Map;

import com.entity.Mem;
import com.entity.Message;

public interface MessageService {

	void addMessage(Message message);

	void updateMessage(Message message);

	void deleteMessage(Integer msgId);

	Message getByMessage(Integer msgId);
	
	List<Message> getByMem(Mem mem, int currentPage);
	
	List<Message> getAll();

	List<Message> getAllMessages(int currentPage);

	int getPageTotal();

	List<Message> getByCompositeQuery(Map<String, String[]> map);
}
