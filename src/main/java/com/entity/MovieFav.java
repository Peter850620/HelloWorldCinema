package com.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

import com.entity.MovieFav.CompositeDetail;

@Entity
@Table(name = "movie_fav")
@IdClass(CompositeDetail.class)
public class MovieFav {

	@Id
	@Column(name = "movie_id")
	private Integer movie;

	@Id
	@Column(name = "mem_id")
	private Integer mem;
	
	// 特別加上對複合主鍵物件的 getter / setter
	public CompositeDetail getCompositeKey() {
		return new CompositeDetail(movie, mem);
	}

	public void setCompositeKey(CompositeDetail key) {
		this.mem = key.getmem();
		this.movie = key.getmovie();
	}

	public Integer getMovieId() {
		return movie;
	}

	public void setMovieId(Integer movie) {
		this.movie = movie;
	}

	public Integer getMemId() {
		return mem;
	}

	public void setMemId(Integer mem) {
		this.mem = mem;
	}

	// 需要宣告一個有包含複合主鍵屬性的類別，並一定要實作 java.io.Serializable 介面
	static class CompositeDetail implements Serializable {
		private static final long serialVersionUID = 1L;

		private Integer movie;
		private Integer mem;

		// 一定要有無參數建構子
		public CompositeDetail() {
			super();
		}

		public CompositeDetail(Integer movie, Integer mem) {
			super();
			this.movie = movie;
			this.mem = mem;
		}

		public Integer getmovie() {
			return movie;
		}

		public void setmovieId(Integer movie) {
			this.movie = movie;
		}

		public Integer getmem() {
			return mem;
		}

		public void setmemId(Integer mem) {
			this.mem = mem;
		}

		// 一定要 override 此類別的 hashCode() 與 equals() 方法！
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((mem == null) ? 0 : mem.hashCode());
			result = prime * result + ((movie == null) ? 0 : movie.hashCode());
			return result;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;

			if (obj != null && getClass() == obj.getClass()) {
				CompositeDetail compositeKey = (CompositeDetail) obj;
				if (movie.equals(compositeKey.movie) && mem.equals(compositeKey.mem)) {
					return true;
				}
			}

			return false;
		}
		

		@Override
		public String toString() {
			return "MovieFav [movie_id=" + movie + ", mem_id=" + mem + "]";
		}

	}
}
