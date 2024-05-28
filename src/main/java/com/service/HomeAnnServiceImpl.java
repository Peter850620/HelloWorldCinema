package com.service;

import static com.util.Constants.PAGE_MAX_RESULT;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.entity.HomeAnn;
import com.entity.Message;
import com.dao.HomeAnnDAO;
import com.dao.HomeAnnDAOImpl;
import com.dao.MessageDAO;
import com.dao.MessageDAOImpl;
import com.dto.MessageDTO;
import com.websc.MessageWebSocket;

public class HomeAnnServiceImpl implements HomeAnnService {


	// 一個 service 實體對應一個 dao 實體
	private HomeAnnDAO dao;
	private MessageDAO msgDao;

	public HomeAnnServiceImpl() {
		dao = new HomeAnnDAOImpl();
		msgDao = new MessageDAOImpl();
	}

	@Override
	public void addHomeAnn(HomeAnn homeAnn) {
			dao.insert(homeAnn);
			
			Message message = new Message();
			message.setMsgTitle("最新消息公布囉!!");
			message.setMsgDetail(homeAnn.getAnnTitle());
			message.setMsgTime(new Timestamp(System.currentTimeMillis()));
			message.setMsgStatus("未讀");
			msgDao.insert(message);
			MessageDTO messageDTO = convertToDTO(message);
			MessageWebSocket.broadcastToAll(messageDTO);
	}
	
	private MessageDTO convertToDTO(Message message) {
	    MessageDTO dto = new MessageDTO();
	    dto.setMsgId(message.getMsgId());
	    dto.setMsgTitle(message.getMsgTitle());
	    dto.setMsgDetail(message.getMsgDetail());
	    dto.setMsgTime(message.getMsgTime());
	    dto.setMsgStatus(message.getMsgStatus());
	    return dto;
	}

	@Override
	public void updateHomeAnn(HomeAnn homeAnn) {
			dao.update(homeAnn);
	}

	// 刪除方法
	@Override
	public void deleteHomeAnn(Integer annId) {

	}

	@Override
	public HomeAnn getByHomeAnn(Integer annId) {
			HomeAnn homeAnn = dao.getByHomeAnn(annId);
			return homeAnn;
	}

	public List<HomeAnn> getAll() {
			List<HomeAnn> list = dao.getAll();
			return list;
	}

	@Override
	public List<HomeAnn> getAllHomeAnns(int currentPage) {
			List<HomeAnn> list = dao.getAll(currentPage);
			return list;
	}

	@Override
	public List<HomeAnn> getByCompositeQuery(Map<String, String[]> map, int currentPage) {
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
			List<HomeAnn> list = dao.getByCompositeQuery(query, currentPage);
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
}
