package com.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Mem;
import com.entity.Report;
import com.entity.Review;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.ReportService;
import com.service.ReportServiceImpl;

@WebServlet("/front/report.do")
public class ReportFrontServlet extends HttpServlet {
	
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
		
		if ("getInsert".equals(action)) { 
			Integer rptId = Integer.parseInt(req.getParameter("rptId"));
			Report report = reportService.getByReport(rptId);
			String param = "?rptId="  +report.getRptId()+
				       "&mem="  +report.getMem().getMemId()+
				       "&review="    +report.getReview().getReviewId()+
				       "&rptType="+report.getRptType()+
				       "&rptDetail="+report.getRptDetail()+
				       "&rptDate="    +report.getRptDate()+
				       "&reviewStatus="   +report.getRptStatus();
			
			String url = "/back-end/report/update_report.jsp"+param;
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		
		if ("insert".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
//			HttpSession session = req.getSession();
//			Integer reviewId = (Integer) session.getAttribute("review");
			Integer reviewId = Integer.valueOf(req.getParameter("reviewId"));
//			Integer memId = (Integer) session.getAttribute("mem");
//			Integer memId = Integer.valueOf(req.getParameter("mem"));
			
			String rptType = req.getParameter("rptType").trim();
			String rptTypeReg = "^.{2,20}$";
			if (rptType == null || rptType.trim().length() == 0) {
				errorMsgs.put("rptType", "檢舉類型: 請勿空白");
			} else if (!rptType.trim().matches(rptTypeReg)) {
				errorMsgs.put("rptType", "檢舉類型: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到20之間");
			}
			
			String rptDetail = req.getParameter("rptDetail").trim();
			String rptDetailReg = "^.{2,100}$";
			if (rptDetail == null || rptDetail.trim().length() == 0) {
				errorMsgs.put("rptDetail", "檢舉內容: 請勿空白");
			} else if (!rptDetail.trim().matches(rptDetailReg)) {
				errorMsgs.put("rptDetail", "檢舉內容: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到100之間");
			}

			if (!errorMsgs.isEmpty()) {
				res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                Map<String, Object> response = new LinkedHashMap<>();
                response.put("success", false);
                response.put("errorMessage", "檢舉失敗: " + String.join(", ", errorMsgs.values()));
                ObjectMapper mapper = new ObjectMapper();
                res.getWriter().write(mapper.writeValueAsString(response));
                return; // 程式中斷
			}

			Report report = new Report();
			
			Review review = new Review();
			review.setReviewId(reviewId);
			report.setReview(review);
			
			Mem mem = new Mem();
			mem.setMemId(240001);
			report.setMem(mem);

			report.setRptType(rptType);
			report.setRptDetail(rptDetail);
			Timestamp rptDate = new Timestamp(System.currentTimeMillis());
			report.setRptDate(rptDate);
			report.setRptStatus("未審核");
			
			reportService.addReport(report);
			res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            Map<String, Object> response = new LinkedHashMap<>();
            response.put("success", true);
            response.put("message", "檢舉成功");
            ObjectMapper mapper = new ObjectMapper();
            res.getWriter().write(mapper.writeValueAsString(response));
		}
	}

}
