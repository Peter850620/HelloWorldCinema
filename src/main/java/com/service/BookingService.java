package com.service;

import static com.util.Constants.PAGE_MAX_RESULT;

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


public class BookingService {
	
	private BookingDAO bookingdao;
	private FoodItemDAO foodItemdao;
	private OrderItemDAO orderdao;
	private FoodDAO fooddao;
	private ShowtimeInfoDAO showtimedao;
	private MovieDAO moviedao;
	private ScreenDAO screendao;
	private TicketDAO ticketao;
	
	public BookingService() {
		
		bookingdao=new BookingDAOImpl();
		foodItemdao=new FoodItemIDAOmpl();
		orderdao=new OrderItemDAOImpl();
		fooddao=new FoodDAOImpl();
		showtimedao=new ShowtimeInfoDAOImpl();
		moviedao=new MovieDAOImpl();
		screendao=new ScreenDAOImpl();
		ticketao=new TicketDAOImpl();
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
	
	//取得會員訂單裡面有幾筆
	public int getPageTotal(Integer memId) {
		long total = bookingdao.getTotal(memId);
	
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		
		return pageQty;
	}
	
	
	//取消訂單裡面已訂購的食物
	public int cancelFood(List<FoodItem> foodItems) {
		
	
		 for(FoodItem fooditem:foodItems) {
		    	
		    	fooditem.setPickStatus("已取消");
		    	 foodItemdao.update(fooditem);
		    	
		 } 
		 
		 return 1;
		
	}
	
	
	//取消訂單的座位 需要提供訂單編號以及選定取消的座位號碼
	public int cancelSeat(Integer cancelBookingNo,	String[] selectedSeats) {
		ShowtimeInfo show=bookingdao.getOneBooking(cancelBookingNo)
		.getShowtimeInfo();
		
		String allSeatNo = show.getSeatStatus();
		Pattern pattern = Pattern.compile("([A-N][0-9]+[N,Y])");
		Matcher matcher = pattern.matcher(allSeatNo);
		StringBuilder updateSeat = new StringBuilder();
		Outer:
            while (matcher.find()) {
			String b = matcher.group(1); // A01Y
			for (String selectedSeat : selectedSeats) {   //A04 A03 B08;
			
				while (selectedSeat.regionMatches(0, b, 0, 3)) {  //選取的座位和資料庫切割的字從0開始比到索引3  不包含3
					b = b.replace("N", "Y");
					updateSeat.append(b);
				
					orderdao.cancel(selectedSeat,cancelBookingNo); //修改個別座位的狀態
					continue Outer;
				}
			}
			updateSeat.append(b);
		}
		show.setSeatStatus(updateSeat.toString());
		
		
		return 1;
		
	}
	
	//找到所有上架食物
	public List<Food> findFood(){
		
		return fooddao.getAllfoodForbooking();
	}
	
	public List<Food> getAll(){
		return fooddao.getAll();
	}
	
	
	public Food findOneFood(Integer foodId) {
		
	return fooddao.findByPrimaryKey(foodId);
	}
	
	
	//找出今日上映電影
	public List<Movie> findMoviesShowingToday(String playDate) {
		  
		Date date=Date.valueOf(playDate);
		
		return moviedao.findMoviesShowingToday(date);
	}
	
	
	//找出對應場次
	public ShowtimeInfo findRightShow(Integer showId) {
		
		return showtimedao.getById(showId);
	}
	
	
	//透過場次找出對應的影廳編號並且導向正確的影廳頁面
	public String findRightScreenId(Integer showId) {
		ShowtimeInfo show=showtimedao.getById(showId);
		String screenId=show.getScreen().getScreenId();
		
		String url="";
		switch (screenId) {
		case "A廳": 
			url="/back_end/screen/screen1.jsp";
			return url;
		
			
		case "B廳":
			
			url="/back_end/screen/screen2.jsp";
			return url;
			
			
		case "C廳":
			
			url="/back_end/screen/screen3.jsp";
			return url;
		
			
          case "D廳":
			
			url="/back_end/screen/screen4.jsp";
			return url;
			
		}
		
		return url;
		
	}
	
	
	public Screen findScreen(String screenId) {
		return screendao.getById(screenId);
		
	}
	
	
	//找出對應票種實例
	public Ticket findTicket(Integer tkId) {
		return ticketao.getById(tkId);
		
	}
	
	
	public int getTotal(Integer memId) {
		
		
		return (int)bookingdao.getTotal(memId);
	}
	
	public void bookSeats(Integer showId,String seatNo) {
		
	ShowtimeInfo show=showtimedao.getById(showId);
	
	String allSeatNo = show.getSeatStatus();
	Pattern pattern = Pattern.compile("([A-N][0-9]+[N,Y])");
	Matcher matcher = pattern.matcher(allSeatNo);
	StringBuilder updateSeat = new StringBuilder();
	Outer:
        while (matcher.find()) {
		String eachSeat = matcher.group(1); // A01Y
		
		while (seatNo.regionMatches(0, eachSeat, 0, 3)) {  //選取的座位和資料庫切割的字從0開始比到索引3  不包含3
			eachSeat = eachSeat.replace("Y", "N");
			updateSeat.append(eachSeat);
		
			
			continue Outer;
		}
		updateSeat.append(eachSeat);
	  }
	

       show.setSeatStatus(updateSeat.toString());

		
		
        }
	
       //========後台找出全部會員所有訂單有多少頁數(依照領票方式)==============
	
	    public  int totalPage(String pickupOption, Integer bookingNo,String bookingDate) {
	    	
	    Long total=	bookingdao.getTotalOfBookings(pickupOption, bookingNo,bookingDate);
	    int totalPage;
	    if(total==0) {
	    	totalPage=1;
	    }else {
	      totalPage=(int)(total%8==0? (total/8):(total/8+1));
	    }
	    return totalPage;
	    }
	    
	  //========後台找出全部會員所有訂單有多少頁數==============
	    public int getTotalOfBookings() {
	    	
	    	Long total=	bookingdao.getTotalOfBookings();
	    	int totalPage=(int)(total%8==0? (total/8):(total/8+1));
		    
		    return totalPage;
	    	
	    }
	
	    
	    //========後臺找出全部會員的訂單=========
	    
	    public List<Booking> mgmGetAllBookings(Integer page, String pickupOption, Integer bookingNo,String bookingDate){
	    	
	    	return bookingdao.getAll(page,pickupOption,bookingNo,bookingDate);
	    }

//	public Map<String, List<String>> findSeatStatus(Integer showId){
//	    ShowtimeInfo show = showtimedao.getById(showId);
//	    String seatStatus = show.getSeatStatus(); //取得整個影廳全部座位狀態
//	    Pattern pattern = Pattern.compile("([A-N][0-9]+[N,Y])");
//	    Matcher matcher = pattern.matcher(seatStatus);
//	    List<String> rowStatus = new ArrayList<>(); 
//	    List<String> seatNumber = new ArrayList<>(); 
//	    String currentRow = "A";
//	    Map<String, List<String>> screenSeat = new HashMap<>(); //
//	    
//	    while (matcher.find()) {
//	        String eachSeat = matcher.group(1);
//	        String row = eachSeat.substring(0, 1); // 取出ROW的第一個字母 A
//	        String ableToBook = eachSeat.substring(3, 4);   //取出 N或Y
//	        String firstThreeLetter = eachSeat.substring(0, 3);  //取出A01 A02...
//	        
//	        if (row.equals(currentRow)) {  //如果都是A排 把座位 跟狀態都加入集合
//	            rowStatus.add(ableToBook);//加入一排座位的八個狀態
//	            seatNumber.add(firstThreeLetter);  //加入第一排座位編號
//	        } else {
//	            // 如果換了新的 row，就更新 currentRow，並重新創建 rowStatus 和 seatNumber
//	            currentRow = row;
//	            rowStatus = new ArrayList<>(); // 創建新的列表
//	            seatNumber = new ArrayList<>(); 
//	            rowStatus.add(ableToBook);
//	            seatNumber.add(firstThreeLetter);
//	        }
//	        
//	        screenSeat.put("seatNumber", seatNumber);
//		    screenSeat.put(currentRow, rowStatus);
//	    }
//	  
//	    screenSeat.put("seatNumber", seatNumber);
//	    screenSeat.put(currentRow, rowStatus);
//	    
//	    for (Map.Entry<String, List<String>> entry : screenSeat.entrySet()) {
//            String row = entry.getKey();
//            List<String> seatNumbers = entry.getValue();
//            System.out.println("Row: " + row);
//            System.out.println("Seat numbers: " + seatNumbers);
//            System.out.println();
//        }
//	    return screenSeat;
//	}

	
	public String startTime(Time starTime) {

		   SimpleDateFormat formatter = new SimpleDateFormat("h:mma",Locale.US);

		   String formattedTime = formatter.format(starTime).toLowerCase();
		   
		   if(formattedTime.substring(1, 2).equals(":")) {
			   formattedTime="0"+formattedTime;
		   }
		   return formattedTime;

	}
	
	//新增一筆訂單
	public Integer createBooking(Booking booking) {
		bookingdao.insert(booking);
		return booking.getBookingNo();
		}
	
	
	public List<FoodItem> getFoodbyBookingNo(Integer bookingNo){
		
		 return foodItemdao.getFoodbyBookingNo(bookingNo);
		
		
	}
	
	
	public void cancel(Integer  bookingNo) {
		
		bookingdao.cancel(bookingNo);
	}
	
	
	public List <Booking> getMemBookings(Integer memId,Integer currentPage,String orderBy){
		
		String orderbyString=null;
		
		switch(orderBy) {
		
		case "訂單編號":
			orderbyString="bookingNo";
			
			break;
			
		case"訂單成立日期":
			
			orderbyString="bookingDate";
			break;
			
		case"開演日期":
			orderbyString="showtimeInfo.playdate";
			break;
			
			
		
		}
		
		return bookingdao.getMemBookings(memId, currentPage, orderbyString);
		
	}
	
	
	public int cancelFoodbySeq(Integer foodSeq) {
		
		
		
		FoodItem food= foodItemdao.getById(foodSeq);
		  
		    	food.setPickStatus("已取消");
		    	
		    	foodItemdao.update(food);

		 
		 return 1;
		
	}
	
	public String qrUpdateSeats(String seatNo,Integer bookingNo) {
		
		
		return orderdao.qrUpdateSeats(seatNo, bookingNo);
	}
	
	
	public List<OrderItem> findSeatByBookingNo(Integer bookingNo){
		
		return orderdao.findSeatByBookingNo(bookingNo);
	}

	
	
	public OrderItem qrfinddetails(Integer bookingNo,String seatNo) {
		
		return orderdao.qrfinddetails(seatNo, bookingNo);
		
	}


}
	

		
