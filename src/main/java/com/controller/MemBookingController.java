package com.controller;

import java.io.IOException;
import java.util.stream.Collectors;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

import com.dao.BookingDAOImpl;
import com.dao.FoodItemIDAOmpl;
import com.dao.ShowtimeInfoDAOImpl;
import com.entity.ShowtimeInfo;
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
            case "getShowtimeInfo":
                handleGetShowtimeInfo(req, res);
                break;
            default:
                res.sendRedirect("defaultPage.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        switch (action) {
            case "setShowtimeId":
                handleSetShowtimeId(req, res);
                break;
            default:
                doGet(req, res);
                break;
        }
    }

    private void handleSetShowtimeId(HttpServletRequest req, HttpServletResponse res) throws IOException {
        // 從請求中獲取 showtimeId
        String requestBody = req.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        JSONObject jsonObject = new JSONObject(requestBody);
        Integer showtimeId = jsonObject.getInt("showtimeId");

        // 將 showtimeId 設置到 session
        HttpSession session = req.getSession();
        session.setAttribute("showtimeId", showtimeId);
        System.out.println("showtimeId 設置到 session: " + showtimeId);

        // 回應客戶端
        res.setContentType("application/json");
        res.getWriter().write("{\"status\":\"success\"}");
    }

    private void handleFindScreen(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String screenId = req.getParameter("screenId");
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

    private void handleGetShowtimeInfo(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer showId = (Integer) session.getAttribute("showtimeId");
        System.out.println("showtimeId=========:" + showId);

        ShowtimeInfo show = null;
        if (showId != null) {
            ShowtimeInfoDAOImpl showtimeInfoDAOImpl = new ShowtimeInfoDAOImpl();
            show = showtimeInfoDAOImpl.getById(showId);
        }

        if (show == null) {
            res.getWriter().println("Error: Showtime information not found.");
            return;
        }
        req.setAttribute("showtimeInfo", show);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/displayShowtime.jsp");
        dispatcher.forward(req, res);
    }
}
