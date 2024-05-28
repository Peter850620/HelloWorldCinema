package com.controller;

import java.io.ByteArrayOutputStream;
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
import com.entity.Booking;
import com.entity.Food;
import com.entity.FoodItem;
import com.entity.Movie;
import com.entity.OrderItem;
import com.entity.Screen;
import com.entity.ShowtimeInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.service.BookingService;


@WebServlet("/BookingController")
public class BookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BookingController() {
		super();
	}

	private BookingDAOImpl dao;

	
	private FoodItemIDAOmpl daoFoodItem;
	private BookingService bookingService;

	@Override
	public void init() throws ServletException {
		dao = new BookingDAOImpl();
		daoFoodItem=new FoodItemIDAOmpl();
		bookingService=new BookingService();
	}
	
	private static final String BASE_URL = "http://helloworldcinema.ddns.net:8081/HelloWorldCinema/QRCodeServlet";
   

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String url = "";
        HttpSession session = req.getSession(true);
		

		RequestDispatcher successView;

		switch (action) {

		case "moreDetails":
			Integer bookingNo = Integer.valueOf(req.getParameter("bookingNo"));
			Booking booking = dao.getOneBooking(bookingNo);
			req.setAttribute("myBooking", booking);
			url = "/front_end/booking/orderItem.jsp";
			successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			break;

		case "cancelbooking":

			String[] selectedSeats = req.getParameterValues("selectedSeats");
			String[] allSeats = req.getParameterValues("allSeats");
			
			Integer cancelBookingNo = Integer.valueOf(req.getParameter("bookingNo"));

			boolean isEqual = Arrays.equals(selectedSeats, allSeats);
		
		

			if (selectedSeats != null) {
				
				bookingService.cancelSeat(cancelBookingNo, selectedSeats);
				bookingService.cancel(cancelBookingNo);

			}
			if (isEqual) {
				bookingService.cancel(cancelBookingNo);
			}
			
			
			String selectedFoodParam = req.getParameter("selectedfood");
			if (selectedFoodParam != null && !selectedFoodParam.isEmpty()) {
			    Integer selectedFood = Integer.valueOf(selectedFoodParam);
			  
			List<FoodItem> foodItems= daoFoodItem.getFoodbyBookingNo(selectedFood);
			bookingService.cancelFood(foodItems);
			  
			} 
         
			Booking updatedBooking = bookingService.getOneBooking(cancelBookingNo);
			req.setAttribute("myBooking", updatedBooking);
			url = "/front_end/booking/orderItem.jsp";
			successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			break;
			
			
		case "getmembooking":
			
			String page = req.getParameter("currentPage");
			Integer memId=Integer.valueOf(req.getParameter("memId"));
			String sorted=req.getParameter("sorted");
			if(sorted==null) {sorted="訂單編號";}
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
            List<Booking> bookings=bookingService.getMemBookings(memId, currentPage, sorted);
            
            int totalPage=bookingService.getPageTotal(memId);
            System.out.println(totalPage+"我是頁數");
            req.setAttribute("totalPage", totalPage);
            req.setAttribute("bookings", bookings);
			req.setAttribute("currentPage", currentPage);
			
			url = "/front_end/booking/booking.jsp";
			successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			break;
			
			//===========後端=============
			
		case "addFood":
			    List<Food> allOfFood=bookingService.findFood();
			    res.setContentType("application/json");
			    res.setCharacterEncoding("UTF-8");
			    ObjectMapper mapper = new ObjectMapper();
			    mapper.writeValue(res.getWriter(), allOfFood);
			    break;
		
			    //選擇日期列出所有Show
		case "formShowTime":
			
		        String showDate=req.getParameter("showDate");
		        System.out.println("我是日期:"+showDate );
		        List<Movie> movies =bookingService.findMoviesShowingToday(showDate);
		        req.setAttribute("movies", movies);
		        url = "/back_end/booking/bookingMovie.jsp";
				successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				break;
				
		//選擇要看哪場秀
		case "bookWhichShow":
			
			 Integer showId=Integer.valueOf( req.getParameter("selectedTime"));
			 ShowtimeInfo whichShow=bookingService.findRightShow(showId);
             String screenUrl=bookingService.findRightScreenId(showId);
     
             session.removeAttribute("whichShow");
             session.setAttribute("whichShow", whichShow);
	         url=screenUrl;
	         successView=req.getRequestDispatcher(url);
	         successView.forward(req, res);
	         break;
	          
	        //訂位成功產生訂單  
		case "bookingSuccess":
			session.removeAttribute("newbookingno");
		    String paymentType = req.getParameter("paymentType");
		    String screenId = req.getParameter("screenId");
		    Integer finalshowId = Integer.valueOf(req.getParameter("showId"));
		    Integer total = Integer.valueOf(req.getParameter("total"));
		    String bookingSeats = req.getParameter("seatNo");
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
		    Date today = new Date(System.currentTimeMillis());
		    Booking bookingSuccess = new Booking();

		    bookingSuccess.setBookingDate(today);
		    bookingSuccess.setBookingStatus("已取票");
		    bookingSuccess.setPaymentType(paymentType);
		    bookingSuccess.setPickupOption("現場票");
		    bookingSuccess.setTotal(total);
		    bookingSuccess.setQuantity(quantity);

		    Screen screen = bookingService.findScreen(screenId);
		    bookingSuccess.setScreen(screen);
		    ShowtimeInfo show = bookingService.findRightShow(finalshowId);
		    bookingSuccess.setShowtimeInfo(show);

		    Set<OrderItem> orderItems = new HashSet<>();
		    for (String seatNo : seatsArray) {
		        if (!eachTkId.isEmpty()) {
		            int ticketId = eachTkId.remove(0);
		            OrderItem item = new OrderItem();
		            item.setSeatNo(seatNo);
		            item.setEntryStatus("未使用");
		            item.setTicket(bookingService.findTicket(ticketId));
		            item.setBooking(bookingSuccess);
		            orderItems.add(item);
		            bookingService.bookSeats(finalshowId, seatNo);
		        }
		    }

		    bookingSuccess.setOrderItem(orderItems);

		    Set<FoodItem> foodItems = new HashSet<>();
		    List<Food> foodexist=bookingService.getAll();
		    
		    
		    for (int i = 0; i < foodexist.size(); i++) {
		        FoodItem foodorder = new FoodItem();
		        String foodParam = req.getParameter("foodId" + i);
		        if (foodParam == null)
		            break;
		        Integer foodId = Integer.valueOf(foodParam);
		        Food food = bookingService.findOneFood(foodId);
		        foodorder.setFood(food);
		        int price = food.getFoodPrice();
		        Integer foodAmount = Integer.valueOf(req.getParameter("foodAmount" + i));
		        foodorder.setFoodAmount(foodAmount);
		        int foodSubTotal = foodAmount * price;
		        foodorder.setFoodSubTotal(foodSubTotal);
		        foodorder.setBooking(bookingSuccess);
		        foodItems.add(foodorder);
		    }

		    if (!foodItems.isEmpty()) {
		        bookingSuccess.setFoodItem(foodItems);
		    }

		    Integer newbookingNo = bookingService.createBooking(bookingSuccess);

		    try {
		        List<OrderItem> seats = bookingService.findSeatByBookingNo(newbookingNo);
		        for (OrderItem orderItem : seats) {
		            String currentSeat = orderItem.getSeatNo();
		            String qrText = String.format("%s?bookingNo=%s&showId=%s&seatNo=%s", BASE_URL, newbookingNo, show.getShowtimeId(), currentSeat);
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
		    url = "/back_end/booking/loading.jsp";
		    successView = req.getRequestDispatcher(url);
		    successView.forward(req, res);
		    break;

           //=======================================================================
			  
		case "getprintTickets":
			session.removeAttribute("newbookingno");
               newbookingNo =Integer.valueOf(req.getParameter("bookingNo"));
			session.setAttribute("newbookingno", newbookingNo);
		    url = "/back_end/booking/printTicket.jsp";
		    successView = req.getRequestDispatcher(url);
		    successView.forward(req, res);
		    break;

		}
		
	
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doGet(req, res);
		
		
		
		
		
	}
	
	
	 public static byte[] generateQRCodeImage(String text, int width, int height) throws WriterException, IOException {
	        QRCodeWriter qrCodeWriter = new QRCodeWriter();
	        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);

	        ByteArrayOutputStream os = new ByteArrayOutputStream();
	        MatrixToImageWriter.writeToStream(bitMatrix, "JPG", os);
	        return os.toByteArray();
	    }

}
