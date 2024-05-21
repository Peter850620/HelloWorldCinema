package com.controller;

import java.io.IOException;
import java.util.List;
import java.util.LinkedList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Ticket;
import com.service.TicketServiceYuan;


@WebServlet("/ticket/ticket.do")
public class TicketServletYuan extends HttpServlet {

	private TicketServiceYuan ticketService;
	
	@Override
	public void init() throws ServletException{
		ticketService = new TicketServiceYuan();
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		doPost(req, res);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		//查詢票種編號
				if("getById".equals(action)) {
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);
					
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					String str = req.getParameter("tkId");
					if (str == null || (str.trim()).length() == 0) {
						errorMsgs.add("請輸入票種編號");
					}

					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/ticket/select_page.jsp");
						failureReq.forward(req, res);
						return;//程式中斷
					}
					
					Integer tkId = null;
					try {
						tkId = Integer.valueOf(str);
					} catch (Exception e) {
						errorMsgs.add("票種編號格式不正確");
					}

					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/ticket/select_page.jsp");
						failureReq.forward(req, res);
						return;//程式中斷
					}
					
					/***************************2.開始查詢資料*****************************************/
					TicketServiceYuan ticketSvc = new TicketServiceYuan();
					Ticket ticket = ticketSvc.getById(tkId);
					if (ticket == null) {
						errorMsgs.add("查無此票種");
					}

					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/ticket/select_page.jsp");
						failureReq.forward(req, res);
						return;//程式中斷
					}
					
					/***************************3.查詢完成,準備轉交(Send the Success view)*************/
					req.setAttribute("ticket", ticket);
					String url = "/back_end/ticket/listOneTicket.jsp";
					RequestDispatcher success = req.getRequestDispatcher(url);
					success.forward(req, res);
					
				}
				
				
				//查詢票種名稱
				if("getByName".equals(action)) {
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);
					
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					String str = req.getParameter("tkName").trim();
					if (str == null || (str.trim()).length() == 0) {
						errorMsgs.add("請輸入票種名稱");
					}

					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/ticket/select_page.jsp");
						failureReq.forward(req, res);
						return;//程式中斷
					}
					
					String tkName = null;
					try {
						tkName = String.valueOf(str);
					} catch (Exception e) {
						errorMsgs.add("票種名稱格式不正確");
					}

					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/ticket/select_page.jsp");
						failureReq.forward(req, res);
						return;//程式中斷
					}
					
					/***************************2.開始查詢資料*****************************************/
					TicketServiceYuan ticketSvc = new TicketServiceYuan();
					List<Ticket> ticket = ticketSvc.getByName(tkName);
					if (ticket == null) {
						errorMsgs.add("查無此票種");
					}

					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/ticket/select_page.jsp");
						failureReq.forward(req, res);
						return;//程式中斷
					}
					
					/***************************3.查詢完成,準備轉交(Send the Success view)*************/
					req.setAttribute("ticket", ticket);
					String url = "/back_end/ticket/listNameTicket.jsp";
					RequestDispatcher success = req.getRequestDispatcher(url);
					success.forward(req, res);
					
				}
				
				
				
				//新增票種
				if ("insert".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();

					req.setAttribute("errorMsgs", errorMsgs);

						/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
						String tkName = req.getParameter("tkName").trim();
						String tkNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
						if (tkName == null || tkName.trim().length() == 0) {
							errorMsgs.add("票種名稱: 請勿空白");
						} else if(!tkName.trim().matches(tkNameReg)) {
							errorMsgs.add("票種名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
			            }
						
						
						
						String tkInfo = req.getParameter("tkInfo").trim();
						
						
						Integer tkPrice = null;
						try {
							tkPrice = Integer.valueOf(req.getParameter("tkPrice").trim());
						} catch (NumberFormatException e) {
							tkPrice = 0;
							errorMsgs.add("票種價格請填數字.");
						}
						
						
						String tkStatus = String.valueOf(req.getParameter("tkStatus").trim());

						Ticket ticket = new Ticket();
						ticket.setTkName(tkName);
						ticket.setTkInfo(tkInfo);
						ticket.setTkPrice(tkPrice);
						ticket.setTkStatus(tkStatus);


						if (!errorMsgs.isEmpty()) {
							req.setAttribute("ticket", ticket);
							RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/ticket/addTicket.jsp");
							failureReq.forward(req, res);
							return;	//程式中斷
						}
						
						/***************************2.開始新增資料***************************************/
						TicketServiceYuan ticketSvc = new TicketServiceYuan();
						ticket = ticketSvc.addTicket(tkName, tkInfo, tkPrice, tkStatus);
						
						/***************************3.新增完成,準備轉交(Send the Success view)***********/
						String url = "/back_end/ticket/listAllTicket.jsp";
						RequestDispatcher success = req.getRequestDispatcher(url);
						success.forward(req, res);	
				}
				
				
				if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

					List<String> errorMsgs = new LinkedList<String>();
					
					req.setAttribute("errorMsgs", errorMsgs);
					
						/***************************1.接收請求參數****************************************/
						Integer tkId = Integer.valueOf(req.getParameter("tkId"));
						
						/***************************2.開始查詢資料****************************************/
						TicketServiceYuan ticketSvc = new TicketServiceYuan();
						Ticket ticket = ticketSvc.getOneTicket(tkId);
										
						/***************************3.查詢完成,準備轉交(Send the Success view)************/
						req.setAttribute("ticket", ticket);
						String url = "/back_end/ticket/updateTicket.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
						successView.forward(req, res);
				}
				
				
				//更改商品
				if ("update".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();

					req.setAttribute("errorMsgs", errorMsgs);
				
						/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
						Integer tkId = Integer.valueOf(req.getParameter("tkId"));
						String tkName = req.getParameter("tkName");
						String tkNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
						if (tkName == null || tkName.trim().length() == 0) {
							errorMsgs.add("票種名稱: 請勿空白");
						} else if(!tkName.trim().matches(tkNameReg)) {
							errorMsgs.add("票種名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
			            }
						
						
						
						String tkInfo = req.getParameter("tkInfo").trim();


						Integer tkPrice = null;
						try {
							tkPrice = Integer.valueOf(req.getParameter("tkPrice").trim());
						} catch (NumberFormatException e) {
							tkPrice = 0;
							errorMsgs.add("票種價格請填數字.");
						}

						
						String tkStatus = String.valueOf(req.getParameter("tkStatus").trim());


						Ticket ticket = new Ticket();
						ticket.setTkId(tkId);
						ticket.setTkName(tkName);
						ticket.setTkInfo(tkInfo);
						ticket.setTkPrice(tkPrice);
						ticket.setTkStatus(tkStatus);


						if (!errorMsgs.isEmpty()) {
							req.setAttribute("ticket", ticket);
							RequestDispatcher failureReq = req.getRequestDispatcher("/back_end/ticket/updateTicket.jsp");
							failureReq.forward(req, res);
							return; //程式中斷
						}
						
						/***************************2.開始修改資料*****************************************/
						TicketServiceYuan ticketSvc = new TicketServiceYuan();
						ticket = ticketSvc.updateTicket(tkId, tkName, tkInfo, tkPrice, tkStatus);
						
						/***************************3.修改完成,準備轉交(Send the Success view)*************/
						req.setAttribute("ticket", ticket);
						String url = "/back_end/ticket/listOneTicket.jsp";
						RequestDispatcher success = req.getRequestDispatcher(url);
						success.forward(req, res);
				}
			
	}
}
