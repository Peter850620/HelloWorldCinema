package com.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.entity.Mem;
import com.entity.Screen;

@Entity
@Table(name = "rental_order")
public class RentalOrder {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "rental_id")
	private Integer rentalId;

	@NotNull
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mem_id", referencedColumnName = "mem_id")
	private Mem mem;

	@NotNull(message="影廳編號: 請勿空白")
	@ManyToOne
	@JoinColumn(name = "screen_id" , referencedColumnName = "screen_id")
	private Screen screen;

	@NotNull(message="租借日期: 請勿空白")
	@DateTimeFormat(pattern="yyyy-MM-dd") 
	@Temporal(TemporalType.DATE)
	@Column(name = "rental_date")
	private Date rentalDate;

	@NotNull(message="預計開始時間: 請勿空白")
	@DateTimeFormat(pattern="HH:mm:ss") 
	@Temporal(TemporalType.TIME)
	@Column(name = "start_time")
	private Date startTime;

	@NotNull(message="預計結束時間: 請勿空白")
	@DateTimeFormat(pattern="HH:mm:ss") 
	@Temporal(TemporalType.TIME)
	@Column(name = "end_time")
	private Date endTime;

	@NotEmpty(message="申請理由: 請勿空白")
	@Column(name = "reason")
	private String reason;

	@NotEmpty
	@Column(name = "result")
	private String result;

	@NotNull
	@DateTimeFormat(pattern="yyyy-MM-dd") 
	@Temporal(TemporalType.DATE)
	@Column(name = "apply_date")
	private Date applyDate;


	@Column(name = "price")
	private Integer price;

	@NotEmpty(message="付款方式: 請勿空白")
	@Column(name = "payment_type")
	private String paymentType;

	@NotEmpty
	@Column(name = "payment_status")
	private String paymentStatus;


	@Column(name = "deposit")
	private Integer deposit;

	@NotEmpty
	@Column(name = "deposit_refund")
	private String depositRefund;


	@Column(name = "total")
	private Integer total;

	@ManyToOne
	@JoinColumn(name = "emp_id" , referencedColumnName = "emp_id")
	private Emp emp;

	public RentalOrder() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RentalOrder(Integer rentalId, Mem mem, Screen screen, Date rentalDate, Date startTime, Date endTime,
			String reason, String result, Date applyDate, Integer price, String paymentType, String paymentStatus,
			Integer deposit, String depositRefund, Integer total, Emp emp) {
		super();
		this.rentalId = rentalId;
		this.mem = mem;
		this.screen = screen;
		this.rentalDate = rentalDate;
		this.startTime = startTime;
		this.endTime = endTime;
		this.reason = reason;
		this.result = result;
		this.applyDate = applyDate;
		this.price = price;
		this.paymentType = paymentType;
		this.paymentStatus = paymentStatus;
		this.deposit = deposit;
		this.depositRefund = depositRefund;
		this.total = total;
		this.emp = emp;
	}

	public Integer getRentalId() {
		return rentalId;
	}

	public void setRentalId(Integer rentalId) {
		this.rentalId = rentalId;
	}

	public Mem getMem() {
		return mem;
	}

	public void setMem(Mem mem) {
		this.mem = mem;
	}

	public Screen getScreen() {
		return screen;
	}

	public void setScreen(Screen screen) {
		this.screen = screen;
	}

	public Date getRentalDate() {
		return rentalDate;
	}

	public void setRentalDate(Date rentalDate) {
		this.rentalDate = rentalDate;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public Integer getDeposit() {
		return deposit;
	}

	public void setDeposit(Integer deposit) {
		this.deposit = deposit;
	}

	public String getDepositRefund() {
		return depositRefund;
	}

	public void setDepositRefund(String depositRefund) {
		this.depositRefund = depositRefund;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Emp getEmp() {
		return emp;
	}

	public void setEmp(Emp emp) {
		this.emp = emp;
	}

	@Override
	public String toString() {
		return "RentalOrder [rentalId=" + rentalId + ", mem=" + mem + ", rentalDate=" + rentalDate + ", startTime="
				+ startTime + ", endTime=" + endTime + ", reason=" + reason + ", result=" + result + ", applyDate="
				+ applyDate + ", price=" + price + ", paymentType=" + paymentType + ", paymentStatus=" + paymentStatus
				+ ", deposit=" + deposit + ", depositRefund=" + depositRefund + ", total=" + total + "]";
	}

	

	
	
	
}
