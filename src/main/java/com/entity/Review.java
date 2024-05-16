package com.entity;

import java.sql.Timestamp;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

@Entity
@Table(name = "review")
public class Review {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "review_id", updatable = false)
	private Integer reviewId;

	@ManyToOne
	@JoinColumn(name = "mem_id", referencedColumnName = "mem_id")
	private Mem mem;

	@ManyToOne
	@JoinColumn(name = "movie_id", referencedColumnName = "movie_id")
	private Movie movie;

	@Column(name = "review_details")
	private String reviewDetails;

	@Column(name = "review_date")
	private Timestamp reviewDate;

	@Column(name = "review_status")
	private String reviewStatus;

	@OneToMany(mappedBy = "review", cascade = CascadeType.ALL)
	private Set<Report> report;

	public Review() {
		super();
	}

	public Review(Integer reviewId, Mem mem, Movie movie, String reviewDetails, Timestamp reviewDate,
			String reviewStatus) {
		super();
		this.reviewId = reviewId;
		this.mem = mem;
		this.movie = movie;
		this.reviewDetails = reviewDetails;
		this.reviewDate = reviewDate;
		this.reviewStatus = reviewStatus;
	}

	public Integer getReviewId() {
		return reviewId;
	}

	public void setReviewId(Integer reviewId) {
		this.reviewId = reviewId;
	}

	public Mem getMem() {
		return mem;
	}

	public void setMem(Mem mem) {
		this.mem = mem;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public String getReviewDetails() {
		return reviewDetails;
	}

	public void setReviewDetails(String reviewDetails) {
		this.reviewDetails = reviewDetails;
	}

	public Timestamp getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Timestamp reviewDate) {
		this.reviewDate = reviewDate;
	}

	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public Set<Report> getReport() {
		return report;
	}

	public void setReport(Set<Report> report) {
		this.report = report;
	}

	@Override
	public String toString() {
		return "Review [reviewId=" + reviewId + ", mem=" + mem + ", movie=" + movie + ", reviewDetails=" + reviewDetails
				+ ", reviewDate=" + reviewDate + ", reviewStatus=" + reviewStatus + "]";
	}

}
