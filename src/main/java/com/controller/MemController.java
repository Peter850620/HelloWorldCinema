package com.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.MemDAOImpl;
import com.entity.Mem;

@WebServlet("/MemController")
public class MemController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemController() {
		super();
	}

	private MemDAOImpl memdao;


	@Override
	public void init() throws ServletException {
		memdao = new MemDAOImpl();

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req, res);
	}

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		Map<String, String> errorMsgs;
		String url = "";
		RequestDispatcher successView;

		switch (action) {

		case "logincheck":
			
		String memEmail=	req.getParameter("memEmail");
		String memPassword=req.getParameter("memPassword");

	System.out.println("密碼: " +memPassword);
	
		Mem mem=memdao.getByEmail(memEmail);
		if(mem!=null) {
			
			String password=mem.getMemPassword();
			if(memPassword.equals(password)) {
				   HttpSession session = req.getSession(true);
				   session.setAttribute("mem", mem);
				url="/front_end/movie/movieCommingSoon.jsp";
				successView = req.getRequestDispatcher(url);
		
				
				successView.forward(req, res);
				
				break;
	
			}else {
				
		errorMsgs=new HashMap<>();
				errorMsgs.put("password","請確認密碼");
				req.setAttribute("errorMsgs", errorMsgs);
				url="/front_end/mem/mem.jsp";
				successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				break;
			}
		}else {
			errorMsgs=new HashMap<>();
			errorMsgs.put("account","請輸入有效帳號");
			req.setAttribute("errorMsgs", errorMsgs);
			url="/front_end/mem/mem.jsp";
			successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			
		}

		}
	}

}
