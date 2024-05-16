package com.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "home_ann")
public class HomeAnn {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ann_id", updatable = false)
	private Integer annId;

	@Column(name = "ann_title")
	private String annTitle;

	@Column(name = "ann_detail")
	private String annDetail;

	@Column(name = "ann_time")
	private Timestamp annTime;

	public HomeAnn() {
		super();
	}

	public HomeAnn(Integer annId, String annTitle, String annDetail, Timestamp annTime) {
		super();
		this.annId = annId;
		this.annTitle = annTitle;
		this.annDetail = annDetail;
		this.annTime = annTime;
	}

	public Integer getAnnId() {
		return annId;
	}

	public void setAnnId(Integer annId) {
		this.annId = annId;
	}

	public String getAnnTitle() {
		return annTitle;
	}

	public void setAnnTitle(String annTitle) {
		this.annTitle = annTitle;
	}

	public String getAnnDetail() {
		return annDetail;
	}

	public void setAnnDetail(String annDetail) {
		this.annDetail = annDetail;
	}

	public Timestamp getAnnTime() {
		return annTime;
	}

	public void setAnnTime(Timestamp annTime) {
		this.annTime = annTime;
	}

	@Override
	public String toString() {
		return "HomeAnn [annId=" + annId + ", annTitle=" + annTitle + ", annDetail=" + annDetail + ", annTime="
				+ annTime + "]";
	}

}
