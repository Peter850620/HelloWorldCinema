package com.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.entity.Movie;

public interface MovieDAO {
	
	
	public Movie getByMovieId(Integer movieId);
	public List<Movie> getByStatus(String movieStatus);
	
	int insert(Movie entity);

	int update(Movie entity);
	
	int delete(Integer MovieId);
	
	Movie getById(Integer MovieId);
	
	List<Movie> getAll();
	
	List<Movie> getByCompositeQuery(Map<String, String> map);
	
    List<Movie> findMoviesShowingToday(Date playDate);
    
    public Integer findNewId() ;
    
    public List<Movie> loadMoreMovies(Integer offSet,String keywords,String selectedDate);
    public List<Movie> sortedMovies(String status,Integer offSet,String query,String selectedDate);
    public void checkStatusOn();
}