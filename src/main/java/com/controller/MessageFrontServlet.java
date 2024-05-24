package com.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Mem;
import com.entity.Message;
import com.entity.Movie;
import com.entity.Review;
import com.service.MessageService;
import com.service.MessageServiceImpl;

@WebServlet("/front/message.do")
public class MessageFrontServlet extends HttpServlet {

	// 一個 servlet 實體對應一個 service 實體
		private MessageService messageService;

		@Override
		public void init() throws ServletException {
			messageService = new MessageServiceImpl();
			
		}

		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doPost(req, res);
		}
		
		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			
			System.out.print(action);
			
			if ("getMem".equals(action)) { 
				Integer memId = Integer.parseInt(req.getParameter("mem"));
				
//						HttpSession session = req.getSession();
//						Integer memId = (Integer) session.getAttribute("mem");
				
				Mem mem = new Mem();
				mem.setMemId(memId);
				String page = req.getParameter("page");
				int currentPage = (page == null) ? 1 : Integer.parseInt(page);		
				List<Message> messageList = messageService.getByMem(mem, currentPage);
	
				if (req.getSession().getAttribute("messagePageQty") == null) {
					int messagePageQty = messageService.getPageTotal();
					req.getSession().setAttribute("messagePageQty", messagePageQty);
				}
				
				req.setAttribute("messageList", messageList);
				req.setAttribute("currentPage", currentPage);
				
				String url = "/front_end/message/personalMessage.jsp";   
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			
//					
//					if ("compositeQuery".equals(action)) { 
//						Map<String, String[]> map = req.getParameterMap();
//							
//						if (map != null) {
//							List<Review> reviewList = reviewService.getByCompositeQuery(map);
//							req.setAttribute("reviewList", reviewList);
//						}
//						String url = "/review/select_page.jsp";   
//						RequestDispatcher successView = req.getRequestDispatcher(url);
//						successView.forward(req, res);
//					}	
				
			if ("getMessage".equals(action)) { 
				Integer msgId = Integer.parseInt(req.getParameter("msgId"));
				Message message = messageService.getByMessage(msgId);
				
				if((message.getMsgStatus()).equals("未讀")) {
					message.setMsgStatus("已讀");
					messageService.updateMessage(message);
				}
				
				String param = "?msgId="  +message.getMsgId()+
					       "&mem="  +message.getMem().getMemId()+
					       "&msgTitle="    +message.getMsgTitle()+
					       "&msgDetail="+message.getMsgDetail()+
					       "&msgTime="    +message.getMsgTime()+
					       "&msgStatus="   +message.getMsgStatus();

				String url = "/front_end/message/messageFrontCheck.jsp"+param;
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			
		}
}
