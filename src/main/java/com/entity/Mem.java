package com.entity;

import java.util.Date;
import java.util.Objects;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Future;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import com.entity.RentalOrder;

import com.entity.Booking;
import com.entity.MerchOrder;
import com.entity.Message;
import com.entity.RentalOrder;
import com.entity.Report;
import com.entity.Review;

@Entity
@Table(name = "mem")
public class Mem {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "mem_id", updatable = false)
	private Integer memId;
	
	@NotEmpty(message="會員帳號: 請勿空白")
	@Pattern(regexp = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$", message = "會員帳號: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間")
	@Column(name = "mem_acount", updatable = false, unique = true)
	private String memAcount;
	
	@NotEmpty(message="會員密碼: 請勿空白")
	@Pattern(regexp = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$", message = "會員姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間")
	@Column(name = "mem_password")
	private String memPassword;
	
	@NotEmpty(message="會員姓名: 請勿空白")
	@Column(name = "mem_name")
	private String memName;
	
	@NotEmpty(message="性別: 請勿空白")
	@Column(name = "mem_gender")
	private String memGender;
	
	@NotNull(message="會員生日: 請勿空白")	
	@DateTimeFormat(pattern="yyyy-MM-dd") 
	@Temporal(TemporalType.DATE)
	@Column(name = "mem_birthday")
	private Date memBirthday;
	
	@NotEmpty(message="會員信箱: 請勿空白")
	@Pattern(regexp = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", message = "會員信箱: 格式錯誤")
	@Column(name = "mem_email", unique = true)
	private String memEmail;
	
	@NotEmpty(message="會員地址: 請勿空白")
	@Column(name = "mem_addr")
	private String memAddr;
	
	@NotEmpty(message="會員手機: 請勿空白")
	@Pattern(regexp = "^09\\d{8}$", message = "會員手機: 格式錯誤")
	@Column(name = "mem_mobile")
	private String memMobile;
	
	@Column(name = "mem_status")
	private String memStatus;
	
	
	@OneToMany(mappedBy ="mem",cascade=CascadeType.ALL)
	private Set<Booking> booking;
	
	@OneToMany(mappedBy ="mem",cascade=CascadeType.ALL, fetch=FetchType.EAGER)
	private Set<RentalOrder> rentalOrder;
	
	@OneToMany(mappedBy ="mem",cascade=CascadeType.ALL)
	private Set<MerchOrder> merchOrder;
	
	@OneToMany(mappedBy ="mem",cascade=CascadeType.ALL)
	private Set<Message> message;
	
	@OneToMany(mappedBy ="mem",cascade=CascadeType.ALL)
	private Set<MovieFav> movieFav;
	
	@OneToMany(mappedBy ="mem",cascade=CascadeType.ALL)
	private Set<Review> review;
	
	@OneToMany(mappedBy ="mem",cascade=CascadeType.ALL)
	private Set<Report> report;
	
	public Mem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Mem(Integer memId, String memAcount, String memPassword, String memName, String memGender, Date memBirthday,
			String memEmail, String memAddr, String memMobile, String memStatus, Set<Booking> booking,
			Set<RentalOrder> rentalOrder, Set<MerchOrder> merchOrder, Set<Message> message, Set<MovieFav> movieFav,
			Set<Review> review, Set<Report> report) {
		super();
		this.memId = memId;
		this.memAcount = memAcount;
		this.memPassword = memPassword;
		this.memName = memName;
		this.memGender = memGender;
		this.memBirthday = memBirthday;
		this.memEmail = memEmail;
		this.memAddr = memAddr;
		this.memMobile = memMobile;
		this.memStatus = memStatus;
		this.booking = booking;
		this.rentalOrder = rentalOrder;
		this.merchOrder = merchOrder;
		this.message = message;
		this.movieFav = movieFav;
		this.review = review;
		this.report = report;
	}

	public Integer getMemId() {
		return memId;
	}

	public void setMemId(Integer memId) {
		this.memId = memId;
	}

	public String getMemAcount() {
		return memAcount;
	}

	public void setMemAcount(String memAcount) {
		this.memAcount = memAcount;
	}

	public String getMemPassword() {
		return memPassword;
	}

	public void setMemPassword(String memPassword) {
		this.memPassword = memPassword;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemGender() {
		return memGender;
	}

	public void setMemGender(String memGender) {
		this.memGender = memGender;
	}

	public Date getMemBirthday() {
		return memBirthday;
	}

	public void setMemBirthday(Date memBirthday) {
		this.memBirthday = memBirthday;
	}

	public String getMemEmail() {
		return memEmail;
	}

	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
	}

	public String getMemAddr() {
		return memAddr;
	}

	public void setMemAddr(String memAddr) {
		this.memAddr = memAddr;
	}

	public String getMemMobile() {
		return memMobile;
	}

	public void setMemMobile(String memMobile) {
		this.memMobile = memMobile;
	}

	public String getMemStatus() {
		return memStatus;
	}

	public void setMemStatus(String memStatus) {
		this.memStatus = memStatus;
	}

	@Override
	public int hashCode() {
		return Objects.hash(memAcount, memAddr, memBirthday, memEmail, memGender, memId, memMobile, memName,
				memPassword, memStatus);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Mem other = (Mem) obj;
		return Objects.equals(memAcount, other.memAcount) && Objects.equals(memAddr, other.memAddr)
				&& Objects.equals(memBirthday, other.memBirthday) && Objects.equals(memEmail, other.memEmail)
				&& Objects.equals(memGender, other.memGender) && Objects.equals(memId, other.memId)
				&& Objects.equals(memMobile, other.memMobile) && Objects.equals(memName, other.memName)
				&& Objects.equals(memPassword, other.memPassword) && Objects.equals(memStatus, other.memStatus);
	}

	public Set<Booking> getBooking() {
		return booking;
	}

	public void setBooking(Set<Booking> booking) {
		this.booking = booking;
	}

	public Set<RentalOrder> getRentalOrder() {
		return rentalOrder;
	}

	public void setRentalOrder(Set<RentalOrder> rentalOrder) {
		this.rentalOrder = rentalOrder;
	}

	public Set<MerchOrder> getMerchOrder() {
		return merchOrder;
	}

	public void setMerchOrder(Set<MerchOrder> merchOrder) {
		this.merchOrder = merchOrder;
	}

	public Set<Message> getMessage() {
		return message;
	}

	public void setMessage(Set<Message> message) {
		this.message = message;
	}

	public Set<MovieFav> getMovieFav() {
		return movieFav;
	}

	public void setMovieFav(Set<MovieFav> movieFav) {
		this.movieFav = movieFav;
	}

	public Set<Review> getReview() {
		return review;
	}

	public void setReview(Set<Review> review) {
		this.review = review;
	}

	public Set<Report> getReport() {
		return report;
	}

	public void setReport(Set<Report> report) {
		this.report = report;
	}

	@Override
	public String toString() {
		return "Mem [memId=" + memId + ", memAcount=" + memAcount + ", memPassword=" + memPassword + ", memName="
				+ memName + ", memGender=" + memGender + ", memBirthday=" + memBirthday + ", memEmail=" + memEmail
				+ ", memAddr=" + memAddr + ", memMobile=" + memMobile + ", memStatus=" + memStatus + ", booking="
				+ booking + ", rentalOrder=" + rentalOrder + ", merchOrder=" + merchOrder + ", message=" + message
				+ ", review=" + review + ", report=" + report + "]";
	}


	

	
	


}
