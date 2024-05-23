package com.controller;

import java.io.IOException;
import java.sql.Date;
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

import com.entity.Mem;
import com.entity.Merch;
import com.entity.MerchItem;
import com.entity.MerchOrder;
import com.service.MerchItemService;
import com.service.MerchOrderService;


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
		
		
//		生成訂單
		if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);
		
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				MerchOrder merchOrder = (MerchOrder)req.getSession().getAttribute("merchOrder");
				Integer merchNo = merchOrder.getMerchNo();
				
				Merch merch = (Merch)req.getSession().getAttribute("merch");
				Integer merchId = merch.getMerchId();
				
				Integer merchQty = Integer.valueOf(req.getParameter("merchQty"));
				
				Integer merchSubTotal = Integer.valueOf(req.getParameter("merchSubTotal"));
				
				
				

				MerchItem merchItem = new MerchItem();
				merchItem.setMerchOrder(merchOrder);
				merchItem.setMerch(merch);
				merchItem.setMerchQty(merchQty);
				merchItem.setMerchSubTotal(merchSubTotal);
				

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("merchItem", merchItem);
					RequestDispatcher failureReq = req.getRequestDispatcher("/front_end/merchOrder/cartCheck.jsp");
					failureReq.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				MerchItemService merchItemSvc = new MerchItemService();
				merchItem = merchItemSvc.addMerchItem(merchOrder, merch, merchQty, merchSubTotal);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("merchOrder", merchOrder);
				String url = "/front_end/merchOrder/addMerchOrder.jsp";
				RequestDispatcher success = req.getRequestDispatcher(url);
				success.forward(req, res);
		}
		
		
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
