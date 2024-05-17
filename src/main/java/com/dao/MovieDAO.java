package com.dao;

import java.util.List;


import com.entity.Movie;

public interface MovieDAO {
	
	public List<Movie> getAll();

	public Movie getByMovieId(Integer movieId);
	
}