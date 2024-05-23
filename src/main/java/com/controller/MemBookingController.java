package com.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.BookingDAOImpl;
import com.dao.FoodItemIDAOmpl;
import com.dao.ShowtimeInfoDAOImpl;
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

        switch (action) {
            case "findScreen":
                handleFindScreen(req, res);
                break;
            case "getSeatStatus":
                handleGetSeatStatus(req, res);
                break;
            default:
                res.sendRedirect("defaultPage.jsp");
                break;
        }
    }

    private void handleFindScreen(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String screenId = req.getParameter("screenId");
        System.out.println("MemBookingController screenId = " + screenId);
        String url = memBookingService.findRightScreenId(Integer.parseInt(screenId));

        if (url != null) {
            RequestDispatcher dispatcher = req.getRequestDispatcher(url);
            dispatcher.forward(req, res);
        } else {
            res.sendRedirect("errorPage.jsp");
        }
    }

    private void handleGetSeatStatus(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String showtimeId = req.getParameter("showtimeId");
        String seatStatus = show.getSeatStatus(showtimeId);

        if (seatStatus != null) {
            res.setContentType("text/plain");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().write(seatStatus);
        } else {
            res.sendError(HttpServletResponse.SC_NOT_FOUND, "Seat status not found for showtimeId: " + showtimeId);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doGet(req, res);
    }
}
