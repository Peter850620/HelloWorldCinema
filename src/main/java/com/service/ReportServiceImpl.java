package com.service;

import static com.util.Constants.PAGE_MAX_RESULT;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.entity.Report;
import com.dao.ReportDAO;
import com.dao.ReportDAOImpl;

public class ReportServiceImpl implements ReportService {

	// 一個 service 實體對應一個 dao 實體
	private ReportDAO dao;

	public ReportServiceImpl() {
		dao = new ReportDAOImpl();
	}

	@Override
	public void addReport(Report report) {
			dao.insert(report);
	}

	@Override
	public void updateReport(Report report) {
			dao.update(report);
	}

	@Override
	public void deleteReport(Integer rptId) {
		// TODO Auto-generated method stub

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
	public int getPageTotal() {
			long total = dao.getTotal();
			int pageQty = (int) (total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT)
					: (total / PAGE_MAX_RESULT + 1));
			return pageQty;
	}

}
