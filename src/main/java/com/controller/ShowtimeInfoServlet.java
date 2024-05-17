package com.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.ShowtimeInfo;
import com.service.ShowtimeInfoService;

@WebServlet("/showtimeInfo/showtimeInfo.do")
public class ShowtimeInfoServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("getDate_For_Display".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 **********************/
			Integer showtimeId = Integer.valueOf(req.getParameter("showtimeId"));
			Integer  = Integer.valueOf(req.getParameter(""));
			Integer  = Integer.valueOf(req.getParameter("showtimeId"));

			/*************************** 2.開始查詢資料 ****************************************/
			ShowtimeInfoService showtimeInfoSvc = new ShowtimeInfoService();
			ShowtimeInfo showtimeInfo = showtimeInfoSvc.getDate(showtimeId,playdate,movie);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			String param = "?foodId=" + food.getFoodId() + "&foodName=" + food.getFoodName() + "&foodDetails="
					+ food.getFoodDetails() + "&foodPic=" + food.getFoodPic() + "&foodPrice=" + food.getFoodPrice()
					+ "&foodStatus=" + food.getFoodStatus();
			String url = "/back_end/food/update_food_input.jsp" + param;
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
		}
	}
}
