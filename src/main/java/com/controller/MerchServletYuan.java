package com.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Merch;
import com.entity.Movie;
import com.service.MerchServiceYuan;
import com.service.MovieServiceYuan;

@WebServlet("/merch/merch.do")
public class MerchServletYuan extends HttpServlet{

	protected void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		//單一商品
		if("getOneMerch".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			/*************************** 1.接收請求參數 **********************/
			Integer merchId = Integer.valueOf(req.getParameter("merchId"));
		
			/*************************** 2.開始查詢資料 ****************************************/
			MerchServiceYuan merchSvc = new MerchServiceYuan();
			Merch merch = merchSvc.getById(merchId);
		
			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("merch", merch);
			String url = "/front_end/merch/singleMerch.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		
		
		
		//上架
		if ("getNowMerch".equals(action)) {
		    // 調用 getNowMerchs 方法獲取狀態為「上架」的周邊商品
		    String merchStatus = "上架";
		    MerchServiceYuan merchSvc = new MerchServiceYuan();
		    List<Merch> nowMerch = merchSvc.getByStatus(merchStatus);
		
		    // 將狀態為「上架」的周邊商品列表設置到 request 的屬性中
		    req.setAttribute("nowMerch", nowMerch);
		
		    // 轉發到相應的 JSP 文件中顯示結果
		    String url = "/front_end/merch/merchStore.jsp";
		    RequestDispatcher dispatcher = req.getRequestDispatcher(url);
		    dispatcher.forward(req, res);
		}
	}
}
