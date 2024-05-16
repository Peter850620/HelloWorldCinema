package com.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "order_item")
public class OrderItem {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="tk_seq")
	private Integer tkSeq;
	

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "booking_no", referencedColumnName = "booking_no")
    private Booking booking;

	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tk_id", referencedColumnName = "tk_id")
	private Ticket ticket;
	
	@Column(name = "seat_no")
	private String seatNo;
	
	@Column(name = "entry_status")
	private String entryStatus;
	
	
	
	
	
	public Booking getBooking() {
		return booking;
	}
	public void setBooking(Booking booking) {
		this.booking = booking;
	}
	public Ticket getTicket() {
		return ticket;
	}
	public void setTicket(Ticket ticket) {
		this.ticket = ticket;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	public String getEntryStatus() {
		return entryStatus;
	}
	public void setEntryStatus(String entryStatus) {
		this.entryStatus = entryStatus;
	}
	
	public Integer getTkSeq() {
		return tkSeq;
	}
	public void setTkSeq(Integer tkSeq) {
		this.tkSeq = tkSeq;
	}
	

}
