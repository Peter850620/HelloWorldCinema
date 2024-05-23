package com.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Mem;
import com.entity.MerchOrder;
import com.service.MerchOrderService;





@WebServlet("/merchOrder/merchOrder.do")
public class MerchOrderServlet extends HttpServlet{

	private MerchOrderService merchOrderService;
	
	@Override
	public void init() throws ServletException{
		merchOrderService = new MerchOrderService();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		doPost(req, res);
}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

//		生成訂單
		if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);
		
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer merchNo = Integer.valueOf(req.getParameter("merchNo"));
				
				Mem mem = (Mem)req.getSession().getAttribute("mem");
				Integer memId = mem.getMemId();
				
				Date orderDate = null;
				
				String pickupOption = req.getParameter("pickupOption");
				
				String paymentType = req.getParameter("paymentType");
				
				String receiptStatus = null;
				
				Integer merchTotal = Integer.valueOf(req.getParameter("merchTotal"));
				
				
				String recipient = req.getParameter("recipient");
				String recipientReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (recipient == null || recipient.trim().length() == 0) {
					errorMsgs.add("收貨人姓名: 請勿空白");
				} else if(!recipient.trim().matches(recipientReg)) {
					errorMsgs.add("收貨人姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				
				String receiptAddr = req.getParameter("receiptAddr");
				String receiptAddrReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
				if (receiptAddr == null || receiptAddr.trim().length() == 0) {
					errorMsgs.add("收貨人姓名: 請勿空白");
				} else if(!receiptAddr.trim().matches(receiptAddrReg)) {
					errorMsgs.add("收貨人姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				

				String receiptMobile = req.getParameter("receiptMobile");
				String receiptMobileReg = "^[0-9]{2,10}$";
				if (receiptMobile == null || receiptMobile.trim().length() == 0) {
					errorMsgs.add("收貨人電話: 請勿空白");
				} else if(!receiptMobile.trim().matches(receiptMobileReg)) {
					errorMsgs.add("收貨人電話: 只能是數字和_ , 且長度必需在2到10之間");
	            }
				


				MerchOrder merchOrder = new MerchOrder();
				merchOrder.setMerchNo(merchNo);
				merchOrder.setMem(mem);
				merchOrder.setOrderDate(orderDate);
				merchOrder.setPickupOption(pickupOption);
				merchOrder.setPaymentType(paymentType);
				merchOrder.setReceiptStatus(receiptStatus);
				merchOrder.setMerchTotal(merchTotal);
				merchOrder.setRecipient(recipient);
				merchOrder.setReceiptAddr(receiptAddr);
				merchOrder.setReceiptMobile(receiptMobile);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("merchOrder", merchOrder);
					RequestDispatcher failureReq = req.getRequestDispatcher("/front_end/merchOrder/cartCheck.jsp");
					failureReq.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				MerchOrderService merchOrderSvc = new MerchOrderService();
				merchOrder = merchOrderSvc.addMerchOrder(merchNo, mem, orderDate, pickupOption, paymentType,
						receiptStatus, merchTotal, recipient, receiptAddr, receiptMobile);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("merchOrder", merchOrder);
				String url = "/front_end/merchOrder/addMerchOrder.jsp";
				RequestDispatcher success = req.getRequestDispatcher(url);
				success.forward(req, res);
		}
		
		
		
		
//		查詢訂單編號
		if("getByNo".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String str = req.getParameter("merchNo");
			if(str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入訂單編號");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = (RequestDispatcher) req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			
			Integer merchNo = null;
			try {
				merchNo = Integer.valueOf(str);
			}catch(Exception e) {
				errorMsgs.add("訂單編號格式不正確");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			/***************************2.開始查詢資料*****************************************/
			MerchOrderService merchOrderSvc = new MerchOrderService();
			MerchOrder merchOrder = merchOrderSvc.getByNo(merchNo);
			if(merchOrder == null) {
				errorMsgs.add("查無此筆訂單");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			/***************************3.查詢完成,準備轉交(Send the Success view)*************/
			req.setAttribute("merchOrder", merchOrder);
			String url = "/back_end/merchOrder/listOneMerchOrder.jsp";
			RequestDispatcher success = req.getRequestDispatcher(url);
			success.forward(req, res);
		}
		
//		查詢會員編號
		if("getById".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String str = req.getParameter("memId");

			if(str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入會員編號");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = (RequestDispatcher) req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			
			Integer memId = null;
			try {
				memId = Integer.valueOf(str);

			}catch(Exception e) {
				errorMsgs.add("會員編號格式不正確");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			/***************************2.開始查詢資料*****************************************/
			MerchOrderService merchOrderSvc = new MerchOrderService();
			List<MerchOrder> merchOrder = merchOrderSvc.getById(memId);

			if(merchOrder == null) {
				errorMsgs.add("查無此筆訂單");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			/***************************3.查詢完成,準備轉交(Send the Success view)*************/
			req.setAttribute("merchOrder", merchOrder);
			String url = "/back_end/merchOrder/listMemMerchOrder.jsp";
			RequestDispatcher success = req.getRequestDispatcher(url);
			success.forward(req, res);
		}
		
		
//		查詢收件人電話
		if("getByMobile".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String str = req.getParameter("receiptMobile");
			if(str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入收件人電話");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = (RequestDispatcher) req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			
			String receiptMobile = null;
			try {
				receiptMobile = String.valueOf(str);
			}catch(Exception e) {
				errorMsgs.add("收件電話格式不正確");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			/***************************2.開始查詢資料*****************************************/
			MerchOrderService merchOrderSvc = new MerchOrderService();
			MerchOrder merchOrder = merchOrderSvc.getByMobile(receiptMobile);
			if(merchOrder == null) {
				errorMsgs.add("查無此筆訂單");
			}
			
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/merchOrder/select_page.jsp");
				failureReq.forward(req, res);
				return;
			}
			/***************************3.查詢完成,準備轉交(Send the Success view)*************/
			req.setAttribute("merchOrder", merchOrder);
			String url = "/back_end/merchOrder/listOneMerchOrder.jsp";
			RequestDispatcher success = req.getRequestDispatcher(url);
			success.forward(req, res);
		}
		
		//修改訂單
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
				/***************************1.接收請求參數****************************************/
				Integer merchNo = Integer.valueOf(req.getParameter("merchNo"));
				
				/***************************2.開始查詢資料****************************************/
				MerchOrderService merchOrderSvc = new MerchOrderService();
				MerchOrder merchOrder = merchOrderSvc.getOneMerchOrder(merchNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("merchOrder", merchOrder);
				String url = "/back_end/merchOrder/updateMerchOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
		}
		
		

//		修改訂單
		if ("update".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();
		
					req.setAttribute("errorMsgs", errorMsgs);
				
						/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
						Integer merchNo = Integer.valueOf(req.getParameter("merchNo"));
						
						String pickupOption = String.valueOf(req.getParameter("pickupOption").trim());
						
						String paymentType = String.valueOf(req.getParameter("paymentType").trim());
						
						String receiptStatus = String.valueOf(req.getParameter("receiptStatus").trim());
						
						
						String recipient = req.getParameter("recipient");
						String recipientReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
						if (recipient == null || recipient.trim().length() == 0) {
							errorMsgs.add("收貨人姓名: 請勿空白");
						} else if(!recipient.trim().matches(recipientReg)) {
							errorMsgs.add("收貨人姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
			            }
						
						
						String receiptAddr = req.getParameter("receiptAddr");
						String receiptAddrReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
						if (receiptAddr == null || receiptAddr.trim().length() == 0) {
							errorMsgs.add("收貨人姓名: 請勿空白");
						} else if(!receiptAddr.trim().matches(receiptAddrReg)) {
							errorMsgs.add("收貨人姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
			            }
						
		
						String receiptMobile = req.getParameter("receiptMobile");
						String receiptMobileReg = "^[0-9]{2,10}$";
						if (receiptMobile == null || receiptMobile.trim().length() == 0) {
							errorMsgs.add("收貨人電話: 請勿空白");
						} else if(!receiptMobile.trim().matches(receiptMobileReg)) {
							errorMsgs.add("收貨人電話: 只能是數字和_ , 且長度必需在2到10之間");
			            }
						
		
		
						MerchOrder merchOrder = new MerchOrder();
						merchOrder.setMerchNo(merchNo);
						merchOrder.setPickupOption(pickupOption);
						merchOrder.setPaymentType(paymentType);
						merchOrder.setReceiptStatus(receiptStatus);
						merchOrder.setRecipient(recipient);
						merchOrder.setReceiptAddr(receiptAddr);
						merchOrder.setReceiptMobile(receiptMobile);
		
						if (!errorMsgs.isEmpty()) {
							req.setAttribute("merchOrder", merchOrder);
							RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/merchOrder/updateMerchOrder.jsp");
							failureReq.forward(req, res);
							return; //程式中斷
						}
						
						/***************************2.開始修改資料*****************************************/
						MerchOrderService merchOrderSvc = new MerchOrderService();
						merchOrder = merchOrderSvc.updateMerchOrder(merchNo, pickupOption, paymentType,
								receiptStatus, recipient, receiptAddr, receiptMobile);
						
						/***************************3.修改完成,準備轉交(Send the Success view)*************/
						req.setAttribute("merchOrder", merchOrder);
						String url = "/back_end/merchOrder/listOneMerchOrder.jsp";
						RequestDispatcher success = req.getRequestDispatcher(url);
						success.forward(req, res);
				}
	}
}
