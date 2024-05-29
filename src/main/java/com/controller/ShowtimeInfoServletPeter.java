package com.controller;

import java.io.IOException;
import java.io.InputStream;
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

import com.entity.Food;
import com.entity.Movie;
import com.entity.Screen;
import com.entity.ShowtimeInfo;
import com.service.FoodService;
import com.service.MovieService;
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
			ScreenServicePeter screenServicePeter = new ScreenServicePeter();
			MovieService movieService = new MovieService();


			Date playdate = null;
			Time showtime = null;
			Time endtime = null;
			String showtimeStatus = "人數未滿";

			String screenId = String.valueOf(req.getParameter("screenId"));
			Integer movieId = Integer.valueOf(req.getParameter("movieId"));
			playdate = Date.valueOf(req.getParameter("playdate"));
			
			// showtime、endtime是否空白
			String showtimecheck = req.getParameter("showtime").trim();
			if (showtimecheck == null || showtimecheck.trim().length() == 0) {
				errorMsgs.put("showtime", "【選擇起始時間】請勿空白");
			}else {
				showtime = Time.valueOf(showtimecheck + ":00");
			}
			String endtimecheck = req.getParameter("endtime").trim();
			if (endtimecheck == null || endtimecheck.trim().length() == 0) {
				errorMsgs.put("endtime", "【選擇起始時間】請勿空白");
			}else {
				endtime = Time.valueOf(endtimecheck + ":00");
			}
			
			Screen screen = screenServicePeter.getById(screenId);
			Movie movie = movieService.findMoviebyId(movieId);
			String screenNO = screen.getSeatNo();

			// 檢查showtime、endtime，是否與現有場次時間重疊
			ShowtimeInfoServicePeter showtimeInfoSvc = new ShowtimeInfoServicePeter();
			List<ShowtimeInfo> result = showtimeInfoSvc.checkShowtimeInfoTime(screenId, playdate, showtime, endtime);
			if(!result.isEmpty()) {
				errorMsgs.put("endtime", "場次編號:" + result.toString() + "，【場次時間】出現重複");
				System.out.println(result);
			}
			
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/showtimeInfo/addShowtimeInfo.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2.開始新增資料 ***************************************/
			ShowtimeInfo showtimeInfo = showtimeInfoSvc.addShowtimeInfo(screen, playdate, movie, showtime, endtime, screenNO, showtimeStatus);
					
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			req.setAttribute("success", "- (新增成功)");
			String url = "/back_end/showtimeInfo/listAllShowtimeInfo.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);
		}

		if ("getOne_For_Update".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 **********************/
			Integer showtimeId = Integer.valueOf(req.getParameter("showtimeId"));

			/*************************** 2.開始查詢資料 ****************************************/
			ShowtimeInfoServicePeter showtimeInfoServicePeter = new ShowtimeInfoServicePeter();
			ShowtimeInfo showtimeInfo = showtimeInfoServicePeter.getById(showtimeId);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			String param = "?showtimeId=" + showtimeInfo.getShowtimeId() + "&movieName=" + showtimeInfo.getMovie().getMovieName()
					+ "&runtime=" + showtimeInfo.getMovie().getRuntime() + "&screenId=" + showtimeInfo.getScreen().getScreenId() 
					+ "&playdate=" + showtimeInfo.getPlaydate() + "&showtime=" + showtimeInfo.getShowtime() + "&endtime=" + showtimeInfo.getEndtime();
			String url = "/back_end/showtimeInfo/update_showtimeInfo_input.jsp" + param;
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_showtimeInfo_input.jsp
			successView.forward(req, res);
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			Date playdate = null;
			Time showtime = null;
			Time endtime = null;
			Integer showtimeId = Integer.valueOf(req.getParameter("showtimeId").trim());
			
			ScreenServicePeter screenServicePeter = new ScreenServicePeter();
			Screen screen = screenServicePeter.getById(req.getParameter("screenId").trim());
			
			playdate = Date.valueOf(req.getParameter("playdate"));

			String showtimecheck = req.getParameter("showtime").trim();
			if (showtimecheck == null || showtimecheck.trim().length() == 0) {
				errorMsgs.put("showtime", "【選擇起始時間】請勿空白");
			}else {
				showtime = Time.valueOf(showtimecheck + ":00");
			}
			String endtimecheck = req.getParameter("endtime").trim();
			if (endtimecheck == null || endtimecheck.trim().length() == 0) {
				errorMsgs.put("endtime", "【選擇起始時間】請勿空白");
			}else {
				endtime = Time.valueOf(endtimecheck + ":00");
			}

			// 檢查showtime、endtime，是否與現有場次時間重疊
			ShowtimeInfoServicePeter showtimeInfoSvc = new ShowtimeInfoServicePeter();
			List<ShowtimeInfo> result = showtimeInfoSvc.checkShowtimeInfoTime(screen.getScreenId(), playdate, showtime, endtime);
			if(!result.isEmpty()) {
				errorMsgs.put("endtime", "場次編號:" + result.toString() + "，【場次時間】出現重複");
				System.out.println(result);
			}

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				errorMsgs.put("Exception", "修改資料失敗:---------------");
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/showtimeInfo/update_showtimeInfo_input.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始修改資料 *****************************************/
			ShowtimeInfo showtimeInfo = showtimeInfoSvc.updateShowtimeInfo(showtimeId, screen, playdate, showtime, endtime);

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("success", "- (修改成功)");
			req.setAttribute("ShowtimeInfo", showtimeInfo); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/back_end/showtimeInfo/listAllShowtimeInfo.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
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
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
	
				/***************************1.接收請求參數***************************************/
				Integer showtimeId = Integer.valueOf(req.getParameter("showtimeId"));
				
				/***************************2.開始刪除資料***************************************/
				ShowtimeInfoServicePeter showtimeInfo = new ShowtimeInfoServicePeter();
				showtimeInfo.delete(showtimeId);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				req.setAttribute("success", "- (刪除成功)");
				String url = "/back_end/showtimeInfo/listAllShowtimeInfo.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
		}	
	}
}
