package com.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.HomeAnn;
import com.service.HomeAnnService;
import com.service.HomeAnnServiceImpl;

@WebServlet("/front/homeAnn.do")
public class HomeAnnFrontServlet extends HttpServlet {


	// 一個 servlet 實體對應一個 service 實體
	private HomeAnnService homeAnnService;

	@Override
	public void init() throws ServletException {
		homeAnnService = new HomeAnnServiceImpl();
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
		
		if ("getAll".equals(action)) {
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<HomeAnn> homeAnnList = homeAnnService.getAllHomeAnns(currentPage);

			if (req.getSession().getAttribute("homeAnnPageQty") == null) {
				int homeAnnPageQty = homeAnnService.getPageTotal();
				req.getSession().setAttribute("homeAnnPageQty", homeAnnPageQty);
			}

			req.setAttribute("homeAnnList", homeAnnList);
			req.setAttribute("currentPage", currentPage);
			String url = "/front_end/homeAnn/homeAnnFront.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		
		if ("compositeQuery".equals(action)) {
			Map<String, String[]> map = req.getParameterMap();
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<HomeAnn> homeAnnList = homeAnnService.getByCompositeQuery(map, currentPage);

			int homeAnnPageQty = 1;
			if (map != null) {
				homeAnnPageQty = homeAnnService.getCompositeQueryTotal(map);
			}
			
			req.getSession().setAttribute("homeAnnPageQty", homeAnnPageQty);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("homeAnnList", homeAnnList);
			String url = "/front_end/homeAnn/homeAnnFront.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("getHomeAnn".equals(action)) {
			Integer annId = Integer.parseInt(req.getParameter("annId"));
			HomeAnn homeAnn = homeAnnService.getByHomeAnn(annId);
			String param = "?annId=" + homeAnn.getAnnId() + "&annTitle=" + homeAnn.getAnnTitle() + "&annDetail="
					+ homeAnn.getAnnDetail() + "&annTime=" + homeAnn.getAnnTime();

			String url = "/front_end/homeAnn/homeAnnFrontCheck.jsp" + param;
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		
	}
}
