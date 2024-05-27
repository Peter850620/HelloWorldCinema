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
		
		
////		生成訂單
//		if ("insertOrder".equals(action)) {
//			
//			List<String> errorMsgs = new LinkedList<String>();
//
//			req.setAttribute("errorMsgs", errorMsgs);
//		
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				
//			// 接收多筆商品明細資訊
//			    String[] merchIds = req.getParameterValues("merchId[]");
//			    String[] merchQtys = req.getParameterValues("merchQty[]");
//			    String[] merchSubTotals = req.getParameterValues("merchSubTotal[]");
//			
//			    List<MerchItem> merchItemList = new ArrayList<>();
//			
//			    if (merchIds != null && merchQtys != null && merchSubTotals != null
//			            && merchIds.length == merchQtys.length && merchIds.length == merchSubTotals.length) {
//			        for (int i = 0; i < merchIds.length; i++) {
//			            MerchItem merchItem = new MerchItem();
//			            Merch merch = new Merch();
//			            merch.setMerchId(Integer.valueOf(merchIds[i]));
//			            
//
//			            merchItem.setMerch(merch);
//			            merchItem.setMerchQty(Integer.valueOf(merchQtys[i]));
//			            merchItem.setMerchSubTotal(Integer.valueOf(merchSubTotals[i]));
//
//			            merchItemList.add(merchItem);
//			        }
//			    }
//
//
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("merchItemList", merchItemList);
//					RequestDispatcher failureReq = req.getRequestDispatcher("/front_end/merch/addMerchOrder.jsp");
//					failureReq.forward(req, res);
//					return; //程式中斷
//				}
//				
//				/***************************2.開始修改資料*****************************************/
//				// 處理多筆商品明細
//			    MerchItemService merchItemSvc = new MerchItemService();
//			    merchItemSvc.addMerchItems(merchItemList);
//				
//				/***************************3.修改完成,準備轉交(Send the Success view)*************/
//				req.setAttribute("merchItemList", merchItemList);
//				String url = "/front_end/merch/merchStore.jsp";
//				RequestDispatcher success = req.getRequestDispatcher(url);
//				success.forward(req, res);
//		}
		
		
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
