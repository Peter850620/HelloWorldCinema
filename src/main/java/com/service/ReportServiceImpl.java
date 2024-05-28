package com.service;

import static com.util.Constants.PAGE_MAX_RESULT;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.dao.MessageDAO;
import com.dao.MessageDAOImpl;
import com.dao.ReportDAO;
import com.dao.ReportDAOImpl;
import com.dto.MessageDTO;
import com.entity.Message;
import com.entity.Report;
import com.entity.Review;
import com.websc.MessageWebSocket;

public class ReportServiceImpl implements ReportService {

	// 一個 service 實體對應一個 dao 實體
	private ReportDAO dao;
	private MessageDAO msgDao;

	public ReportServiceImpl() {
		dao = new ReportDAOImpl();
		msgDao = new MessageDAOImpl();
	}

	private MessageDTO convertToDTO(Message message) {
	    MessageDTO dto = new MessageDTO();
	    dto.setMsgId(message.getMsgId());
	    dto.setMemId(message.getMem().getMemId());
	    dto.setMsgTitle(message.getMsgTitle());
	    dto.setMsgDetail(message.getMsgDetail());
	    dto.setMsgTime(message.getMsgTime());
	    dto.setMsgStatus(message.getMsgStatus());
	    return dto;
	}
	
	@Override
	public void addReport(Report report) {
			dao.insert(report);
			
			Message message = new Message();
			message.setMem(report.getMem());
			message.setMsgTitle("留言檢舉");
			message.setMsgDetail("檢舉成功，請靜待審核結果。");
			message.setMsgTime(new Timestamp(System.currentTimeMillis()));
			message.setMsgStatus("未讀");
			msgDao.insert(message);
			MessageDTO messageDTO = convertToDTO(message);
			Integer userId = report.getMem().getMemId();
			MessageWebSocket.broadcast(userId, messageDTO);
	}

	@Override
	public void updateReport(Report report) {
			dao.update(report);
			if(report.getRptStatus().equals("通過") || report.getRptStatus().equals("未通過")) {
				Message message = new Message();
				message.setMem(report.getMem());
				if(report.getRptStatus().equals("通過")) {
					message.setMsgTitle("留言檢舉通過");
					message.setMsgDetail("檢舉通過，已處分留言不當會員。");
					//檢舉通過需寄通知給被檢舉人
					Message message2 = new Message();
					message2.setMem(report.getReview().getMem());
					message2.setMsgTitle("不當發言檢舉");
					message2.setMsgDetail("您於" + report.getReview().getReviewDate() + "在" + report.getReview().getMovie().getMovieName() + "的發言，經由其他會員發現有不當之處，在由世界影城這邊審核後屬實，目前已將該留言隱藏。");
					message2.setMsgTime(new Timestamp(System.currentTimeMillis()));
					message2.setMsgStatus("未讀");
					msgDao.insert(message2);
					MessageDTO messageDTO = convertToDTO(message);
					Integer userId = report.getReview().getMem().getMemId();
					MessageWebSocket.broadcast(userId, messageDTO);
				}else {
					message.setMsgTitle("留言檢舉未通過");
					message.setMsgDetail("檢舉通過，審核後未發現不當之處。");
				}
				message.setMsgTime(new Timestamp(System.currentTimeMillis()));
				message.setMsgStatus("未讀");
				msgDao.insert(message);
				MessageDTO messageDTO = convertToDTO(message);
				Integer userId = report.getMem().getMemId();
				MessageWebSocket.broadcast(userId, messageDTO);
			}
			
	}

	@Override
	public void deleteReport(Integer rptId) {

	}

	@Override
	public Report getByReport(Integer rptId) {
			Report report = dao.getByReport(rptId);
			return report;
	}

	public List<Report> getAll() {
			List<Report> list = dao.getAll();
			return list;
	}

	@Override
	public List<Report> getAllReports(int currentPage) {
			List<Report> list = dao.getAll(currentPage);
			return list;
	}

	@Override
	public List<Report> getByCompositeQuery(Map<String, String[]> map, int currentPage) {
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
			List<Report> list = dao.getByCompositeQuery(query, currentPage);
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
	public void updateRelatedReport(Review review, String rptStatus) {
		List<Report> reports = dao.getByReview(review);
		for(Report report : reports) {
			report.setRptStatus(rptStatus);
			dao.update(report);
		}
	}

	@Override
	public int getPageTotal() {
			long total = dao.getTotal();
			int pageQty = (int) (total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT)
					: (total / PAGE_MAX_RESULT + 1));
			return pageQty;
	}

}
