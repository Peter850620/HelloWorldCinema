package com.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Merch;
import com.entity.MerchItem;
import com.entity.MerchOrder;
import com.service.MerchItemService;


@WebServlet("/merchItem/merchItem.do")
public class MerchItemServlet extends HttpServlet{
	
	private MerchItemService merchItemService;
	
	@Override
	public void init() throws ServletException{
		merchItemService = new MerchItemService();
	}


	protected void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
//		<==============================前台===============================>		

//		列出訂單所有明細
		if("listAll_For_Item".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			/*************************** 1.接收請求參數 **********************/
			
			Integer merchNo = Integer.valueOf(req.getParameter("merchNo"));

			/*************************** 2.開始查詢資料 ****************************************/
			MerchItemService merchItemSvc = new MerchItemService();
			List<MerchItem> merchItem = merchItemSvc.showByNo(merchNo);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("merchItem", merchItem);
			String url = "/front_end/merchOrder/listMerchOrderItem.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
	
		
//		<==============================後台===============================>
		
//		查詢訂單所有明細
		if("getAll_For_Item".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			/*************************** 1.接收請求參數 **********************/
			
			Integer merchNo = Integer.valueOf(req.getParameter("merchNo"));

			/*************************** 2.開始查詢資料 ****************************************/
			MerchItemService merchItemSvc = new MerchItemService();
			List<MerchItem> merchItem = merchItemSvc.getByNo(merchNo);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("merchItem", merchItem);
			String url = "/back_end/merchOrder/listMerchOrderItem.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
	}
}
