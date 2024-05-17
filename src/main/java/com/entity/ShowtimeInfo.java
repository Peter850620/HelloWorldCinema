package com.entity;

import java.sql.Date;

import java.sql.Time;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name = "showtime_info")
public class ShowtimeInfo {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="showtime_id")
	private Integer showtimeId;
	
	@ManyToOne
	@JoinColumn(name = "screen_id", referencedColumnName = "screen_id")
	private Screen screen;

	@Column(name="playdate")
	private Date playdate;
	
	@Column(name="showtime")
	private Time showtime;
	

	@Column(name="endtime")
	private Time endtime;
	
	@Column(name="seat_status")
	private String seatStatus;
	
	@Column(name="showtime_status")
	private String showtimeStatus;
	
	
   @ManyToOne
  @JoinColumn(name = "movie_id", referencedColumnName = "movie_id")
   @JsonIgnoreProperties("movie")
  private Movie movie;
	  
	  

		public Integer getShowtimeId() {
			return showtimeId;
		}

		public void setShowtimeId(Integer showtimeId) {
			this.showtimeId = showtimeId;
		}

		

		public Screen getScreen() {
			return screen;
		}

		public void setScreen(Screen screen) {
			this.screen = screen;
		}

		public Date getPlaydate() {
			return playdate;
		}

		public void setPlaydate(Date playdate) {
			this.playdate = playdate;
		}

		public Time getShowtime() {
			return showtime;
		}

		public void setShowtime(Time showtime) {
			this.showtime = showtime;
		}

		public Time getEndtime() {
			return endtime;
		}

		public void setEndtime(Time endtime) {
			this.endtime = endtime;
		}

		public String getSeatStatus() {
			return seatStatus;
		}

		public void setSeatStatus(String seatStatus) {
			this.seatStatus = seatStatus;
		}

		public String getShowtimeStatus() {
			return showtimeStatus;
		}

		public void setShowtimeStatus(String showtimeStatus) {
			this.showtimeStatus = showtimeStatus;
		}

		public Movie getMovie() {
			return movie;
		}

		public void setMovie(Movie movie) {
			this.movie = movie;
		}
	
	@Override
	public String toString() {
		return "ShowTime [id:" + showtimeId + ", screenID:" + screen.getScreenId()+ ", movie"+ movie.getMovieName()+", PlayDate: " +playdate +", SeatStatus:" +seatStatus+ "]";
	}
	

}
