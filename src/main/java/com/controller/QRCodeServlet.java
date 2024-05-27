package com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Booking;
import com.entity.OrderItem;
import com.service.BookingService;

@WebServlet("/QRCodeServlet")
public class QRCodeServlet extends HttpServlet {
	BookingService bookingSvc;

	@Override
	public void init() throws ServletException {
		bookingSvc = new BookingService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String bookingNoParam = request.getParameter("bookingNo");
		String showId = request.getParameter("showId");
		String seatNo = request.getParameter("seatNo");


		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (bookingNoParam != null && showId != null && seatNo != null) {
		    Integer bookingNo = Integer.valueOf(bookingNoParam);
		    Booking newBooking = bookingSvc.getOneBooking(bookingNo);
		    String ableToEnter = bookingSvc.qrUpdateSeats(seatNo, bookingNo);
		    OrderItem order = bookingSvc.qrfinddetails(bookingNo, seatNo);
    System.out.println("我是訂單"+bookingNo);       System.out.println("我是座位"+seatNo);
		    // 输出HTML和内联CSS
		    out.println("<html>");
		    out.println("<head>");
		    out.println("<title>Booking Details</title>");
		    out.println("<style>");
		    out.println(".center { text-align: center; }");
		    out.println(".red-text { color: red; }");
		    out.println("</style>");
		    out.println("</head>");
		    out.println("<body class=\"center\">"); 

		    out.println("<h1>Booking Details</h1>");

		    out.println("<div class=\"center\">"); 
		    out.println("訂單編號: " + bookingNoParam + "<br>");
		    out.println("電影名字: " + newBooking.getShowtimeInfo().getMovie().getMovieName() + "<br>");

		    out.write("預訂票種: " + order.getTicket().getTkName() + "<br>");
		    out.write("座位號碼: " + seatNo + "<br>");

		   
		    out.write("<span class=\"red-text\">入場許可: " + ableToEnter + "</span>");
		    out.println("</div>");

		    out.println("</body>");
		    out.println("</html>");
		} else {
		    // 如果缺少任一參數，返回無效數據的響應
		    response.getWriter().write("Invalid QR data.");
		}

	}
}
