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

import com.entity.Mem;
import com.entity.Movie;
import com.entity.Review;
import com.service.MovieService;
import com.service.ReviewService;
import com.service.ReviewServiceImpl;

@WebServlet("/back/review.do")
public class ReviewController extends HttpServlet {

	// 一個 servlet 實體對應一個 service 實體
	private ReviewService reviewService;

	@Override
	public void init() throws ServletException {
		reviewService = new ReviewServiceImpl();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		System.out.print(action);

		if ("getAll".equals(action)) {

			// HttpSession session = req.getSession();
			// Integer reviewId = (Integer) session.getAttribute("reviewId");
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<Review> reviewList = reviewService.getAllReviews(currentPage);

			if (req.getSession().getAttribute("reviewPageQty") == null) {
				int reviewPageQty = reviewService.getPageTotal();
				req.getSession().setAttribute("reviewPageQty", reviewPageQty);
			}

			req.setAttribute("reviewList", reviewList);
			req.setAttribute("currentPage", currentPage);
			String url = "/back_end/review/select_page.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("compositeQuery".equals(action)) {

			Map<String, String[]> map = req.getParameterMap();
			String page = req.getParameter("page");
			int currentPage = (page == null) ? 1 : Integer.parseInt(page);
			List<Review> reviewList = reviewService.getByCompositeQuery(map, currentPage);

			int reviewPageQty = 1;
			if (map != null) {
				reviewPageQty = reviewService.getCompositeQueryTotal(map);
			}

			req.getSession().setAttribute("reviewPageQty", reviewPageQty);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("reviewList", reviewList);
			String url = "/back_end/review/select_page.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("getUpdate".equals(action)) {
			Integer reviewId = Integer.parseInt(req.getParameter("reviewId"));
			Review review = reviewService.getOneReview(reviewId);
			String param = "?reviewId=" + review.getReviewId() + "&mem=" + review.getMem().getMemId() + "&movie="
					+ review.getMovie().getMovieId() + "&reviewDetails=" + review.getReviewDetails() + "&reviewDate="
					+ review.getReviewDate() + "&reviewStatus=" + review.getReviewStatus();

			String url = "/back_end/review/update_review.jsp" + param;
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("update".equals(action)) {

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			Integer reviewId = Integer.parseInt(req.getParameter("reviewId").trim());
			String reviewDetails = req.getParameter("reviewDetails").trim();
			String reviewDetailsReg = "^.{2,500}$";
			if (reviewDetails == null || reviewDetails.trim().length() == 0) {
				errorMsgs.put("reviewDetails", "評論內容: 請勿空白");
			} else if (!reviewDetails.trim().matches(reviewDetailsReg)) {
				errorMsgs.put("reviewDetails", "評論內容: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到500之間");
			}
			String reviewStatus = req.getParameter("reviewStatus").trim();

			if (!errorMsgs.isEmpty()) {
				errorMsgs.put("Exception", "修改資料失敗:---------------");
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/review/update_review.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			Review review = reviewService.getOneReview(reviewId);
			review.setReviewDetails(reviewDetails);
			review.setReviewStatus(reviewStatus);
			reviewService.updateReview(review);

			req.setAttribute("success", "- (修改成功)");
			req.setAttribute("review", review);
			String url = "/back_end/review/listOneReview.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);

		}

		if ("insert".equals(action)) {
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			Integer memId = Integer.parseInt(req.getParameter("mem"));
			Integer movieId = Integer.parseInt(req.getParameter("movie"));
			String reviewDetails = req.getParameter("reviewDetails").trim();
			String reviewDetailsReg = "^.{2,500}$";
			if (reviewDetails == null || reviewDetails.trim().length() == 0) {
				errorMsgs.put("reviewDetails", "評論內容: 請勿空白");
			} else if (!reviewDetails.trim().matches(reviewDetailsReg)) {
				errorMsgs.put("reviewDetails", "評論內容: 只能是中、英文字母、數字和標點符號 , 且長度必需在2到500之間");
			}
			Timestamp reviewDate = new Timestamp(System.currentTimeMillis());
			String reviewStatus = req.getParameter("reviewStatus").trim();

			if (!errorMsgs.isEmpty()) {
				errorMsgs.put("Exception", "新增資料失敗:---------------");
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/review/addReview.jsp");
				failureView.forward(req, res);
				return; // 程式中斷
			}

			Review review = new Review();

			Mem mem = new Mem();
			mem.setMemId(memId);
			review.setMem(mem);

			Movie movie = new Movie();
			movie.setMovieId(movieId);
			review.setMovie(movie);

			review.setReviewDate(reviewDate);
			review.setReviewDetails(reviewDetails);
			review.setReviewStatus(reviewStatus);

			reviewService.addReview(review);
			req.setAttribute("review", review);
			req.setAttribute("success", "- (新增成功)");
			String url = "/back_end/review/listOneReview.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		
		
	}

}
