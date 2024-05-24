package com.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Report;
import com.entity.Review;
import com.service.ReportService;
import com.service.ReportServiceImpl;

@WebServlet("/back/report.do")
public class ReportServlet extends HttpServlet {
	
	private ReportService reportService;

	@Override
	public void init() throws ServletException {
		reportService = new ReportServiceImpl();
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		System.out.print(action);
		
		if ("getAll".equals(action)) { 

			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<Report> reportList = reportService.getAllReports(currentPage);

			if (req.getSession().getAttribute("reportPageQty") == null) {
				int reportPageQty = reportService.getPageTotal();
				req.getSession().setAttribute("reportPageQty", reportPageQty);
			}

			req.setAttribute("reportList", reportList);
			req.setAttribute("currentPage", currentPage);
			
			String url = "/back_end/report/select_report.jsp";   
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("compositeQuery".equals(action)) { 
			Map<String, String[]> map = req.getParameterMap();
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<Report> reportList = reportService.getByCompositeQuery(map, currentPage);

			int reportPageQty = 1;
			if (map != null) {
				reportPageQty = reportService.getCompositeQueryTotal(map);
			}

			req.getSession().setAttribute("reportPageQty", reportPageQty);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("reportList", reportList);
			String url = "/back_end/report/select_report.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}	
			
			
		if ("getUpdate".equals(action)) { 
			Integer rptId = Integer.parseInt(req.getParameter("rptId"));
			Report report = reportService.getByReport(rptId);
			String param = "?rptId="  +report.getRptId()+
				       "&mem="  +report.getMem().getMemId()+
				       "&review="    +report.getReview().getReviewId()+
				       "&rptType="+report.getRptType()+
				       "&rptDetail="+report.getRptDetail()+
				       "&rptDate="    +report.getRptDate()+
				       "&rptStatus="   +report.getRptStatus();
			if(report.getRptStatus().equals("通過") || report.getRptStatus().equals("未通過")) {
				String url = "/back_end/report/listOneReport.jsp"+param;
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			String url = "/back_end/report/update_report.jsp"+param;
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
	
		if ("update".equals(action)) { 
			
		Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		Integer rptId = Integer.valueOf(req.getParameter("rptId").trim());
		String rptStatus = req.getParameter("rptStatus").trim();
		if(rptStatus.equals("未審核")) {
			errorMsgs.put("rptStatus", "已審核要修改檢舉狀態");
		}
		
		if (!errorMsgs.isEmpty()) {
			errorMsgs.put("Exception","審核失敗:---------------");
			RequestDispatcher failureView = req.getRequestDispatcher("/back_end/report/update_report.jsp");
			failureView.forward(req, res);
			return; 
		}

		Report report = reportService.getByReport(rptId);
		report.setRptStatus(rptStatus);
		reportService.updateReport(report);

		req.setAttribute("success", "- (修改成功)");
		req.setAttribute("report", report); 
		String url = "/back_end/report/listOneReport.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url); 
		successView.forward(req, res);
		}

	}

}
