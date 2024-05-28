package com.entity;

import java.time.LocalDate;
import java.util.Base64;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "movie")
public class Movie implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "movie_id")
	private Integer movieId;
	

	@Column(name = "Movie_name")
	private String movieName;
	
	
	@Column(name = "runtime")
	private Integer runtime;
	
	@Column(name = "genre")
	private String genre;
	
	@Column(name = "release_date")
	private LocalDate releaseDate;
	
	@Column(name = "off_date")
	private LocalDate offDate;

	
	@Column(name = "rating")
	private String rating;
	
	@Column(name = "language")
	private String language;
	
	@Column(name = "movie_info")
	private String movieInfo;

	
	@Column(name = "movie_status")
	private String movieStatus;
	
	@Column(name = "poster",columnDefinition = "MEDIUMBLOB")
	private byte[] poster;
	
	@Column(name = "trailer")
	private String trailer;
	
	
	@OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
	@OrderBy("playdate asc")
	@JsonIgnore
	private Set<ShowtimeInfo> showtime;
	
	
	 @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL) 
	 @OrderBy("playdate asc") 
	 @JsonIgnore
	 private Set<Review> review;

	public Set<Review> getReview() { 
	  return review; 
	 } 
	 
	 public void setReview(Set<Review> review) { 
	  this.review = review; 
	 }
	
	public LocalDate getOffDate() {
		return offDate;
	}

	public void setOffDate(LocalDate offDate) {
		this.offDate = offDate;
	}

	

	public String getTrailer() {
		return trailer;
	}

	public void setTrailer(String trailer) {
		this.trailer = trailer;
	}

	public Set<ShowtimeInfo> getShowtime() {
		return showtime;
	}

	public void setShowtime(Set<ShowtimeInfo> showtime) {
		this.showtime = showtime;
	}




	public Movie() {
		super();
	}

	public Integer getMovieId() {
		return movieId;
	}

	public void setMovieId(Integer movieId) {
		this.movieId = movieId;
	}

	public String getMovieName() {
		return movieName;
	}

	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}

	public LocalDate getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(LocalDate releaseDate) {
		this.releaseDate = releaseDate;
	}

	public Integer getRuntime() {
		return runtime;
	}

	public void setRuntime(Integer runtime) {
		this.runtime = runtime;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getMovieInfo() {
		return movieInfo;
	}

	public void setMovieInfo(String movieInfo) {
		this.movieInfo = movieInfo;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getMovieStatus() {
		return movieStatus;
	}

	public void setMovieStatus(String movieStatus) {
		this.movieStatus = movieStatus;
	}

	public byte[] getPoster() {
		return poster;
	}

	public void setPoster(byte[] poster) {
		this.poster = poster;
	}

//	public String toString() {
//		String text = String.format("movieId: %s, movie name: %s, release date: %s,runtime:%s,genre:%s", movieId,
//				movieName, releaseDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), runtime, genre);
//		return text;
//	}
	
	
	public String getPicBase64() {
		if (poster != null) {
			return Base64.getEncoder().encodeToString(poster);
		} else {
			return ""; // 或者其他默認值，視情况而定
		}
	}

}
