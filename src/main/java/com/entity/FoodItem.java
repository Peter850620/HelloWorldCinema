package com.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.entity.*;

@Entity
@Table(name = "food_item")
public class FoodItem {
	
	@Id
	@Column(name = "food_seq", insertable = false, updatable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer foodSeq;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "booking_no", referencedColumnName = "booking_no")
    private Booking booking;
	
	@ManyToOne
	@JoinColumn(name = "food_id", referencedColumnName = "food_id")
	private Food food;

	@Column(name = "food_amount")
	private Integer foodAmount;

	@Column(name = "food_sub_total", nullable = false)
	private Integer foodSubTotal;

	@Column(name = "pick_status", nullable = false, insertable = false)
	private String pickStatus;

	public Integer getFoodSeq() {
		return foodSeq;
	}

	public void setFoodSeq(Integer foodSeq) {
		this.foodSeq = foodSeq;
	}
	
	public Booking getBooking() {
		return booking;
	}

	public void setBooking(Booking booking) {
		this.booking = booking;
	}

	public Food getFood() {
		return food;
	}

	public void setFood(Food food) {
		this.food = food;
	}

	public Integer getFoodAmount() {
		return foodAmount;
	}

	public void setFoodAmount(Integer foodAmount) {
		this.foodAmount = foodAmount;
	}

	public Integer getFoodSubTotal() {
		return foodSubTotal;
	}

	public void setFoodSubTotal(Integer foodSubTotal) {
		this.foodSubTotal = foodSubTotal;
	}

	public String getPickStatus() {
		return pickStatus;
	}

	public void setPickStatus(String pickStatus) {
		this.pickStatus = pickStatus;
	}
	
	@Override
	public String toString() {
		return "FoodItem [food_seq=" + foodSeq + ", food_id=" + food + ", food_amount=" + foodAmount + ", food_sub_total=" + foodSubTotal + ", pick_status=" + pickStatus
			/*	+ ", booking_no=" + booking_no*/  + "]";
	}


	
}
