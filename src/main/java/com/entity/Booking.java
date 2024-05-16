package com.entity;


import java.sql.Date;
import java.sql.Time;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;



@Entity
@Table(name = "booking")
public class Booking {
     
	
	@Id
	@Column(name="booking_no",updatable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer bookingNo;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "screen_id", referencedColumnName = "screen_id")
	private Screen screen;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "showtime_id", referencedColumnName = "showtime_id")
	private ShowtimeInfo showtimeInfo;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "mem_id", referencedColumnName = "mem_id")
	private Mem mem;

	@Column(name="pickup_option")
	private String pickupOption;
	
	
	@Column(name="quantity")
	private Integer quantity;
	
	
	@Column(name="payment_type")
	private String paymentType;
	
	
	@Column(name="total")
	private Integer total;
	
	
	@Column(name="booking_status")
	private String bookingStatus;
	
	
	@Column(name="booking_date",insertable = false, updatable = false)
	private Date bookingDate;
	
	
	@OneToMany(mappedBy = "booking" ,cascade = CascadeType.ALL)
    private Set<OrderItem> orderItem;
	
	
	@OneToMany(mappedBy = "booking" ,cascade = CascadeType.ALL)
    private Set<FoodItem> foodItem;
	
	
	public Set<FoodItem> getFoodItem() {
		return foodItem;
	}
	public void setFoodItem(Set<FoodItem> foodItem) {
		this.foodItem = foodItem;
	}
	public Screen getScreen() {
		return screen;
	}
	public void setScreen(Screen screen) {
		this.screen = screen;
	}
	public ShowtimeInfo getShowtimeInfo() {
		return showtimeInfo;
	}
	public void setShowtimeInfo(ShowtimeInfo showtimeInfo) {
		this.showtimeInfo = showtimeInfo;
	}
	public Set<OrderItem> getOrderItem() {
		return orderItem;
	}
	public void setOrderItem(Set<OrderItem> orderItem) {
		this.orderItem = orderItem;
	}
	
	public Integer getBookingNo() {
		return bookingNo;
	}
	public void setBookingNo(Integer bookingNo) {
		this.bookingNo = bookingNo;
	}
	
	

	public Mem getMem() {
		return mem;
	}
	public void setMem(Mem mem) {
		this.mem = mem;
	}
	public String getPickupOption() {
		return pickupOption;
	}
	public void setPickupOption(String pickupOption) {
		this.pickupOption = pickupOption;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public String getBookingStatus() {
		return bookingStatus;
	}
	public void setBookingStatus(String bookingStatus) {
		this.bookingStatus = bookingStatus;
	}
	public Date getBookingDate() {
		return bookingDate;
	}
	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
	}
	
	
	public String timeformat(Booking booking) {

		 Time starttime=booking.getShowtimeInfo().getShowtime();
		   SimpleDateFormat formatter = new SimpleDateFormat("h:mma",Locale.US);

		   String formattedTime = formatter.format(starttime).toLowerCase();
		   
		   
		   return formattedTime;

	}
	
	public String dateformate(Booking booking) {
		
		Date date=booking.getShowtimeInfo().getPlaydate();
		
		SimpleDateFormat dateFormate = new SimpleDateFormat("M月d日", Locale.CHINESE);
		String formatedate = dateFormate.format(date);
		return formatedate;
	}
	
	public String endtime(Booking booking) {

		 Time endtime=booking.getShowtimeInfo().getEndtime();
		   SimpleDateFormat formatter = new SimpleDateFormat("h:mma",Locale.US);

		   String formattedTime = formatter.format(endtime).toLowerCase();
		   
		   
		   return formattedTime;

	}
	
	public String dayofweek(Booking booking) {
		
		Date movieDate = booking.getShowtimeInfo().getPlaydate();
		SimpleDateFormat dayFormat = new SimpleDateFormat("EEEE", new DateFormatSymbols(Locale.CHINESE));
		String dayOfWeek = dayFormat.format(movieDate);
		
		return dayOfWeek;
		
	}
	
	@Override
	public String toString() {
		
		return "Booking[ Booking No: "+ bookingNo+"member: "+ mem.getMemId()+", showTime: " +showtimeInfo.getPlaydate()+",Quantity:" + quantity;
		
		
	}
	
	
}
