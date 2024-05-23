package com.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;
import com.service.ScreenServicePeter;
import com.service.ShowtimeInfoServicePeter;

@WebServlet("/showtimeInfo/showtimeInfoPeter.do")
public class ShowtimeInfoServletPeter extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 **********************/
			Screen screenId = null;
			Date playdate = null;
			Movie movieId = null;
			Time showtime = null;
			Time endtime = null;
			Screen seatStatus = null;

			screenId.setScreenId(String.valueOf(req.getParameter("screenId")));
			playdate = Date.valueOf(req.getParameter("playdate"));
			movieId.setMovieId(Integer.valueOf(req.getParameter("movieId")));
			showtime = Time.valueOf(req.getParameter("showtime"));
			endtime = Time.valueOf(req.getParameter("endtime"));
			
			ScreenServicePeter screenServicePeter = new ScreenServicePeter();
			seatStatus = screenServicePeter.getSeatNo(Integer.valueOf(req.getParameter("screenId")));



			/*************************** 2.開始新增資料 ***************************************/
			ShowtimeInfoServicePeter showtimeInfoSvc = new ShowtimeInfoServicePeter();
			ShowtimeInfo showtimeInfo = showtimeInfoSvc.addShowtimeInfo(screenId, playdate, movieId, showtime, endtime, seatStatus.getSeatNo());
					
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			req.setAttribute("success", "- (新增成功)");
			String url = "/back_end/showtimeInfo/listAllShowtimeInfo.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);
		}

		if ("getDate_For_Display".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 **********************/
			String screenId = null;
			Date playdate = null;
			Integer movieId = null;

			String TEST = req.getParameter("playdate");
			System.out.println(TEST);
			// 非NULL值
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
