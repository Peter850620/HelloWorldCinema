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
	private MemBookingService membookingService;
	private ShowtimeInfoDAOImpl showtimeInfoDAO;

	@Override
	public void init() throws ServletException {
		dao = new BookingDAOImpl();
		daoFoodItem=new FoodItemIDAOmpl();
		membookingService=new MemBookingService();
	}

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer showId = (Integer) session.getAttribute("showtimeId");

        if (showId == null) {
            showId = 6;  // Default value if not found
        }

        ShowtimeInfoDAOImpl showtimeInfoDAO = new ShowtimeInfoDAOImpl();
        ShowtimeInfo show = showtimeInfoDAO.getById(showId);

        if (show != null) {
        	req.setAttribute("show", show);
        } else {
        	req.setAttribute("error", "未能找到相應的影廳資訊。");
        	req.getRequestDispatcher("/errorPage.jsp").forward(req, res);
            return;
        }

        req.getRequestDispatcher("/orderTicket.jsp").forward(req, res);
    }

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doGet(req, res);
		
		
		
		
		
	}

}
