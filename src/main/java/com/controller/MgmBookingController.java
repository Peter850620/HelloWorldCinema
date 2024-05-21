package com.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Booking;
import com.entity.FoodItem;
import com.service.BookingService;


@WebServlet("/MgmBookingController")
public class MgmBookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public MgmBookingController() {
        super();
       
    }
    
    BookingService bookingSvc;
    
    @Override
	public void init() throws ServletException {
    	bookingSvc=new BookingService();

	}

	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String url="";
		RequestDispatcher successView;
		
		switch(action) {
		
		case "listAll":
			
			String pageParam=req.getParameter("currentPage");
			if(pageParam==null) {
				pageParam="1";
			}
			
			
			Integer page =Integer.valueOf(pageParam);
			String pickupOption=req.getParameter("pickupOption");
			System.out.println(pickupOption+"第一");
			
			
			if(pickupOption==null||pickupOption.equals("全部")|| pickupOption.equals("null")) {pickupOption="";}
			
			
			System.out.println(pickupOption+"第二");
			String noParam=req.getParameter("bookingNo");
			if(noParam==null || noParam.isEmpty()) {
				
				noParam="-1";
			}
			Integer bookingNo=Integer.valueOf(noParam);
	        
			String bookingDate=req.getParameter("bookingDate");
		
			int totalPage=bookingSvc.totalPage(pickupOption,bookingNo,bookingDate);
			List<Booking> bookings=bookingSvc.mgmGetAllBookings(page,pickupOption,bookingNo,bookingDate );	

			req.setAttribute("page", page);
			req.setAttribute("bookings", bookings);
			req.setAttribute("totalPage", totalPage);
		
			url="back_end/booking/bookingSearch.jsp";
			successView=req.getRequestDispatcher(url);
			successView.forward(req, res);
		
			
		break;
		
		case "moreDetails":
			Integer checkBookingNo = Integer.valueOf(req.getParameter("bookingNo"));
			Booking checkBooking = bookingSvc.getOneBooking(checkBookingNo);
			req.setAttribute("booking", checkBooking);
			
			url="/back_end/booking/checkBooking.jsp";
			successView=req.getRequestDispatcher(url);
			successView.forward(req, res);
			
			
		case "cancelBooking":
			
			String[] selectedSeats = req.getParameterValues("selectedSeats");
			String[] allSeats = req.getParameterValues("allSeats");
			
			Integer cancelBookingNo = Integer.valueOf(req.getParameter("bookingNo"));

            String[] foodSeqParam=req.getParameterValues("foodSeq");
            Integer foodSeq=null;
            if(foodSeqParam!=null) {
            	
           for(String foodParam:foodSeqParam) {
             foodSeq=Integer.valueOf(foodParam);
             System.out.println(foodSeq);
             bookingSvc.cancelFoodbySeq(foodSeq);
            		
            }
      
            }  
          
			boolean isEqual = Arrays.equals(selectedSeats, allSeats);
		
		

			if (selectedSeats != null) {
				
				bookingSvc.cancelSeat(cancelBookingNo, selectedSeats);
				bookingSvc.cancel(cancelBookingNo);

			}
			if (isEqual) {
				bookingSvc.cancel(cancelBookingNo);
			}
			
			
			String selectedFoodParam = req.getParameter("selectedfood");
			if (selectedFoodParam != null && !selectedFoodParam.isEmpty()) {
			    Integer selectedFood = Integer.valueOf(selectedFoodParam);
			  
			List<FoodItem> foodItems= bookingSvc.getFoodbyBookingNo(selectedFood);
			bookingSvc.cancelFood(foodItems);
			  
			} 
			
			
			Booking updatedBooking = bookingSvc.getOneBooking(cancelBookingNo);
			req.setAttribute("booking", updatedBooking);
			url = "/back_end/booking/checkBooking.jsp";
			successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			break;
         
			
		}

	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse res) throws ServletException, IOException {
		
		doGet(request, res);
	}

}
