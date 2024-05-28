package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.FoodItem;
import com.service.FoodItemServicePeter;

@WebServlet("/QRCodeFoodServlet")
public class QRCodeFoodServlet extends HttpServlet {

	FoodItemServicePeter foodItemSvc;

	@Override
	public void init() throws ServletException {
		foodItemSvc = new FoodItemServicePeter();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String bookingNoParam = request.getParameter("bookingNo");
		String foodInfo = request.getParameter("foodInfo");


		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (bookingNoParam != null/* && foodInfo != null*/) {
		    Integer bookingNo = Integer.valueOf(bookingNoParam);
		    String ableToEnter = foodItemSvc.updateStatus(bookingNo);
		    List<FoodItem> foodItems = foodItemSvc.getFoodItems(bookingNo);
		    System.out.println("我是訂單"+bookingNo);
		    // 输出HTML和内联CSS
		    out.println("<html>");
		    out.println("<head>");
		    out.println("<title>FoodItem Details</title>");
		    out.println("<style>");
		    out.println(".center { text-align: center; }");
		    out.println(".red-text { color: red; }");
		    out.println("</style>");
		    out.println("</head>");
		    out.println("<body class=\"center\">"); 

		    out.println("<h1>Booking Details</h1>");

		    out.println("<div class=\"center\">"); 
		    out.println("訂單編號: " + bookingNoParam + "<br>");
//		    for(FoodItem foodItem : foodItems) {
//		    out.write("餐點明細: " + foodInfo + "<br>");
//		    }
		   
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
