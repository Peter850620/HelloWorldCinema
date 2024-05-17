package com.dao;


import static com.util.Constants.PAGE_MAX_RESULT;

import java.io.FileInputStream;
import java.io.IOException;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Booking;
import com.entity.OrderItem;
import com.util.HibernateUtil;

public class BookingDAOImpl implements BookingDAO {

	private SessionFactory factory;

	public BookingDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}
	
	

	@Override
	public int cancel(Integer bookingNo) {

		Booking booking = getSession().get(Booking.class, bookingNo);
		if (booking == null) {
			return -1;
		}

		Set<OrderItem> orderitems = booking.getOrderItem();

		Outer: for (OrderItem orderItem : orderitems) {

			OrderItem deleteItem = getSession().get(OrderItem.class, orderItem.getTkSeq());

			if ("已取消".equals(deleteItem.getEntryStatus())) {

				continue Outer;
			} else {

				return -1;
			}
//		  
		}

		booking.setBookingStatus("已取消");
		getSession().update(booking);

		return 1;
	}

	@Override
	//找到某筆訂單
	public Booking getOneBooking(Integer bookingNo) {

		Booking booking = getSession().get(Booking.class, bookingNo);
		return booking;

	}

	//找出會員訂單總比數
	public long getTotal(Integer memId) {
	    Long total = (Long) getSession()
	                        .createQuery("select count(*) from Booking where mem.memId = :memId")
	                        .setParameter("memId", memId)
	                        .uniqueResult();
	    
	    return total != null ? total : 0;
	}

	public static byte[] getPictureByteArray(String path) throws IOException {
		FileInputStream fis = new FileInputStream(path);
		byte[] buffer = new byte[fis.available()];
		fis.read(buffer);
		fis.close();
		return buffer;
	}
	
	//透過會員編號跟當前頁數 找到會員的訂單
	@Override
	public List <Booking> getMemBookings(Integer memId,Integer currentPage,String orderBy){
		int first = (currentPage - 1) * PAGE_MAX_RESULT;
		
		
		String hql=" from Booking where mem.memId = :memId ORDER BY "+orderBy+" DESC";
		
		
		List<Booking> bookings=(List<Booking>) getSession()
	            .createQuery(hql,Booking.class)
	            .setParameter("memId", memId)
	            .setFirstResult(first) 
				.setMaxResults(PAGE_MAX_RESULT)
	            .list();
		
		return bookings;

	}

	@Override
	public int insert(Booking entity) {
		getSession().save(entity);
		
	
		return 1;
	}

	@Override
	public int update(Booking entity) {
		
		return 0;
	}

	@Override
	public Booking getById(Integer bookingNo) {
		
		Booking booking = getSession().get(Booking.class, bookingNo);
		return booking;
	}

	@Override
	public List<Booking> getByCompositeQuery(Map<String, String> map) {
		
		return null;
	}
	
	//找出後台所有訂單總比數
	
	@Override
	public long getTotalOfBookings(String pickupOption, Integer bookingNo,String bookingDate) {
		
		String hql="select count(*) from Booking where 2=2";
		
		  if (!pickupOption.isEmpty()) {
		        hql += "AND pickupOption = :pickupOption ";
		      
		    }

		    if (bookingNo != -1) {
		       
		            hql += "AND bookingNo = :bookingNo ";
		        
		    }
		    
		    if(bookingDate != null && !bookingDate.isEmpty()) {
				
				 hql += " And YEAR(bookingDate) = :year AND MONTH(bookingDate) = :month ";
			 }

		    
		    org.hibernate.query.Query<Long> query = getSession().createQuery(hql, Long.class);

		    
		    if (!pickupOption.isEmpty()) {
		        query.setParameter("pickupOption", pickupOption);
		    }

		    if (bookingNo != -1) {
		        query.setParameter("bookingNo", bookingNo);
		    }
		    
		    if(bookingDate != null && !bookingDate.isEmpty()) {
				 YearMonth yearMonth=YearMonth.parse(bookingDate);
		    	 query.setParameter("year", yearMonth.getYear());
		    	 query.setParameter("month", yearMonth.getMonthValue());
			 }

		
		 Long total=query.uniqueResult();
		return total != null ? total : 0;
	}
	
	
	public long getTotalOfBookings() {

		String hql="select count(*) from Booking";
		
		Long total=getSession().createQuery(hql, Long.class).uniqueResult();
		return total;
		
	}
	
	
	//找出前台會員訂單
	public List<Booking> getAll(Integer page, String pickupOption, Integer bookingNo,String bookingDate) {
	    Integer max = 8;
	    Integer offSet = (page - 1) * max;

	    String hql = "FROM Booking WHERE 2=2 ";

	   
	    if (!pickupOption.isEmpty()) {
	        hql += "AND pickupOption = :pickupOption ";
	      
	    }

	    if (bookingNo != -1) {
	       
	            hql += "AND bookingNo = :bookingNo ";
	        
	    }
	    
	    if(bookingDate != null && !bookingDate.isEmpty()) {
			
			 hql += " And YEAR(bookingDate) = :year AND MONTH(bookingDate) = :month ";
		 }

	    hql += "ORDER BY bookingDate DESC, bookingNo DESC";

	    org.hibernate.query.Query<Booking> query = getSession().createQuery(hql, Booking.class);

	    if (!pickupOption.isEmpty()) {
	        query.setParameter("pickupOption", pickupOption);
	    }

	    if (bookingNo != -1) {
	        query.setParameter("bookingNo", bookingNo);
	    }
	    
	    if(bookingDate != null && !bookingDate.isEmpty()) {
			 YearMonth yearMonth=YearMonth.parse(bookingDate);
	    	 query.setParameter("year", yearMonth.getYear());
	    	 query.setParameter("month", yearMonth.getMonthValue());
		 }

	    List<Booking> bookings = query.setFirstResult(offSet)
	                                  .setMaxResults(max)
	                                  .list();

	    return bookings;
	}


}