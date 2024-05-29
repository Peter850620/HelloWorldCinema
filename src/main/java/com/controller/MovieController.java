package com.controller;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.entity.Movie;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.service.MovieService;

@WebServlet("/MovieController")
@MultipartConfig(fileSizeThreshold = 0 * 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class MovieController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TimerTask task;
	private Timer timer=new Timer();
	public MovieController() {
		super();

	}

	MovieService movieSvc;

	@Override
	public void init() throws ServletException {
		movieSvc = new MovieService();
		 task = new TimerTask() {
			 
	            public void run() {
	               movieSvc.checkStatusOn();
	               
	            }
	        };
	        
	    	Calendar cal = new GregorianCalendar(2024, Calendar.MAY, 9, 0, 0, 0);
			timer.scheduleAtFixedRate(task, cal.getTime(), 24*1 * 60 * 60 * 1000);

	}
	
	
    @Override
    public void destroy() {
    	timer.cancel(); 
    }

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		Map<String, String> errorMsgs;
		String url = "";
		RequestDispatcher successView;

		switch (action) {

		case "insert":

			errorMsgs = new HashMap<>();

			req.setAttribute("errorMsgs", errorMsgs);

			String moviename = req.getParameter("movieName");
			String movienameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)\u0020:]{2,30}$";
			if (moviename == null || moviename.trim().length() == 0) {
				errorMsgs.put("movieName", "電影名稱: 請勿空白");
			} else if (!moviename.trim().matches(movienameReg)) {
				errorMsgs.put("movieName", "電影名字: 只能是中、英文字母、數字和_ , 且長度必需在2到30之間");

			}

			Integer runtime = null;
			try {
				runtime = Integer.valueOf(req.getParameter("runtime").trim());

			} catch (NumberFormatException e) {
				errorMsgs.put("runtime", "請輸入時長");
			}

			LocalDate releaseDate = null;

			String releaseDateParam = req.getParameter("releaseDate");
			if (!releaseDateParam.isEmpty()) {
				try {
					releaseDate = LocalDate.parse(releaseDateParam);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("releaseDate", "請選擇上映日期");
				}
			} else {
				errorMsgs.put("releaseDate", "請選擇上映日期");
			}

			LocalDate offDate = null;
			String offDateParam = req.getParameter("offDate");
			if (!offDateParam.isEmpty()) {
				try {
					offDate = LocalDate.parse(offDateParam);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("offDate", "請選擇上映日期");
				}
			} else {
				errorMsgs.put("offDate", "請選擇上映日期");
			}

			String language = req.getParameter("language");

			// 找電影類型
			String genre = req.getParameter("genre");
			// 找電影類等級
			String rating = req.getParameter("rating");
			// 找電影簡介
			String movieStatus = req.getParameter("movieStatus");

			String movieInfo = req.getParameter("movieInfo");
			if (movieInfo == null || movieInfo.trim().length() == 0) {
				errorMsgs.put("movieInfo", "請填寫電影簡介");
			}

			String trailer = req.getParameter("trailer");

			if (trailer == null || trailer.trim().length() == 0) {
				errorMsgs.put("trailer", "請附上電影預告的 iframe連結");
			}

			Part pic = req.getPart("poster");

			if (pic.getSize() == 0) {
				errorMsgs.put("poster", "請選擇電影海報");
			}

			InputStream is = pic.getInputStream();

			Movie movie = new Movie();

			movie.setMovieName(moviename);
			movie.setRuntime(runtime);
			movie.setGenre(genre);
			movie.setReleaseDate(releaseDate);
			movie.setOffDate(offDate);
			movie.setLanguage(language);
			movie.setRating(rating);
			movie.setMovieInfo(movieInfo);
			movie.setMovieStatus(movieStatus);

			byte[] imageData = null;
			BufferedInputStream bis = new BufferedInputStream(is); // 高階資料流
			ByteArrayOutputStream baos = new ByteArrayOutputStream(); // 等等要把輸入流東西東西都寫進
			try {
				int bytesRead;
				byte[] buffer = new byte[8192];
				while ((bytesRead = bis.read(buffer)) != -1) {
					baos.write(buffer, 0, bytesRead);
				}
				imageData = baos.toByteArray();

			} catch (IOException e) {

			} finally {
				try {
					bis.close();
					baos.close();
					is.close();
				} catch (IOException e) {

				}
			}
			movie.setPoster(imageData);
			movie.setTrailer(trailer);

			System.out.println("Error Messages: " + errorMsgs);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("movie", movie);
				req.setAttribute("errorMsgs", errorMsgs);
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/movie/addMovie.jsp");
				failureView.forward(req, res);
				return; // 程式中斷

			}

			// =====================2.開始新增資料================================

			// 新增成功後導入畫面
			movieSvc.saveMovie(movie);
			req.setAttribute("movie", movie);
			url = "/back_end/movie/listOneMovie.jsp";
			successView = req.getRequestDispatcher(url);
			successView.forward(req, res);

			break;

		case "editMovie":

			/*************************** 1.接收請求參數 ****************************************/
			Integer movieId = Integer.valueOf(req.getParameter("movieId"));

			// =====================查詢電影編號================================

			Movie oneMovie = movieSvc.findMoviebyId(movieId);

			// ==============編輯請求針對電影編號查詢然後存到REQ================
			req.setAttribute("movie", oneMovie);
			url = "/back_end/movie/updateMovie.jsp";

			successView = req.getRequestDispatcher(url); // 導到編輯頁面
			successView.forward(req, res);
			break;

		case "update":

			errorMsgs = new HashMap<String, String>();

			req.setAttribute("errorMsgs", errorMsgs);
//
			// ================================== 1.接收請求參數 - 輸入格式的錯誤處理
			Integer existingId = Integer.valueOf(req.getParameter("movieId"));
			Movie movieUpdate = movieSvc.findMoviebyId(existingId);
			String name = req.getParameter("movieName");
			String nameReg = "^[\u4e00-\u9fa5a-zA-Z0-9_ :]{2,30}$";
			if (name == null || name.trim().length() == 0) {
				errorMsgs.put("movieName", "電影名稱: 請勿空白");
			} else if (!name.trim().matches(nameReg)) {
				errorMsgs.put("movieName", "電影名字: 只能是中、英文字母、數字和_ , 且長度必需在2到30之間");

			}

			Integer time = null;
			try {
				time = Integer.valueOf(req.getParameter("runtime").trim());

			} catch (NumberFormatException e) {
				errorMsgs.put("runtime", "請輸入時長");
			}

			LocalDate release = null;

			String releaseParam = req.getParameter("releaseDate");
			if (!releaseParam.isEmpty()) {
				try {
					release = LocalDate.parse(releaseParam);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("releaseDate", "請選擇上映日期");
				}
			} else {
				errorMsgs.put("releaseDate", "請選擇上映日期");
			}

			LocalDate off = null;
			String offParam = req.getParameter("offDate");
			if (!offParam.isEmpty()) {
				try {
					off = LocalDate.parse(offParam);
				} catch (IllegalArgumentException e) {
					errorMsgs.put("offDate", "請選擇下檔日期");
				}
			} else {
				errorMsgs.put("offDate", "請選擇下檔日期");
			}

			String lan = req.getParameter("language");

			// 找電影類型
			String gen = req.getParameter("genre");
			// 找電影類等級
			String rate = req.getParameter("rating");
			// 找電影簡介
			String status = req.getParameter("movieStatus");

			String info = req.getParameter("movieInfo");
			if (info == null || info.trim().length() == 0) {
				errorMsgs.put("movieInfo", "請填寫電影簡介");
			}

			String trailers = req.getParameter("trailer");

			if (trailers == null || trailers.trim().length() == 0) {
				errorMsgs.put("trailer", "請附上電影預告的 iframe連結");
			}

			Part poster = req.getPart("poster");
			byte[] data = null;

			if (poster.getSize() == 0) {
				data = movieUpdate.getPoster();
			} else {
				try (InputStream inputStream = poster.getInputStream();
						BufferedInputStream buis = new BufferedInputStream(inputStream);
						ByteArrayOutputStream byteos = new ByteArrayOutputStream()) {

					int readLength;
					byte[] bucket = new byte[8192];
					while ((readLength = buis.read(bucket)) != -1) {
						byteos.write(bucket, 0, readLength);
					}

					data = byteos.toByteArray();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			movieUpdate.setMovieName(name);
			movieUpdate.setRuntime(time);
			movieUpdate.setGenre(gen);
			movieUpdate.setReleaseDate(release);
			movieUpdate.setOffDate(off);
			movieUpdate.setLanguage(lan);
			movieUpdate.setRating(rate);
			movieUpdate.setMovieInfo(info);
			movieUpdate.setMovieStatus(status);
			movieUpdate.setPoster(data);
			movieUpdate.setTrailer(trailers);

			
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("movie", movieUpdate); // 原本錯誤的電影資訊也一起存在REQUEST
				req.setAttribute("errorMsgs", errorMsgs);
				url = "/back_end/movie/updateMovie.jsp";
				System.out.println(errorMsgs);
				RequestDispatcher fail = req.getRequestDispatcher(url);
				fail.forward(req, res);
				return; // 程式中斷
			}


//		
		

			// =====================2.開始新增資料================================
			movieSvc.updateMovie(movieUpdate);
			System.out.println("更新成功!!!!!!!!!");
//			
//			
			// =========================更新後導回原本電影清單=====================
			req.setAttribute("movie", movieUpdate);
			System.out.println(movieUpdate.getMovieId());

			url = "/back_end/movie/listOneMovie.jsp";
			successView = req.getRequestDispatcher(url); // 修改成功後,回到原本畫面
			successView.forward(req, res);

			break;

		case "deleteMovie":// listAllmovie 那隻JSP如果刪除時會跳轉來這

			Integer deleteId = Integer.valueOf(req.getParameter("movieId"));

			// ==============刪除資料==============================

			movieSvc.deleteMovie(deleteId);

			// ================刪除完成後回到電影清單頁面
			url = "/back_end/movie/listAllMovie.jsp";
			successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
			successView.forward(req, res);
			System.out.println("hahaha");
			break;

		case "cancel":

			Integer movieCancelUpdateId = Integer.valueOf(req.getParameter("movieId"));
			System.out.println(movieCancelUpdateId);
			Movie movieCanecleUpdate = movieSvc.findMoviebyId(movieCancelUpdateId);
			req.setAttribute("movie", movieCanecleUpdate);

			// ================若不想更新電影按下取消鍵會返回原本頁面=====================
			url = "/back_end/movie/listOneMovie.jsp";
			successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
			successView.forward(req, res);

			break;

		case "loadmore":

			String offSetParam = req.getParameter("offset");
			if(offSetParam==null) {
				offSetParam="0";
			}
			Integer offSet = Integer.valueOf(offSetParam);
			String keywords= req.getParameter("keywords");
             
			// ===================================================teste========================
			String sorted = req.getParameter("sorted");
			String selectedDate=req.getParameter("releaseDate");
			
			
			
			List<Movie> data1 = null;

			switch (sorted) {

	
			case "查詢全部":

				data1 = movieSvc.loadMoreMovies(offSet,keywords,selectedDate);

				break;

			case "熱映中":
			case "即將上映":
			case "已下檔":
				
				data1 = movieSvc.sortedMovies(sorted, offSet,keywords,selectedDate);
				
				break;
			}
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			ObjectMapper mapper = new ObjectMapper();
			mapper.registerModule(new JavaTimeModule());
			mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
			
	
			
			mapper.writeValue(res.getWriter(), data1);

			break;

		case "moredetails":

			String moredetailsIdParam = req.getParameter("movieId");
			Integer moredetailsId = Integer.valueOf(moredetailsIdParam);
			Movie detailsforMovie = movieSvc.findMoviebyId(moredetailsId);

			req.setAttribute("movie", detailsforMovie);
		

			// ========查看細節返回 單一一筆電影的畫面
			url = "/back_end/movie/listOneMovie.jsp";
			successView = req.getRequestDispatcher(url); // 修改成功後,回到原本畫面
			successView.forward(req, res);

			break;

		}

	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req, res);
	}

}
