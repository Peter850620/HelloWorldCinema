package com.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.Mem;
import com.entity.Movie;
import com.entity.Review;
import com.service.MovieService;
import com.service.ReviewService;
import com.service.ReviewServiceImpl;

@WebServlet("/front/review.do")
public class ReviewFrontServlet extends HttpServlet {

	// 一個 servlet 實體對應一個 service 實體
		private ReviewService reviewService;
		private MovieService movieService;
		
		@Override
		public void init() throws ServletException {
			reviewService = new ReviewServiceImpl();
			movieService = new MovieService();
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
				Integer memId = Integer.parseInt(req.getParameter("mem"));
				
//					HttpSession session = req.getSession();
//					Integer memId = (Integer) session.getAttribute("mem");
				
				Mem mem = new Mem();
				mem.setMemId(memId);
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
			
				
//			if ("compositeQuery".equals(action)) { 
//				String movieStatus = req.getParameter("movieStatus");
//					
//				if (movieStatus != null) {
//					switch(movieStatus) {
//					case "即將上映":
//						List<Movie> movieList1 = movieService_13.getSoonMovies(movieStatus);
//						req.setAttribute("movieList", movieList1);
//						break;
//					case "熱映中":
//						List<Movie> movieList2 = movieService_13.getNowMovies(movieStatus);
//						req.setAttribute("movieList", movieList2);
//						break;
//					case "已下檔":
//						
//					}
//					List<Review> reviewList = movieService_13.getMovieByCompositeQuery(map);
//					req.setAttribute("reviewList", reviewList);
//				}
//				
//				String url = "/back_end/review/select_page.jsp";   
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);
//			}	
				
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
					errorMsgs.put("reviewDetails","評論內容: 請勿空白");
				} else if(!reviewDetails.trim().matches(reviewDetailsReg)) { 
					errorMsgs.put("reviewDetails","評論內容: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到500之間");
	            }
				String reviewStatus = req.getParameter("reviewStatus").trim();
				
				if (!errorMsgs.isEmpty()) {
					errorMsgs.put("Exception","修改資料失敗:---------------");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/review/reviewFrontCheck.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

				Review review = reviewService.getOneReview(reviewId);
			    review.setReviewDetails(reviewDetails);
			    review.setReviewStatus(reviewStatus);
			    reviewService.updateReview(review);

				req.setAttribute("success", "- (修改成功)");
				req.setAttribute("review", review); 
				String url = "/front_end/review/personalReview.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			
			}
		
			if ("insert".equals(action)) { 
				Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
				req.setAttribute("errorMsgs", errorMsgs);

//					HttpSession session = req.getSession();
//					Integer memId = (Integer) session.getAttribute("mem");
//					Integer memId = Integer.valueOf(req.getParameter("mem"));
				Integer movieId = Integer.parseInt(req.getParameter("movie"));
				String reviewDetails = req.getParameter("reviewDetails").trim();
				String reviewDetailsReg = "^.{2,500}$";
				if (reviewDetails == null || reviewDetails.trim().length() == 0) {
					errorMsgs.put("reviewDetails","評論內容: 請勿空白");
				}else if(!reviewDetails.trim().matches(reviewDetailsReg)) {
					errorMsgs.put("reviewDetails","評論內容: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到500之間");
	            }

				if (!errorMsgs.isEmpty()) {
					errorMsgs.put("Exception","新增資料失敗:---------------");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/review/listReviewByMovie.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

				Review review = new Review();
				
				Mem mem = new Mem();
				mem.setMemId(240001);
				review.setMem(mem);
				
				Movie movie = new Movie();
				movie.setMovieId(movieId);
				review.setMovie(movie);
				
				Timestamp reviewDate = new Timestamp(System.currentTimeMillis());
				review.setReviewDate(reviewDate);
				review.setReviewDetails(reviewDetails);
				review.setReviewStatus("顯示");
				reviewService.addReview(review);
				
				req.setAttribute("success", "- (新增成功)");
				String url = "/front_end/review/listReviewByMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
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
