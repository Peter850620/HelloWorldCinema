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
import com.service.MovieService_13;
import com.service.ShowtimeInfoService_13;

@WebServlet("/showtimeInfo/showtimeInfo.do")
public class ShowtimeInfoServlet_13 extends HttpServlet{
	
	private ShowtimeInfoService_13 showtimeInfoService;
	
	@Override
	public void init() throws ServletException{
		showtimeInfoService = new ShowtimeInfoService_13();
	}

	protected void doGet (HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		Integer showId = (Integer) req.getSession().getAttribute("showtimeId");
		if (showId == null) {
		    try {
		        showId = Integer.parseInt(req.getParameter("showId"));
		    } catch (NumberFormatException e) {
		        res.getWriter().println("無效的影廳ID。");
		        return;
		    }
		}

		MemBookingService memBookingService = new MemBookingService();
		String redirectUrl = memBookingService.findRightScreenId(showId);

		if (redirectUrl != null && !redirectUrl.isEmpty()) {
		    res.sendRedirect(redirectUrl);
		} else {
		    // 如果找不到正確的影廳URL，則提供一個合理的後備處理。
		    res.getWriter().println("未能找到相應的影廳資訊。");
		}

			
		// 取得電影播放日期
        if ("getPlaydatesById".equals(action)) {
            Map<String, String> errorMsgs = new LinkedHashMap<>();
            req.setAttribute("errorMsgs", errorMsgs);
            /*************************** 1.接收請求參數 **********************/
            Integer movieId = Integer.valueOf(req.getParameter("movieId"));

            /*************************** 2.開始查詢資料 ****************************************/
            List<Date> playdates = showtimeInfoService.getPlaydatesById(movieId);
            /*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
            req.setAttribute("playdates", playdates);
            String url = "/movie/singleMovie.jsp";
            RequestDispatcher successView = req.getRequestDispatcher(url);
            successView.forward(req, res);
        }


     // 取得showtime
        if ("getAll_For_showtimes".equals(action)) {
            Map<String, String> errorMsgs = new LinkedHashMap<>();
            req.setAttribute("errorMsgs", errorMsgs);
            /*************************** 1.接收請求參數 **********************/
            Integer movieId = Integer.valueOf(req.getParameter("movieId"));

            Date playdate = null;
            try {
                playdate = new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("playdate"));
            } catch (ParseException e) {
                e.printStackTrace();
            }


            /*************************** 2.開始查詢資料 ****************************************/
            
            List<ShowtimeInfo> showtimes = showtimeInfoService.getShowtimeByPlaydate(movieId, playdate);


                /*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
                req.setAttribute("playdate", playdate);
                req.setAttribute("showtimes", showtimes);
                String url = "/movie/singleMovie.jsp";
                RequestDispatcher successView = req.getRequestDispatcher(url);
                successView.forward(req, res);
            
        }

        

     		
     		

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
