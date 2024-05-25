package com.entity;

import java.io.Serializable;

import org.springframework.data.redis.core.RedisHash;


@RedisHash
public class Cart implements Serializable{
	
	private Integer memId;
	private Integer merchId;
	private String merchName;
	private Integer merchQty;
	private Integer merchPrice;
	
	
	


	public Cart(Integer memId, Integer merchId, String merchName, Integer merchQty, Integer merchPrice) {
		super();
		this.memId = memId;
		this.merchId = merchId;
		this.merchName = merchName;
		this.merchQty = merchQty;
		this.merchPrice = merchPrice;
	}


	// Method to generate Redis key
    public String getRedisKey() {
        return "cart:" + memId + ":" + merchId;
    }
	

	public Integer getMemId() {
		return memId;
	}

	public void setMemId(Integer memId) {
		this.memId = memId;
	}

	public Integer getMerchId() {
		return merchId;
	}

	public void setMerchId(Integer merchId) {
		this.merchId = merchId;
	}

	public String getMerchName() {
		return merchName;
	}

	public void setMerchName(String merchName) {
		this.merchName = merchName;
	}

	public Integer getMerchQty() {
		return merchQty;
	}

	public void setMerchQty(Integer merchQty) {
		this.merchQty = merchQty;
	}

	public Integer getMerchPrice() {
		return merchPrice;
	}

	public void setMerchPrice(Integer merchPrice) {
		this.merchPrice = merchPrice;
	}
	

	
	@Override
	public String toString() {
		return "Cart [memId=" + memId + ", merchId=" + merchId + ", merchName=" + merchName + ", merchQty=" + merchQty
				+ ", merchPrice=" + merchPrice + "]";
	}
	
}
