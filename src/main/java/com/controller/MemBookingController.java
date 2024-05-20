package com.controller;

import java.io.IOException;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.BookingDAOImpl;
import com.dao.FoodItemIDAOmpl;
import com.dao.ShowtimeInfoDAOImpl;
import com.entity.Booking;
import com.entity.Food;
import com.entity.FoodItem;
import com.entity.Movie;
import com.entity.OrderItem;
import com.entity.Screen;
import com.entity.ShowtimeInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.MemBookingService;

@WebServlet("/MemBookingController")
public class MemBookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemBookingController() {
		super();
	}

	private BookingDAOImpl dao;

	private FoodItemIDAOmpl daoFoodItem;
	private MemBookingService memBookingService;
	private ShowtimeInfoDAOImpl show;
	private ShowtimeInfo showtimeInfo;

	@Override
	public void init() throws ServletException {
		dao = new BookingDAOImpl();
		daoFoodItem = new FoodItemIDAOmpl();
		memBookingService = new MemBookingService();
		show = new ShowtimeInfoDAOImpl();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		 req.setCharacterEncoding("UTF-8");
	        String action = req.getParameter("action");

	        if ("processScreen".equals(action)) {
	            String screenId = req.getParameter("screenId");
	            System.out.println(screenId);
	            String url = memBookingService.findRightScreenId(Integer.parseInt(screenId)); // 适当调整服务层的方法来接收String类型的screenId

	            if (url != null) {
	                RequestDispatcher dispatcher = req.getRequestDispatcher(url);
	                dispatcher.forward(req, res);
	            } else {
	                res.sendRedirect("errorPage.jsp"); // 如果URL为空或处理失败，跳转到错误页面
	            }
	        }
	}

//        HttpSession session = req.getSession();
//        Integer showId = (Integer) session.getAttribute("showtimeId");
//
//        if (showId == null) {
//            showId = 6;  // Default value if not found
//        }
//
//        ShowtimeInfoDAOImpl showtimeInfoDAO = new ShowtimeInfoDAOImpl();
//        ShowtimeInfo show = showtimeInfoDAO.getById(showId);
//
//        if (show != null) {
//        	req.setAttribute("show", show);
//        } else {
//        	req.setAttribute("error", "未能找到相應的影廳資訊。");
//        	req.getRequestDispatcher("/errorPage.jsp").forward(req, res);
//            return;
//        }
//        
//	    String redirectUrl = membookingService.findRightScreenId(showId);  // 使用showId調用方法獲得正確的URL
//	    System.out.println("redirectUrl ==========" + redirectUrl);
//	    res.sendRedirect(redirectUrl);  // 使用重定向而不是轉發

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doGet(req, res);

	}

}
