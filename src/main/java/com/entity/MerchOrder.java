package com.entity;



import java.util.Date;
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
import javax.persistence.OrderBy;
import javax.persistence.Table;

@Entity
@Table(name = "merch_order")
public class MerchOrder {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "merch_no", updatable = false)
	private Integer merchNo;
	
	@OneToMany(mappedBy = "merchOrder", cascade = CascadeType.ALL)
	@OrderBy("merchNo asc")
	private Set<MerchItem> merchItems;
	
	
	@ManyToOne
	@JoinColumn(name = "mem_id", referencedColumnName = "mem_id")
	private Mem mem;
	
	@Column(name = "order_date", nullable = false)
	private Date orderDate;
	
	@Column(name = "pickup_option", nullable = false, length = 4)
	private String pickupOption;
	
	@Column(name = "payment_type", nullable = false, length = 4)
	private String paymentType;
	
	@Column(name = "receipt_status", nullable = false, length = 3)
	private String receiptStatus;
	
	@Column(name = "merch_total", nullable = false)
	private Integer merchTotal;
	
	@Column(name = "recipient", length = 10)
	private String recipient;
	
	@Column(name = "receipt_addr", length = 255)
	private String receiptAddr;
	
	@Column(name = "receipt_mobile", length = 20)
	private String receiptMobile;
	
	public MerchOrder() {
		super();
	}

	

	public MerchOrder(Integer merchNo, Mem mem, Date orderDate, String pickupOption, String paymentType,
			String receiptStatus, Integer merchTotal, String recipient, String receiptAddr, String receiptMobile) {
		super();
		this.merchNo = merchNo;
		this.mem = mem;
		this.orderDate = orderDate;
		this.pickupOption = pickupOption;
		this.paymentType = paymentType;
		this.receiptStatus = receiptStatus;
		this.merchTotal = merchTotal;
		this.recipient = recipient;
		this.receiptAddr = receiptAddr;
		this.receiptMobile = receiptMobile;
	}



	public Integer getMerchNo() {
		return merchNo;
	}

	public void setMerchNo(Integer merchNo) {
		this.merchNo = merchNo;
	}

	
	 

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getPickupOption() {
		return pickupOption;
	}

	public void setPickupOption(String pickupOption) {
		this.pickupOption = pickupOption;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getReceiptStatus() {
		return receiptStatus;
	}

	public void setReceiptStatus(String receiptStatus) {
		this.receiptStatus = receiptStatus;
	}

	public Integer getMerchTotal() {
		return merchTotal;
	}

	public void setMerchTotal(Integer merchTotal) {
		this.merchTotal = merchTotal;
	}

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public String getReceiptAddr() {
		return receiptAddr;
	}

	public void setReceiptAddr(String receiptAddr) {
		this.receiptAddr = receiptAddr;
	}

	public String getReceiptMobile() {
		return receiptMobile;
	}

	public void setReceiptMobile(String receiptMobile) {
		this.receiptMobile = receiptMobile;
	}

	
	
	
	public Set<MerchItem> getMerchItems() {
		return merchItems;
	}



	public void setMerchItems(Set<MerchItem> merchItems) {
		this.merchItems = merchItems;
	}



	public Mem getMem() {
		return mem;
	}

	public void setMem(Mem mem) {
		this.mem = mem;
	}

	
	@Override
	 public String toString() {
	  return "MerchOrder [merch_no=" + merchNo + ", order_date=" + orderDate + ", pickup_option=" + pickupOption
			  + ", payment_type=" + paymentType + ", receipt_status=" + receiptStatus + ", merch_total=" + 
			  	 merchTotal + ", recipient=" + recipient + ", receipt_addr=" + receiptAddr + ", receipt_mobile=" + receiptMobile + "]";
	 }
	
	
	
}
