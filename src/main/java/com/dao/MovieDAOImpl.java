package com.dao;

import java.sql.Date;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;



import com.entity.Movie;
import com.util.HibernateUtil;

public class MovieDAOImpl implements MovieDAO {

	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
	private SessionFactory factory;

	public MovieDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
	// 以避免請求執行緒共用了同個 Session
	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public List<Movie> getAll() {
		List<Movie> list = getSession().createQuery("FROM Movie", Movie.class).list();
		return list;
	}
//	單一電影資訊
	@Override
	public Movie getByMovieId(Integer movieId) {
		return getSession().get(Movie.class, movieId);
	}

//	電影資訊列表
	@Override
	public List<Movie> getByStatus(String movieStatus) {
		return getSession().createQuery("FROM Movie WHERE movieStatus = :status", Movie.class)
				.setParameter("status", movieStatus).list();
	}
	
	
	
	public List<Movie> findMoviesShowingToday(Date playDate) {

		String hql = "SELECT DISTINCT m FROM Movie m " + "JOIN FETCH m.showtime s "
				+ "WHERE (m.movieStatus = '熱映中' OR m.movieStatus = '即將上映') "
				+ "AND (s.playdate = :today AND s.showtime BETWEEN '08:00:00' AND '23:59:00' OR (s.playdate = :tomorrow AND s.showtime BETWEEN '00:00:00' AND '02:00:00')) "
				+ "ORDER BY m.movieStatus";

		LocalDate date = playDate.toLocalDate(); // 轉型成Localdate才能加一天
		date = date.plusDays(1); // 加一天
		Date nextDay = Date.valueOf(date); // 轉回為SQL DATE
		return getSession().createQuery(hql, Movie.class).setParameter("today", playDate)
				.setParameter("tomorrow", nextDay).getResultList();

	}

	@Override
	public int insert(Movie entity) {
		getSession().save(entity);

		return 1;
	}

	@Override
	public int update(Movie entity) {
		getSession().update(entity);
		return 1;
	}

	@Override
	public int delete(Integer MovieId) {
		Movie movie = getSession().get(Movie.class, MovieId);
		getSession().delete(movie);

		return 1;
	}

	@Override
	public Movie getById(Integer MovieId) {
		return getSession().get(Movie.class, MovieId);

	}

	

	@Override
	public List<Movie> getByCompositeQuery(Map<String, String> map) {
		if (map.size() == 0) {

			return getAll();
		} else {

			return null;
		}

	}
	
	
	@Override
	public Integer findNewId() {
		
		String hql="SELECT MAX(movieId) FROM Movie";
		 Integer maxId=getSession().createQuery(hql, Integer.class).uniqueResult();
		 
		 return ++maxId;
		
		
	}
	
	@Override	
    public List<Movie> loadMoreMovies(Integer offSet,String keywords,String releaseDate){
	 
	 String hql="from Movie where 1=1";
	 
	 if (keywords != null && !keywords.isEmpty()) {
	        hql += " And movieName LIKE :keyword";
	    }
	 
	 if(releaseDate != null && !releaseDate.isEmpty()) {
		 
	
		 hql += " And YEAR(releaseDate) = :year AND MONTH(releaseDate) = :month";
	 }
	 
	 hql += " ORDER BY movieNo DESC";
	 org.hibernate.query.Query<Movie> query = getSession().createQuery(hql, Movie.class);
			 
			 if (keywords != null && !keywords.isEmpty()) {
			        query.setParameter("keyword", '%'+keywords+'%');
			    }
			 
			 if (releaseDate!=null&&!releaseDate.isEmpty()) {
				 
				 YearMonth yearMonth = YearMonth.parse(releaseDate); // 解析为 YearMonth 类型
				    query.setParameter("year", yearMonth.getYear());
				    query.setParameter("month", yearMonth.getMonthValue());
			    }
			 

			    List<Movie> allmovies = query.setFirstResult(offSet)
			                              .setMaxResults(7)
			                              .list();
	 
	 return allmovies;
	 
 }
	
	
	@Override
	public List<Movie> sortedMovies(String status, Integer offSet, String keywords,String releaseDate) {
	    String hql = "FROM Movie WHERE movieStatus = :status";
	    
	    
	    if (keywords != null && !keywords.isEmpty()) {
	        hql += " AND movieName LIKE :keyword";
	    }
	    
	    
	    if(releaseDate != null && !releaseDate.isEmpty()) {    //如果日期有確實被輸入
			 
			
			 hql += " And YEAR(releaseDate) = :year AND MONTH(releaseDate) = :month";
		 }
		 
	    hql += " ORDER BY releaseDate DESC";

	    org.hibernate.query.Query<Movie> query = getSession().createQuery(hql, Movie.class)
	            .setParameter("status", status);

	    if (keywords != null && !keywords.isEmpty()) {
	        query.setParameter("keyword", '%' + keywords + '%');
	    }
	    
	    
	    if (releaseDate!=null&&!releaseDate.isEmpty()) {
			 
			 YearMonth yearMonth = YearMonth.parse(releaseDate); //只取年跟月  所以這裡要把字串轉型
			    query.setParameter("year", yearMonth.getYear());
			    query.setParameter("month", yearMonth.getMonthValue());
		    }
		 

	    List<Movie> movies = query.setFirstResult(offSet)
	                              .setMaxResults(7)
	                              .list();

	    for (Movie m : movies) {
	        System.out.println(m.getMovieName());
	    }

	    return movies;
	}

	
	//排程器
	public void checkStatusOn() {
	    Session session = getSession();
	    Transaction tx = null;
	    try {
	        if (!session.getTransaction().isActive()) { // 檢查活動是否已存在
	            tx = session.beginTransaction();
	        }
	        
	   
	        LocalDate currentDate = LocalDate.now();
	        String hql = "from Movie where releaseDate <= :currentDate and offDate > :currentDate";
	        List<Movie> movies = session.createQuery(hql, Movie.class)
	                                    .setParameter("currentDate", currentDate)
	                                    .list();
	        for (Movie movie : movies) {
	           
	            session.update(movie);
	        }
	        
	        
	        hql="from Movie where releaseDate <= :currentDate and offDate < :currentDate";
	        movies = session.createQuery(hql, Movie.class)
                    .setParameter("currentDate", currentDate)
                    .list();
	        
						for (Movie movie : movies) {
						movie.setMovieStatus("已下檔");
						
						session.update(movie);
						}
	        
	        
	        if (tx != null) {
	            tx.commit();
	        }
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }
	}



	public static void main(String[] args) {
		MovieDAOImpl movieDAO = new MovieDAOImpl();
		List<Movie> movieList = movieDAO.getAll();
		System.out.println(movieList);
	}
	
	
	

}
