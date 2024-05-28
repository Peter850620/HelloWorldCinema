package com.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
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
import com.entity.Review;
import com.service.MessageService;
import com.service.MessageServiceImpl;

@WebServlet("/back/message.do")
public class MessageServlet extends HttpServlet {

	// 一個 servlet 實體對應一個 service 實體
	private MessageService messageService;
	
	
	@Override
	public void init() throws ServletException {
		messageService = new MessageServiceImpl();
		
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		System.out.print(action);

		if ("getAll".equals(action)) {
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<Message> messageList = messageService.getAllMessages(currentPage);

			if (req.getSession().getAttribute("messagePageQty") == null) {
				int messagePageQty = messageService.getPageTotal();
				req.getSession().setAttribute("messagePageQty", messagePageQty);
			}
			req.setAttribute("messageList", messageList);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("action", action);

			String url = "/back_end/message/select_message.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("compositeQuery".equals(action)) {
			Map<String, String[]> map = req.getParameterMap();
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<Message> messageList = messageService.getByCompositeQuery(map, currentPage);
			int messagePageQty = 1;
			
			Map<String, Object> convertedMap = new HashMap<>();
	        for (Map.Entry<String, String[]> entry : map.entrySet()) {
	            String key = entry.getKey();
	            String[] values = entry.getValue();

	            if (values.length == 1) {
	                convertedMap.put(key, values[0]);
	            } else {
	                convertedMap.put(key, Arrays.asList(values));
	            }
	        }
			if (map != null) {
				messagePageQty = messageService.getCompositeQueryTotal(map);
			}
			
			req.getSession().setAttribute("messagePageQty", messagePageQty);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("messageList", messageList);
			req.setAttribute("convertedMap", convertedMap);
			req.setAttribute("action", action);
			String url = "/back_end/message/select_message.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		System.out.println("is true: " + "getOne".equals(action));

		if ("getOne".equals(action)) {
			Integer msgId = Integer.parseInt(req.getParameter("msgId"));
			Message message = messageService.getByMessage(msgId);

			req.setAttribute("message", message);
			String url = "/back_end/message/listOneMessage.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("insert".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			Integer memId = null;
			try {
				String memReg = req.getParameter("mem").trim();
			    if(memReg.length() != 6) {
			        throw new NumberFormatException();
			    }
			    memId = Integer.parseInt(memReg);
			} catch (NumberFormatException e) {
				errorMsgs.put("mem","會員編號: 請輸入數字");
			}
			
			String msgTitle = req.getParameter("msgTitle").trim();
			String msgTitleReg = "^.{2,20}$";
			if (msgTitle == null || msgTitle.trim().length() == 0) {
				errorMsgs.put("msgTitle", "通知標題: 請勿空白");
			} else if (!msgTitle.trim().matches(msgTitleReg)) {
				errorMsgs.put("msgTitle", "通知標題: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到20之間");
			}
			
			String msgDetail = req.getParameter("msgDetail").trim();
			String msgDetailReg = "^.{2,250}$";
			if (msgDetail == null || msgDetail.trim().length() == 0) {
				errorMsgs.put("msgDetail", "通知標題: 請勿空白");
			} else if (!msgDetail.trim().matches(msgDetailReg)) {
				errorMsgs.put("msgDetail", "通知標題: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到250之間");
			}

			Timestamp msgTime = new Timestamp(System.currentTimeMillis());
			String msgStatus = req.getParameter("msgStatus").trim();

			if (!errorMsgs.isEmpty()) {
				errorMsgs.put("Exception", "新增資料失敗:---------------");
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/message/addMessage.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			Message message = new Message();

			Mem mem = new Mem();
			mem.setMemId(memId);
			message.setMem(mem);

			message.setMsgTitle(msgTitle);
			message.setMsgDetail(msgDetail);
			message.setMsgTime(msgTime);
			message.setMsgStatus(msgStatus);

			messageService.addMessage(message);

			req.setAttribute("success", "- (新增成功)");
			req.setAttribute("message", message);
			String url = "/back_end/message/listOneMessage.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

	}
}
