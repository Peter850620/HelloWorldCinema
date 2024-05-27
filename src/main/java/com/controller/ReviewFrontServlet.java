package com.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.Mem;
import com.entity.Movie;
import com.entity.Review;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.MovieService;
import com.service.MovieServiceYuan;
import com.service.ReviewService;
import com.service.ReviewServiceImpl;

@WebServlet("/front/review.do")
@MultipartConfig
public class ReviewFrontServlet extends HttpServlet {

	// 一個 servlet 實體對應一個 service 實體
		private ReviewService reviewService;
		private MovieService movieService;
		private MovieServiceYuan movieServiceYuan;
		
		@Override
		public void init() throws ServletException {
			reviewService = new ReviewServiceImpl();
			movieService = new MovieService();
			movieServiceYuan = new MovieServiceYuan();
		}
		
		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doPost(req, res);
		}

		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			
			System.out.print(action);
			
			if("getMovie".equals(action)) {
				Integer movieId = Integer.parseInt(req.getParameter("movie"));
				Movie movie = new Movie();
				movie.setMovieId(movieId);
				List<Review> reviewList = reviewService.getByMovie(movie);
				Movie oneMovie = movieService.findMoviebyId(movieId);
				
				req.setAttribute("reviewList", reviewList);
				req.setAttribute("oneMovie", oneMovie);
				String url = "/front_end/review/listReviewByMovie.jsp";   
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			
			if ("getMem".equals(action)) { 
				HttpSession session = req.getSession();
				Mem mem = (Mem) session.getAttribute("mem");

				String page = req.getParameter("page");
				int currentPage = (page == null) ? 1 : Integer.parseInt(page);
				List<Review> reviewList = reviewService.getByMem(mem, currentPage);
				
				if (req.getSession().getAttribute("reviewPageQty") == null) {
					int reviewPageQty = reviewService.getPageTotal();
					req.getSession().setAttribute("reviewPageQty", reviewPageQty);
				}
				req.setAttribute("reviewList", reviewList);
				req.setAttribute("currentPage", currentPage);
				
				String url = "/front_end/review/personalReview.jsp";   
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			
			if ("compositeQuery".equals(action)) { 
				String movieStatus = req.getParameter("movieStatus");

				List<Movie> movieList = movieServiceYuan.getNowMovies(movieStatus);
				req.setAttribute("movieList", movieList);
				
				String url = "/front_end/review/reviewFront.jsp";   
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			
			if ("getUpdate".equals(action)) { 
				Integer reviewId = Integer.parseInt(req.getParameter("reviewId"));
				Review review = reviewService.getOneReview(reviewId);
				String param = "?reviewId="  +review.getReviewId()+
					       "&mem="  +review.getMem().getMemId()+
					       "&movie="    +review.getMovie().getMovieId()+
					       "&reviewDetails="+review.getReviewDetails()+
					       "&reviewDate="    +review.getReviewDate()+
					       "&reviewStatus="   +review.getReviewStatus();
				
				String url = "/front_end/review/reviewFrontCheck.jsp"+param;
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
		
			if ("update".equals(action)) { 
				Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				Integer reviewId = Integer.parseInt(req.getParameter("reviewId").trim());
				String reviewDetails = req.getParameter("reviewDetails");
				String reviewDetailsReg = "^.{2,500}$";
				if (reviewDetails == null || reviewDetails.trim().length() == 0) {
					errorMsgs.put("reviewDetails","評論內容，請勿空白");
				} else if(!reviewDetails.trim().matches(reviewDetailsReg)) { 
					errorMsgs.put("reviewDetails","評論內容，只能是中、英文字母、數字和標點符號 , 且長度必需在2到500之間");
	            }
				String reviewStatus = req.getParameter("reviewStatus").trim();
				
				if (!errorMsgs.isEmpty()) {
					errorMsgs.put("Exception","修改資料失敗:---------------");
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/review/reviewFrontCheck.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

				Review review = reviewService.getOneReview(reviewId);
			    review.setReviewDetails(reviewDetails);
			    review.setReviewStatus(reviewStatus);
			    reviewService.updateReview(review);

				req.setAttribute("success", "- (修改成功)");
				req.setAttribute("review", review); 
				String url = "/front_end/review/reviewFrontCheck.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
		
			if ("insert".equals(action)) { 
				Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
				req.setAttribute("errorMsgs", errorMsgs);

				HttpSession session = req.getSession();
				Mem mem = (Mem) session.getAttribute("mem");
				Integer movieId = Integer.parseInt(req.getParameter("movie"));
				String reviewDetails = req.getParameter("reviewDetails").trim();
				String reviewDetailsReg = "^.{2,500}$";
				if (reviewDetails == null || reviewDetails.trim().length() == 0) {
					errorMsgs.put("reviewDetails","評論內容: 請勿空白");
				}else if(!reviewDetails.trim().matches(reviewDetailsReg)) {
					errorMsgs.put("reviewDetails","評論內容: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到500之間");
	            }

				if (!errorMsgs.isEmpty()) {
					res.setContentType("application/json");
	                res.setCharacterEncoding("UTF-8");
	                Map<String, Object> response = new LinkedHashMap<>();
	                response.put("success", false);
	                response.put("errorMessage", String.join(", ", errorMsgs.values()));
	                ObjectMapper mapper = new ObjectMapper();
	                res.getWriter().write(mapper.writeValueAsString(response));
	                return; // 程式中斷
				}

				Review review = new Review();
				review.setMem(mem);
				
				Movie movie = new Movie();
				movie.setMovieId(movieId);
				review.setMovie(movie);
				
				Timestamp reviewDate = new Timestamp(System.currentTimeMillis());
				review.setReviewDate(reviewDate);
				review.setReviewDetails(reviewDetails);
				review.setReviewStatus("顯示");
				reviewService.addReview(review);
				
				res.setContentType("application/json");
	            res.setCharacterEncoding("UTF-8");
	            Map<String, Object> response = new LinkedHashMap<>();
	            response.put("success", true);
	            response.put("message", "留言成功");
	            ObjectMapper mapper = new ObjectMapper();
	            res.getWriter().write(mapper.writeValueAsString(response));
			}
			
			if ("loadMovie".equals(action)) {
				List<Movie> movieList = movieService.findAllmovies();

				req.setAttribute("movieList", movieList);
				String url = "/front_end/review/reviewFront.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
		}
}
