package com.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.Mem;
import com.entity.Message;
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
				HttpSession session = req.getSession();
				Mem mem = (Mem)session.getAttribute("mem");

				String page = req.getParameter("page");
				int currentPage = (page == null) ? 1 : Integer.parseInt(page);		
				List<Message> messageList = messageService.getByMem(mem, currentPage);
	
				if (req.getSession().getAttribute("messagePageQty") == null) {
					int messagePageQty = messageService.getPageTotal();
					req.getSession().setAttribute("messagePageQty", messagePageQty);
				}
				
				req.setAttribute("messageList", messageList);
				req.setAttribute("currentPage", currentPage);
				req.setAttribute("action", action);
				
				String url = "/front_end/message/personalMessage.jsp";   
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}

//			if ("compositeQuery".equals(action)) { 
//				Map<String, String[]> map = req.getParameterMap();
//				String page = req.getParameter("page");
//				int currentPage = (page == null) ? 1 : Integer.parseInt(page);
//				int messagePageQty = 1;
//				
//				Map<String, Object> convertedMap = new HashMap<>();
//		        for (Map.Entry<String, String[]> entry : map.entrySet()) {
//		            String key = entry.getKey();
//		            String[] values = entry.getValue();
//
//		            if (values.length == 1) {
//		                convertedMap.put(key, values[0]);
//		            } else {
//		                convertedMap.put(key, Arrays.asList(values));
//		            }
//		        }
//		        req.setAttribute("convertedMap", convertedMap);
//				if (map != null) {
//					List<Message> messageList = messageService.getByCompositeQuery(map, currentPage);
//					messagePageQty = messageService.getCompositeQueryTotal(map);
//					req.getSession().setAttribute("messagePageQty", messagePageQty);
//					req.setAttribute("currentPage", currentPage);
//					req.setAttribute("messageList", messageList);
//					req.setAttribute("action", action);
//				}
//				String url = "/front_end/message/personalMessage.jsp";   
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);
//			}	
				
			if ("getMessage".equals(action)) { 
				Integer msgId = Integer.parseInt(req.getParameter("msgId"));
				Message message = messageService.getByMessage(msgId);
				
				if((message.getMsgStatus()).equals("未讀")) {
					message.setMsgStatus("已讀");
					messageService.updateMessage(message);
				}
				req.setAttribute("message", message);
				String url = "/front_end/message/messageFrontCheck.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			
		}
}
