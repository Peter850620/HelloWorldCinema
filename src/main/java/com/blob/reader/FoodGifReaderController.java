package com.blob.reader;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.FoodItem;
import com.service.FoodItemServicePeter;

@WebServlet("/food/FoodGifReader")
public class FoodGifReaderController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			Integer bookingNo = Integer.valueOf(req.getParameter("bookingNo"));
			FoodItemServicePeter foodItemSvc = new FoodItemServicePeter();
			List<FoodItem> foodItems = foodItemSvc.getFoodItems(bookingNo);
			for(FoodItem foodItem : foodItems) {
				out.write(foodItem.getQrcode());
				continue;
			}
		} catch (Exception e) {
			InputStream in = getServletContext().getResourceAsStream("/images/nopic.jpg");
			byte[] buf = new byte[in.available()];
			in.read(buf);
			out.write(buf);
			in.close();

		}
	}

}
