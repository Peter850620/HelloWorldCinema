package com.service;

import static com.util.Constants.*;

import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.dao.BookingDAO;
import com.dao.BookingDAOImpl;
import com.dao.FoodDAO;
import com.dao.FoodDAOImpl;
import com.dao.FoodItemDAO;
import com.dao.FoodItemIDAOmpl;
import com.dao.MovieDAO;
import com.dao.MovieDAOImpl;
import com.dao.OrderItemDAO;
import com.dao.OrderItemDAOImpl;
import com.dao.ScreenDAO;
import com.dao.ScreenDAOImpl;
import com.dao.ShowtimeInfoDAO;
import com.dao.ShowtimeInfoDAOImpl;
import com.dao.TicketDAO;
import com.dao.TicketDAOImpl;
import com.entity.Booking;
import com.entity.Food;
import com.entity.FoodItem;
import com.entity.Movie;
import com.entity.OrderItem;
import com.entity.Screen;
import com.entity.ShowtimeInfo;
import com.entity.Ticket;

public class MemBookingService {

	private BookingDAO bookingdao;
	private FoodItemDAO foodItemdao;
	private OrderItemDAO orderdao;
	private FoodDAO fooddao;
	private ShowtimeInfoDAO showtimedao;
	private MovieDAO moviedao;
	private ScreenDAO screendao;
	private TicketDAO ticketao;

	public MemBookingService() {

		bookingdao = new BookingDAOImpl();
		foodItemdao = new FoodItemIDAOmpl();
		orderdao = new OrderItemDAOImpl();
		fooddao = new FoodDAOImpl();
		showtimedao = new ShowtimeInfoDAOImpl();
		moviedao = new MovieDAOImpl();
		screendao = new ScreenDAOImpl();
		ticketao = new TicketDAOImpl();
	}

//	public List<Booking> getMemBookings(Integer memId,Integer currentPage){
//			
//			return bookingdao.getMemBookings(memId, currentPage);
//			
//	}
//	

	public Booking getOneBooking(Integer bookingNo) {
		return bookingdao.getOneBooking(bookingNo);

	}

	// 取得會員訂單裡面有幾筆
	public int getPageTotal(Integer memId) {
		long total = bookingdao.getTotal(memId);

		int pageQty = (int) (total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		System.out.println(pageQty);
		return pageQty;
	}

	// 取消訂單裡面已訂購的食物
	public int cancelFood(List<FoodItem> foodItems) {

		for (FoodItem fooditem : foodItems) {

			fooditem.setPickStatus("已取消");
			foodItemdao.update(fooditem);

		}

		return 1;

	}

	// 取消訂單的座位 需要提供訂單編號以及選定取消的座位號碼
	public int cancelSeat(Integer cancelBookingNo, String[] selectedSeats) {
		ShowtimeInfo show = bookingdao.getOneBooking(cancelBookingNo).getShowtimeInfo();

		String allSeatNo = show.getSeatStatus();
		Pattern pattern = Pattern.compile("([A-N][0-9]+[N,Y])");
		Matcher matcher = pattern.matcher(allSeatNo);
		StringBuilder updateSeat = new StringBuilder();
		Outer: while (matcher.find()) {
			String b = matcher.group(1); // A01Y
			for (String selectedSeat : selectedSeats) { // A04 A03 B08;

				while (selectedSeat.regionMatches(0, b, 0, 3)) { // 選取的座位和資料庫切割的字從0開始比到索引3 不包含3
					b = b.replace("N", "Y");
					updateSeat.append(b);

					orderdao.cancel(selectedSeat, cancelBookingNo); // 修改個別座位的狀態
					continue Outer;
				}
			}
			updateSeat.append(b);
		}
		show.setSeatStatus(updateSeat.toString());

		return 1;

	}

	// 找到所有食物
	public List<Food> findFood() {

		return fooddao.getAll();
	}

	public Food findOneFood(Integer foodId) {

		return fooddao.findByPrimaryKey(foodId);
	}

	// 找出今日上映電影
	public List<Movie> findMoviesShowingToday(String playDate) {
		Date date = Date.valueOf(playDate);

		return moviedao.findMoviesShowingToday(date);
	}

	// 找出對應場次
	public ShowtimeInfo findRightShow(Integer showId) {

		return showtimedao.getById(showId);
	}
	
	public void changeSeatStatus(Integer showId,String seatStatus) {
		ShowtimeInfo show = showtimedao.getById(showId);
		if (show != null) {
            show.setSeatStatus(seatStatus);
            showtimedao.update(show);
        }
	}

	// 透過場次找出對應的影廳編號並且導向正確的影廳頁面
	public String findRightScreenId(Integer showId) {
		ShowtimeInfo show = showtimedao.getById(showId);
		String screenId = show.getScreen().getScreenId();

		String url = "";
		switch (screenId) {
		case "A廳":
			url = "/back_end/orderTicket/screenfile/screen1/screen1.jsp";
			break;

		case "B廳":

			url = "/back_end/orderTicket/screenfile/screen2/screen2.jsp";
			break;

		case "C廳":

			url = "/back_end/orderTicket/screenfile/screen3/screen3.jsp";
			break;

		case "D廳":

			url = "/back_end/orderTicket/screenfile/screen4/screen4.jsp";
			break;

		}

		return url;

	}

	public Screen findScreen(String screenId) {
		return screendao.getById(screenId);

	}

	// 找出對應票種實例
	public Ticket findTicket(Integer tkId) {
		return ticketao.getById(tkId);

	}

	public int getTotal(Integer memId) {

		return (int) bookingdao.getTotal(memId);
	}

	public void bookSeats(Integer showId, String seatNo) {

		ShowtimeInfo show = showtimedao.getById(showId);

		String allSeatNo = show.getSeatStatus();
		Pattern pattern = Pattern.compile("([A-N][0-9]+[N,Y])");
		Matcher matcher = pattern.matcher(allSeatNo);
		StringBuilder updateSeat = new StringBuilder();
		Outer: while (matcher.find()) {
			String eachSeat = matcher.group(1); // A01Y

			while (seatNo.regionMatches(0, eachSeat, 0, 3)) { // 選取的座位和資料庫切割的字從0開始比到索引3 不包含3
				eachSeat = eachSeat.replace("Y", "N");
				updateSeat.append(eachSeat);

				continue Outer;
			}
			updateSeat.append(eachSeat);
		}

		show.setSeatStatus(updateSeat.toString());

	}

	// ========後台找出全部會員所有訂單有多少頁數(依照領票方式)==============

	public int totalPage(String pickupOption, Integer bookingNo, String bookingDate) {

		Long total = bookingdao.getTotalOfBookings(pickupOption, bookingNo, bookingDate);
		int totalPage;
		if (total == 0) {
			totalPage = 1;
		} else {
			totalPage = (int) (total % 8 == 0 ? (total / 8) : (total / 8 + 1));
		}
		return totalPage;
	}

	// ========後台找出全部會員所有訂單有多少頁數==============
	public int getTotalOfBookings() {

		Long total = bookingdao.getTotalOfBookings();
		int totalPage = (int) (total % 8 == 0 ? (total / 8) : (total / 8 + 1));

		return totalPage;

	}

	// ========後臺找出全部會員的訂單=========

	public List<Booking> mgmGetAllBookings(Integer page, String pickupOption, Integer bookingNo, String bookingDate) {

		return bookingdao.getAll(page, pickupOption, bookingNo, bookingDate);
	}

	public String startTime(Time starTime) {

		SimpleDateFormat formatter = new SimpleDateFormat("h:mma", Locale.US);

		String formattedTime = formatter.format(starTime).toLowerCase();

		if (formattedTime.substring(1, 2).equals(":")) {
			formattedTime = "0" + formattedTime;
		}
		return formattedTime;

	}

	// 新增一筆訂單
	public Integer createBooking(Booking booking) {
		bookingdao.insert(booking);
		return booking.getBookingNo();
	}

	public List<FoodItem> getFoodbyBookingNo(Integer bookingNo) {

		return foodItemdao.getFoodbyBookingNo(bookingNo);

	}

	public void cancel(Integer bookingNo) {

		bookingdao.cancel(bookingNo);
	}

	public List<Booking> getMemBookings(Integer memId, Integer currentPage, String orderBy) {

		String orderbyString = null;

		switch (orderBy) {

		case "訂單編號":
			orderbyString = "bookingNo";

			break;

		case "訂單成立日期":

			orderbyString = "bookingDate";
			break;

		case "開演日期":
			orderbyString = "showtimeInfo.playdate";
			break;

		}

		return bookingdao.getMemBookings(memId, currentPage, orderbyString);

	}

	public List<OrderItem> findSeatByBookingNo(Integer bookingNo) {

		return orderdao.findSeatByBookingNo(bookingNo);
	}

	public int cancelFoodbySeq(Integer foodSeq) {

		FoodItem food = foodItemdao.getById(foodSeq);

		food.setPickStatus("已取消");

		foodItemdao.update(food);

		return 1;

	}

}
