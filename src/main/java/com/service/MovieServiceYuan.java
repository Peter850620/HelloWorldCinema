package com.service;

import java.util.List;

import com.dao.MovieDAO;
import com.dao.MovieDAOImpl;
import com.entity.Movie;

public class MovieServiceYuan {

	private MovieDAO dao;
	
	public MovieServiceYuan() {
		dao = new MovieDAOImpl();
	}
	//<=============================================首頁=========================================>
	
//	現正熱映輪播
	public List<Movie> showNowMovies(String movieStatus) {
	    return (List<Movie>) dao.getByStatus(movieStatus);
	}
	
	//<=============================================瀏覽電影資訊=========================================>
	
//	單一電影
	public Movie getOneMovie(Integer movieId) {
		return dao.getByMovieId(movieId);
	}
	
//	現正熱映
	public List<Movie> getNowMovies(String movieStatus) {
	    return (List<Movie>) dao.getByStatus(movieStatus);
	}

//	即將上映
	public List<Movie> getSoonMovies(String movieStatus) {
	    return (List<Movie>) dao.getByStatus(movieStatus);
	}
	
}
