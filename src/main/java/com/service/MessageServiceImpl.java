package com.service;

import static com.util.Constants.PAGE_MAX_RESULT;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.dao.MessageDAO;
import com.dao.MessageDAOImpl;
import com.entity.Mem;
import com.entity.Message;

public class MessageServiceImpl implements MessageService {

	// 一個 service 實體對應一個 dao 實體
	private MessageDAO dao;

	public MessageServiceImpl() {
		dao = new MessageDAOImpl();
	}
	
	

	@Override
	public void addMessage(Message message) {
			dao.insert(message);
	}

	@Override
	public void updateMessage(Message message) {
			dao.update(message);
	}

	@Override
	public void deleteMessage(Integer msgId) {
		// TODO Auto-generated method stub

	}

	@Override
	public Message getByMessage(Integer msgId) {
			Message message = dao.getByMessage(msgId);
			return message;
	}
	
	@Override
	public List<Message> getByMem(Mem mem, int currentPage){
			List<Message> list = dao.getByMem(mem, currentPage);
			return list;
	}
	
	@Override
	public List<Message> getAll() {
			List<Message> list = dao.getAll();
			return list;
	}

	@Override
	public List<Message> getAllMessages(int currentPage) {
			List<Message> list = dao.getAll(currentPage);
			return list;
	}

	@Override
	public List<Message> getByCompositeQuery(Map<String, String[]> map, int currentPage) {
		Map<String, String> query = new HashMap<>();
		// Map.Entry即代表一組key-value
		Set<Map.Entry<String, String[]>> entry = map.entrySet();

		for (Map.Entry<String, String[]> row : entry) {
			String key = row.getKey();
			// 因為請求參數裡包含了action，做個去除動作
			if ("action".equals(key)) {
				continue;
			}
			// 若是value為空即代表沒有查詢條件，做個去除動作
			String value = row.getValue()[0];
			if (value.isEmpty() || value == null) {
				continue;
			}
			query.put(key, value);
		}
			System.out.println(query);
			List<Message> list = dao.getByCompositeQuery(query, currentPage);
			return list;
	}
	
	@Override
	public int getCompositeQueryTotal(Map<String, String[]> map) {
		Map<String, String> query = new HashMap<>();
		// Map.Entry即代表一組key-value
		Set<Map.Entry<String, String[]>> entry = map.entrySet();

		for (Map.Entry<String, String[]> row : entry) {
			String key = row.getKey();
			// 因為請求參數裡包含了action，做個去除動作
			if ("action".equals(key)) {
				continue;
			}
			// 若是value為空即代表沒有查詢條件，做個去除動作
			String value = row.getValue()[0];
			if (value.isEmpty() || value == null) {
				continue;
			}
			query.put(key, value);
		}
			System.out.println(query);
			int queryTotal = dao.getMapTotal(query);
			return queryTotal;
	}

	@Override
	public int getPageTotal() {
			long total = dao.getTotal();
			int pageQty = (int) (total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT)
					: (total / PAGE_MAX_RESULT + 1));
			return pageQty;
	}
	
	@Override
    public void scheduleMessage() {
			dao.scheduleMessage();
    }
}
