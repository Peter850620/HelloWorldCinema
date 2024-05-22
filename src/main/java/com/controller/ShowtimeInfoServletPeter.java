package com.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.ShowtimeInfo;
import com.service.ShowtimeInfoServicePeter;

@WebServlet("/showtimeInfo/showtimeInfoPeter.do")
public class ShowtimeInfoServletPeter extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getDate_For_Display".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 **********************/
			String screenId = null;
			Date playdate = null;
			Integer movieId = null;
			
			String TEST = req.getParameter("playdate");
			System.out.println(TEST);
			//非NULL值
			if (!("NULL".equals(req.getParameter("screenId")))) {
				screenId = String.valueOf(req.getParameter("screenId"));
			}
			if (!((req.getParameter("playdate")).isEmpty())) {
				playdate = Date.valueOf(req.getParameter("playdate"));
			}
			if (!("NULL".equals(req.getParameter("movieId")))) {
				movieId = Integer.valueOf(req.getParameter("movieId"));
			}

			/*************************** 2.開始查詢資料 ****************************************/
			ShowtimeInfoServicePeter showtimeInfoSvc = new ShowtimeInfoServicePeter();
			List<ShowtimeInfo> showtimeInfo = showtimeInfoSvc.getDate(screenId, playdate, movieId);
			if (showtimeInfo == null) {
				errorMsgs.put("movieId", "查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/showtimeInfo/listAllShowtimeInfo.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("showtimeInfoListDataPart", showtimeInfo);// 資料庫取出的food物件,存入req
			String url = "/back_end/showtimeInfo/listAllShowtimeInfo.jsp";
//			String url = "/back_end/food/listOneFood.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
	}
}
