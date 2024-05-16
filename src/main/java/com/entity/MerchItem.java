package com.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "merch_item")
public class MerchItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "merch_seq", updatable = false)
	private Integer merchSeq;
	

	
	@ManyToOne
	@JoinColumn(name = "merch_no", referencedColumnName = "merch_no")
	private MerchOrder merchOrder;
	

	
	@ManyToOne
	@JoinColumn(name = "merch_id", referencedColumnName = "merch_id")
	private Merch merch;
	
	
	@Column(name = "merch_qty", nullable = false)
	private Integer merchQty;
	
	@Column(name = "merch_sub_total", nullable = false)
	private Integer merchSubTotal;
	
	public MerchItem() {
		super();
	}



	public MerchItem(Integer merchSeq, MerchOrder merchOrder, Merch merch, Integer merchQty,
			Integer merchSubTotal) {
		super();
		this.merchSeq = merchSeq;
		this.merchOrder = merchOrder;
		this.merch = merch;
		this.merchQty = merchQty;
		this.merchSubTotal = merchSubTotal;
	}



	public Integer getMerchSeq() {
		return merchSeq;
	}




	public void setMerchSeq(Integer merchSeq) {
		this.merchSeq = merchSeq;
	}



	public MerchOrder getMerchOrder() {
		return merchOrder;
	}




	public void setMerchOrder(MerchOrder merchOrder) {
		this.merchOrder = merchOrder;
	}



	public Merch getMerch() {
		return merch;
	}



	public void setMerch(Merch merch) {
		this.merch = merch;
	}



	public Integer getMerchQty() {
		return merchQty;
	}



	public void setMerchQty(Integer merchQty) {
		this.merchQty = merchQty;
	}



	public Integer getMerchSubTotal() {
		return merchSubTotal;
	}



	public void setMerchSubTotal(Integer merchSubTotal) {
		this.merchSubTotal = merchSubTotal;
	}


	@Override
	 public String toString() {
	  return "MerchItem [merch_seq=" + merchSeq + ", merch_qty=" + merchQty + ", merch_sub_total=" + merchSubTotal + "]";
	 }


	
	
}
