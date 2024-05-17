package com.service;

import java.util.List;

import com.dao.MovieDAO;
import com.dao.MovieDAOImpl;
import com.entity.Movie;

public class MovieService_13 {

	private MovieDAO dao;
	
	public MovieService_13() {
		dao = new MovieDAOImpl();
	}
	
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
