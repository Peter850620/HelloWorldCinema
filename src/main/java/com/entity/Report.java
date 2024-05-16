package com.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "report")
public class Report {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "rpt_id", updatable = false)
	private Integer rptId;

	@Column(name = "rpt_date")
	private Timestamp rptDate;

	@ManyToOne
	@JoinColumn(name = "review_id", referencedColumnName = "review_id")
	private Review review;

	@ManyToOne
	@JoinColumn(name = "mem_id", referencedColumnName = "mem_id")
	private Mem mem;

	@Column(name = "rpt_type")
	private String rptType;

	@Column(name = "rpt_detail")
	private String rptDetail;

	@Column(name = "rpt_status")
	private String rptStatus;

	public Report() {
		super();
	}

	public Report(Integer rptId, Timestamp rptDate, Review review, Mem mem, String rptType, String rptDetail,
			String rptStatus) {
		super();
		this.rptId = rptId;
		this.rptDate = rptDate;
		this.review = review;
		this.mem = mem;
		this.rptType = rptType;
		this.rptDetail = rptDetail;
		this.rptStatus = rptStatus;
	}

	public Integer getRptId() {
		return rptId;
	}

	public void setRptId(Integer rptId) {
		this.rptId = rptId;
	}

	public Timestamp getRptDate() {
		return rptDate;
	}

	public void setRptDate(Timestamp rptDate) {
		this.rptDate = rptDate;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public Mem getMem() {
		return mem;
	}

	public void setMem(Mem mem) {
		this.mem = mem;
	}

	public String getRptType() {
		return rptType;
	}

	public void setRptType(String rptType) {
		this.rptType = rptType;
	}

	public String getRptDetail() {
		return rptDetail;
	}

	public void setRptDetail(String rptDetail) {
		this.rptDetail = rptDetail;
	}

	public String getRptStatus() {
		return rptStatus;
	}

	public void setRptStatus(String rptStatus) {
		this.rptStatus = rptStatus;
	}

	@Override
	public String toString() {
		return "Report [rptId=" + rptId + ", rptDate=" + rptDate + ", review=" + review + ", mem=" + mem + ", rptType="
				+ rptType + ", rptDetail=" + rptDetail + ", rptStatus=" + rptStatus + "]";
	}

}
