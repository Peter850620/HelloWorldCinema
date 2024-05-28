package com.controller;

import java.io.ByteArrayOutputStream;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
import com.entity.Booking;
import com.entity.Food;
import com.entity.FoodItem;
import com.entity.Mem;
import com.entity.OrderItem;
import com.entity.Screen;
import com.entity.ShowtimeInfo;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.service.MemBookingService;
import com.service.ShowtimeInfoServicebohan;

@WebServlet("/MemBookingController")
public class MemBookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemBookingController() {
		super();
	}

	private MemBookingService memBookingService;
	private ShowtimeInfoDAOImpl show;
	MemBookingService memService;
	ShowtimeInfoServicebohan bohanshow;

	@Override
	public void init() throws ServletException {

		memBookingService = new MemBookingService();
		show = new ShowtimeInfoDAOImpl();
		memService = new MemBookingService();
		bohanshow = new ShowtimeInfoServicebohan();

	}

	private static final String BASE_URL = "http://helloworldcinema.ddns.net:8081/HelloWorldCinema/QRCodeServlet";

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
		case "bookingSuccess":
			handleGetBookingSuccess(req, res);
			break;
		case "bookWhichShow":
			bookWhichShow(req, res);
			break;
		default:
			res.sendRedirect("defaultPage.jsp");
			break;
		}

	}

	private void bookWhichShow(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Integer showId = Integer.valueOf(req.getParameter("selectedTime"));
		ShowtimeInfo whichShow = memBookingService.findRightShow(showId);
		String screenUrl = memBookingService.findRightScreenId(showId);

		HttpSession session = req.getSession(); // 添加這一行來取得 session
		session.removeAttribute("whichShow");
		session.setAttribute("whichShow", whichShow);

		String url = screenUrl;
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
	}

	private void handleGetBookingSuccess(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		String url = "";

		RequestDispatcher successView;

		Integer mem = Integer.valueOf(req.getParameter("memId"));
		System.out.println("mem" + mem);

//		String paymentType = req.getParameter("paymentType");
//		System.out.println("Payment Type: " + paymentType);

		String screenId = req.getParameter("screenId");

		Integer finalshowId = Integer.valueOf(req.getParameter("showId"));

		Integer total = Integer.valueOf(req.getParameter("subtotal"));

		String bookingSeats = req.getParameter("seatNo");

		String seatSelection = req.getParameter("seatSelection");

		String[] seatsArray = bookingSeats.split(" ");
		List<Integer> eachTkId = new ArrayList<>();
		Integer tkValue;
		Map<String, Integer> tkIdValues = new HashMap<>();

		for (int i = 1; i < 5; i++) {
			String tkId = "tkId" + i;
			tkIdValues.put(tkId, Integer.valueOf(req.getParameter(tkId)));
			tkValue = tkIdValues.get(tkId);
			for (int x = 1; x <= tkValue; x++) {
				switch (tkId) {
				case "tkId1":
					eachTkId.add(1);
					break;
				case "tkId2":
					eachTkId.add(2);
					break;
				case "tkId3":
					eachTkId.add(3);
					break;
				case "tkId4":
					eachTkId.add(4);
					break;
				}
			}
		}

		Integer quantity = eachTkId.size();
		System.out.println("quantity: " + quantity);

		Date today = new Date(System.currentTimeMillis());
		System.out.println("today: " + today);

		Booking bookingSuccess = new Booking();

		bookingSuccess.setBookingDate(today);
		bookingSuccess.setBookingStatus("已取票");
		bookingSuccess.setPaymentType("信用卡");
		bookingSuccess.setPickupOption("電子票");
		bookingSuccess.setTotal(total);
		bookingSuccess.setQuantity(quantity);
		Mem member = memService.findMem(mem);
		bookingSuccess.setMem(member);

		Screen screen = memBookingService.findScreen(screenId);
		System.out.println("screen: " + screen);

		bookingSuccess.setScreen(screen);
		ShowtimeInfo show = memBookingService.findRightShow(finalshowId);
		show.setSeatStatus(seatSelection);
		System.out.println("show: " + show);

		bookingSuccess.setShowtimeInfo(show);

		Set<OrderItem> orderItems = new HashSet<>();
		for (String seatNo : seatsArray) {
			if (!eachTkId.isEmpty()) {
				int ticketId = eachTkId.remove(0);
				OrderItem item = new OrderItem();
				item.setSeatNo(seatNo);
				item.setEntryStatus("未使用");
				item.setTicket(memBookingService.findTicket(ticketId));
				item.setBooking(bookingSuccess);
				orderItems.add(item);
			}
		}

		bookingSuccess.setOrderItem(orderItems);

		Set<FoodItem> foodItems = new HashSet<>();
		for (int i = 0; i < 7; i++) {
			String foodParam = req.getParameter("foodId" + i);
			if (foodParam == null)
				break;
			Integer foodId = Integer.valueOf(foodParam);
			System.out.println(foodId);
			Food food = memBookingService.findOneFood(foodId);
			System.out.println(food);
			FoodItem foodorder = new FoodItem();
			foodorder.setFood(food);
//			int price = food.getFoodPrice();
			Integer foodAmount = Integer.valueOf(req.getParameter("foodAmount" + i));
			foodorder.setFoodAmount(foodAmount);
//			int foodSubTotal = foodAmount * price;
//			foodorder.setFoodSubTotal(foodSubTotal);
			foodorder.setBooking(bookingSuccess);
			foodItems.add(foodorder);
		}

		if (!foodItems.isEmpty()) {
			bookingSuccess.setFoodItem(foodItems);
		}

		HttpSession session = req.getSession(true);

		Integer newbookingNo = memBookingService.createBooking(bookingSuccess);

		try {
			List<OrderItem> seats = memBookingService.findSeatByBookingNo(newbookingNo);
			for (OrderItem orderItem : seats) {
				String currentSeat = orderItem.getSeatNo();
				String qrText = String.format("%s?bookingNo=%s&showId=%s&seatNo=%s", BASE_URL, newbookingNo,
						show.getShowtimeId(), currentSeat);
				byte[] qrCodeImage = generateQRCodeImage(qrText, 350, 350);
				orderItem.setQrcode(qrCodeImage);
				System.out.println("QR Code generated successfully for" + currentSeat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		synchronized (session) {
			session.setAttribute("newbookingno", newbookingNo);
		}
		url = "/back_end/orderTicket/finalticket/loading.jsp";
		successView = req.getRequestDispatcher(url);
		successView.forward(req, res);

	}

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
		

		// 回應客戶端
		res.setContentType("application/json");
		res.getWriter().write("{\"status\":\"success\"}");
	}

	private void handleFindScreen(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
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

	private void handleGetShowtimeInfo(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		Integer showId = (Integer) session.getAttribute("showtimeId");

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

	public static byte[] generateQRCodeImage(String text, int width, int height) throws WriterException, IOException {
		QRCodeWriter qrCodeWriter = new QRCodeWriter();
		BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);

		ByteArrayOutputStream os = new ByteArrayOutputStream();
		MatrixToImageWriter.writeToStream(bitMatrix, "JPG", os);
		return os.toByteArray();
	}
}
