package com.controller;

import java.io.IOException;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import com.entity.ShowtimeInfo;
import com.service.*;

@WebServlet("/showtimeInfo/showtimeInfobohan.do")
public class ShowtimeInfoServletbohan extends HttpServlet {

	private ShowtimeInfoServletbohan showtimeInfoService;
	private MemBookingService memBookingService;
	@Override
	public void init() throws ServletException {
		showtimeInfoService = new ShowtimeInfoServletbohan();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		 Integer showId = Integer.parseInt(req.getParameter("showId"));  // 從請求中獲取showId
		    String redirectUrl = memBookingService.findRightScreenId(showId);  // 使用showId調用方法獲得正確的URL
		    res.sendRedirect(redirectUrl);  // 使用重定向而不是轉發
		}

//	private ShowtimeInfoService showtimeInfoService;
//    private ObjectMapper objectMapper;
//
//    @Override
//    public void init() throws ServletException {
//        showtimeInfoService = new ShowtimeInfoService();
//        objectMapper = new ObjectMapper();
//    }
//
//    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//        doPost(req, res);
//    }
//
//    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//        req.setCharacterEncoding("UTF-8");
//        String action = req.getParameter("action");
//        res.setContentType("application/json");
//
//        if ("getPlaydatesById".equals(action)) {
//            Integer movieId = Integer.valueOf(req.getParameter("movieId"));
//            List<Date> playdates = showtimeInfoService.getPlaydatesById(movieId);
//            res.getWriter().write(objectMapper.writeValueAsString(playdates));
//        } else if ("getAll_For_showtimes".equals(action)) {
//            Integer movieId = Integer.valueOf(req.getParameter("movieId"));
//            Date playdate = null;
//            try {
//                playdate = new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("playdate"));
//            } catch (ParseException e) {
//                e.printStackTrace();
//            }
//
//            List<ShowtimeInfo> showtimes = showtimeInfoService.getShowtimeByPlaydate(movieId, playdate);
//            res.getWriter().write(objectMapper.writeValueAsString(showtimes));
//        }
//    }

}
