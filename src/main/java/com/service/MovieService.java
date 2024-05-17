package com.service;

import java.util.List;

import com.dao.MovieDAO;
import com.dao.MovieDAOImpl;
import com.entity.Movie;

public class MovieService {
	
	MovieDAO moviedao;
	public MovieService() {
		
		moviedao=new MovieDAOImpl();
	}
	
	
	public Movie findMoviebyId(Integer movieId) {
		return moviedao.getById(movieId);
		
	}
	
	
	public void saveMovie(Movie movie) {
		
		moviedao.insert(movie);
		
	}
	
	public void updateMovie(Movie movie) {
	moviedao.update(movie);
		
	}
	
	public List<Movie> findAllmovies(){
		
		return moviedao.getAll();
	}
	
	public Integer findNewId() {
		
		return moviedao.findNewId();
	}
	
	public void deleteMovie(Integer movieId) {
		
		moviedao.delete(movieId);
	}
	
	public List<Movie> loadMoreMovies(Integer offSet,String keywords,String releaseDate){
		
		return moviedao.loadMoreMovies(offSet,keywords,releaseDate);
	}
	
	
	public List<Movie> sortedMovies(String status,Integer offSet,String keywords,String releaseDate){
		
		List<Movie> movies=moviedao.sortedMovies(status, offSet,keywords,releaseDate);
		
		
		return movies;
		
	}
	
	
	public void checkStatusOn(){
		moviedao.checkStatusOn();
		
		
	}

}
