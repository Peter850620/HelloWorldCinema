package com.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Food;
import com.service.FoodService;

@WebServlet("/food/food.do")
@MultipartConfig(fileSizeThreshold = 0 * 1024 * 1024, maxFileSize = 1 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class FoodServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			String str = req.getParameter("foodId");
			if (str == null || (str.trim().length()) == 0) {
				errorMsgs.put("foodId", "請輸入食物編號");
			}

			Integer foodId = null;
			try {
				foodId = Integer.valueOf(str);
			} catch (Exception e) {
				errorMsgs.put("foodId", "食物編號格式不符");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/food/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			/*************************** 2.開始查詢資料 *****************************************/
			FoodService foodSvc = new FoodService();
			Food food = foodSvc.getOneFood(foodId);
			if (food == null) {
				errorMsgs.put("foodId", "查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/food/select_page.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("Food", food);// 資料庫取出的food物件,存入req
			req.setAttribute("getOne_For_Display", "true");
			String url = "/back_end/food/select_page.jsp";
//			String url = "/back_end/food/listOneFood.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("getOne_For_Update".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 **********************/
			Integer foodId = Integer.valueOf(req.getParameter("foodId"));

			/*************************** 2.開始查詢資料 ****************************************/
			FoodService foodSvc = new FoodService();
			Food food = foodSvc.getOneFood(foodId);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			String param = "?foodId=" + food.getFoodId() + "&foodName=" + food.getFoodName() + "&foodDetails="
					+ food.getFoodDetails() + "&foodPic=" + food.getFoodPic() + "&foodPrice=" + food.getFoodPrice()
					+ "&foodStatus=" + food.getFoodStatus();
			String url = "/back_end/food/update_food_input.jsp" + param;
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			Integer foodId = Integer.valueOf(req.getParameter("foodId").trim());

			String foodName = req.getParameter("foodName");
			String foodNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
			if (foodName == null || foodName.trim().length() == 0) {
				errorMsgs.put("foodName", "食物名稱: 請勿空白");
			} else if (!foodName.trim().matches(foodNameReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.put("foodName", "食物名稱: 只能是中、英文字母、數字和_ , 且長度必需在1到30之間");
			}

			String foodDetails = req.getParameter("foodDetails").trim();
			if (foodDetails == null || foodDetails.trim().length() == 0) {
				errorMsgs.put("foodDetails", "食物描述請勿空白");
			}

			// 修改圖片
			byte[] foodPic = null;
			InputStream in = req.getPart("foodPic").getInputStream(); // 從javax.servlet.http.Part物件取得上傳檔案的InputStream
			if (in.available() != 0) {
				foodPic = new byte[in.available()];
				in.read(foodPic);
				in.close();
			} else {
				FoodService foodSvc = new FoodService();
				foodPic = foodSvc.getOneFood(foodId).getFoodPic();
			}

			Integer foodPrice = null;
			try {
				foodPrice = Integer.valueOf(req.getParameter("foodPrice").trim());
			} catch (NumberFormatException e) {
				foodPrice = 0;
				errorMsgs.put("foodPrice", "價格請填數字.");
			}

			String foodStatus = req.getParameter("foodStatus");

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				errorMsgs.put("Exception", "修改資料失敗:---------------");
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/food/update_food_input.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			/*************************** 2.開始修改資料 *****************************************/
			FoodService foodSvc = new FoodService();
			Food food = foodSvc.updateFood(foodId, foodName, foodDetails, foodPrice, foodPic, foodStatus);

			/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
			req.setAttribute("success", "- (修改成功)");
			req.setAttribute("Food", food); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "/back_end/food/listOneFood.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
			String foodName = req.getParameter("foodName");
			String foodNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
			if (foodName == null || foodName.trim().length() == 0) {
				errorMsgs.put("foodName", "食物名稱: 請勿空白");
			} else if (!foodName.trim().matches(foodNameReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.put("foodName", "食物名稱: 只能是中、英文字母、數字和_ , 且長度必需在1到30之間");
			}

			String foodDetails = req.getParameter("foodDetails").trim();
			if (foodDetails == null || foodDetails.trim().length() == 0) {
				errorMsgs.put("foodDetails", "食物描述請勿空白");
			}

			// 新增圖片
			byte[] foodPic = null;
			InputStream in = req.getPart("foodPic").getInputStream(); // 從javax.servlet.http.Part物件取得上傳檔案的InputStream
			if (in.available() != 0) {
				foodPic = new byte[in.available()];
				in.read(foodPic);
				in.close();
			} else {
				errorMsgs.put("foodPic", "食物圖片: 請上傳照片");
			}

			Integer foodPrice = null;
			try {
				foodPrice = Integer.valueOf(req.getParameter("foodPrice").trim());
			} catch (NumberFormatException e) {
				foodPrice = 0;
				errorMsgs.put("foodPrice", "價格請填數字.");
			}

			String foodStatus = req.getParameter("foodStatus");

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/food/addFood.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2.開始新增資料 ***************************************/
			FoodService foodSvc = new FoodService();
			Food food = foodSvc.addfood(foodName, foodDetails, foodPrice, foodPic, foodStatus);

			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			req.setAttribute("success", "- (新增成功)");
			String url = "/back_end/food/listAllFood.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
	
				/***************************1.接收請求參數***************************************/
				Integer foodId = Integer.valueOf(req.getParameter("foodId"));
				
				/***************************2.開始刪除資料***************************************/
				FoodService foodSvc = new FoodService();
				foodSvc.deleteFood(foodId);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				req.setAttribute("success", "- (刪除成功)");
				String url = "/back_end/food/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
		}	
	}
}
