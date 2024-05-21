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

import com.entity.HomeAnn;
import com.service.HomeAnnService;
import com.service.HomeAnnServiceImpl;

@WebServlet("/back/homeAnn.do")
public class HomeAnnBackServlet extends HttpServlet {

	// 一個 servlet 實體對應一個 service 實體
	private HomeAnnService homeAnnService;

	@Override
	public void init() throws ServletException {
		homeAnnService = new HomeAnnServiceImpl();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		System.out.print(action);

		if ("getAll".equals(action)) {
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<HomeAnn> homeAnnList = homeAnnService.getAllHomeAnns(currentPage);

			if (req.getSession().getAttribute("homeAnnPageQty") == null) {
				int homeAnnPageQty = homeAnnService.getPageTotal();
				req.getSession().setAttribute("homeAnnPageQty", homeAnnPageQty);
			}

			req.setAttribute("homeAnnList", homeAnnList);
			req.setAttribute("currentPage", currentPage);
			String url = "/back_end/homeAnn/select_homeAnn.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("compositeQuery".equals(action)) {
			Map<String, String[]> map = req.getParameterMap();
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<HomeAnn> homeAnnList = homeAnnService.getByCompositeQuery(map, currentPage);

			int homeAnnPageQty = 1;
			if (map != null) {
				homeAnnPageQty = homeAnnService.getCompositeQueryTotal(map);
			}

			req.getSession().setAttribute("homeAnnPageQty", homeAnnPageQty);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("homeAnnList", homeAnnList);
			String url = "/back_end/homeAnn/select_homeAnn.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("getUpdate".equals(action)) {
			Integer annId = Integer.parseInt(req.getParameter("annId"));
			HomeAnn homeAnn = homeAnnService.getByHomeAnn(annId);
			String param = "?annId=" + homeAnn.getAnnId() + "&annTitle=" + homeAnn.getAnnTitle() + "&annDetail="
					+ homeAnn.getAnnDetail() + "&annTime=" + homeAnn.getAnnTime();

			String url = "/back_end/homeAnn/update_homeAnn.jsp" + param;
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("update".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			Integer annId = Integer.parseInt(req.getParameter("annId").trim());
			String annTitle = req.getParameter("annTitle");
			String annTitleReg = "^.{2,20}$";
			if (annTitle == null || annTitle.trim().length() == 0) {
				errorMsgs.put("annTitle", "公告標題: 請勿空白");
			} else if (!annTitle.trim().matches(annTitleReg)) {
				errorMsgs.put("annTitle", "公告標題: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到20之間");
			}
			String annDetail = req.getParameter("annDetail");
			String annDetailReg = "^.{2,250}$";
			if (annDetail == null || annDetail.trim().length() == 0) {
				errorMsgs.put("annDetail", "公告內容: 請勿空白");
			} else if (!annDetail.trim().matches(annDetailReg)) {
				errorMsgs.put("annDetail", "公告內容: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到250之間");
			}

			if (!errorMsgs.isEmpty()) {
				errorMsgs.put("Exception", "修改資料失敗:---------------");
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/homeAnn/update_homeAnn.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			HomeAnn homeAnn = homeAnnService.getByHomeAnn(annId);

			homeAnn.setAnnTitle(annTitle);
			homeAnn.setAnnDetail(annDetail);
			Timestamp annTime = new Timestamp(System.currentTimeMillis());
			homeAnn.setAnnTime(annTime);
			homeAnnService.updateHomeAnn(homeAnn);

			req.setAttribute("success", "- (修改成功)");
			req.setAttribute("homeAnn", homeAnn);
			String url = "/back_end/homeAnn/listOneHomeAnn.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("insert".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			String annTitle = req.getParameter("annTitle").trim();
			String annTitleReg = "^.{2,20}$";
			if (annTitle == null || annTitle.trim().length() == 0) {
				errorMsgs.put("annTitle", "公告標題: 請勿空白");
			} else if (!annTitle.trim().matches(annTitleReg)) {
				errorMsgs.put("annTitle", "公告標題: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到20之間");
			}
			String annDetail = req.getParameter("annDetail").trim();
			String annDetailReg = "^.{2,250}$";
			if (annDetail == null || annDetail.trim().length() == 0) {
				errorMsgs.put("annDetail", "公告內容: 請勿空白");
			} else if (!annDetail.trim().matches(annDetailReg)) {
				errorMsgs.put("annDetail", "公告內容: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到250之間");
			}

			if (!errorMsgs.isEmpty()) {
				errorMsgs.put("Exception", "新增資料失敗:---------------");
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/homeAnn/addHomeAnn.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			HomeAnn homeAnn = new HomeAnn();

			homeAnn.setAnnTitle(annTitle);
			homeAnn.setAnnDetail(annDetail);
			Timestamp annTime = new Timestamp(System.currentTimeMillis());
			homeAnn.setAnnTime(annTime);

			homeAnnService.addHomeAnn(homeAnn);
			req.setAttribute("homeAnn", homeAnn);
			req.setAttribute("success", "- (新增成功)");
			String url = "/back_end/homeAnn/listOneHomeAnn.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

	}

}
