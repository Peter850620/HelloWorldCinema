package com.entity;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

@Entity
@Table(name = "merch")
public class Merch {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "merch_id", updatable = false)
	private Integer merchId;
	
	@OneToMany(mappedBy = "merch", cascade = CascadeType.ALL)
	@OrderBy("merchId asc")
	private Set<MerchItem> merchItems;
	
	@Column(name = "merch_name", nullable = false, length = 30)
	private String merchName;
	
	@Lob
	@Column(name = "merch_img", columnDefinition = "mediumblob")
	private byte[] merchImg;
	
	@Column(name = "merch_info", length = 500)
	private String merchInfo;
	
	@Column(name = "merch_price", nullable = false)
	private Integer merchPrice;
	
	@Column(name = "merch_status", nullable = false, length = 2)
	private String merchStatus;
	
	
	
	public Merch() {
		super();
	}

	

	public Merch(Integer merchId, Set<MerchItem> merchItems, String merchName, byte[] merchImg, String merchInfo,
			Integer merchPrice, String merchStatus) {
		super();
		this.merchId = merchId;
		this.merchItems = merchItems;
		this.merchName = merchName;
		this.merchImg = merchImg;
		this.merchInfo = merchInfo;
		this.merchPrice = merchPrice;
		this.merchStatus = merchStatus;
	}



	public Integer getMerchId() {
		return merchId;
	}



	public void setMerchId(Integer merchId) {
		this.merchId = merchId;
	}



	public Set<MerchItem> getMerchItems() {
		return merchItems;
	}



	public void setMerchItems(Set<MerchItem> merchItems) {
		this.merchItems = merchItems;
	}



	public String getMerchName() {
		return merchName;
	}



	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}



	public byte[] getMerchImg() {
		return merchImg;
	}



	public void setMerchImg(byte[] merchImg) {
		this.merchImg = merchImg;
	}



	public String getMerchInfo() {
		return merchInfo;
	}



	public void setMerchInfo(String merchInfo) {
		this.merchInfo = merchInfo;
	}



	public Integer getMerchPrice() {
		return merchPrice;
	}



	public void setMerchPrice(Integer merchPrice) {
		this.merchPrice = merchPrice;
	}



	public String getMerchStatus() {
		return merchStatus;
	}



	public void setMerchStatus(String merchStatus) {
		this.merchStatus = merchStatus;
	}


	@Override
	 public String toString() {
	  return "Merch [merch_id=" + merchId + ", merch_name=" + merchName + ", merch_img=" + merchImg + ", merch_info=" + merchInfo + ", merch_price=" + merchPrice
	    + ", merch_status=" + merchStatus + "]";
	 }
	
	
	
	
	
}
