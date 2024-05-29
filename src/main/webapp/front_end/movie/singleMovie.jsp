<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%
// Use movieId to fetch playdate data
Integer movieId = Integer.valueOf(request.getParameter("movieId"));
ShowtimeInfoServiceYuan showtimeInfoSvc = new ShowtimeInfoServiceYuan();
List<Date> playdates = showtimeInfoSvc.getPlaydatesById(movieId);
pageContext.setAttribute("playdates", playdates);

Date playdate = null;
String playdateParam = request.getParameter("playdate");
if (playdateParam != null && !playdateParam.isEmpty()) {
	try {
		playdate = new SimpleDateFormat("yyyy-MM-dd").parse(playdateParam);
	} catch (ParseException e) {
		e.printStackTrace();
	}
}
System.out.println("movie id :" + movieId);
System.out.println("Play Date :" + playdate);
List<ShowtimeInfo> showtimes = showtimeInfoSvc.getShowtimeByPlaydate(movieId, playdate);
pageContext.setAttribute("showtimes", showtimes);

String showtimeIdParam = request.getParameter("showtimeId");
if (showtimeIdParam != null) {
	try {
		Integer showtimeId = Integer.parseInt(showtimeIdParam);
		session.setAttribute("showtimeId", showtimeId);
		out.print("Showtime ID set in session: " + showtimeId);
	} catch (NumberFormatException e) {
		out.print("Error: Invalid showtimeId format.");
	}
} else {
	out.print("Showtime ID is missing.");
}
%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 主要css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/movie/css/singleMovie.css" />
</head>
<body>
	<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />
	<!-- ========================以下區域可放置其他內容======================== -->

<div class="link-container">
    <h4 class="link"><a href="<%=request.getContextPath()%>/front_end/homePage.jsp">首頁</a></h4>
    <span>/</span>
    <h4 class="link"><a href="<%=request.getContextPath()%>/front_end/movie/movieCommingSoon.jsp">即將上映</a></h4>
    <span>/</span>
    <h4 class="link"><a href="<%=request.getContextPath()%>/front_end/movie/movieNowShowing.jsp">熱映中</a></h4>

</div>


	<div class="single_movie">
		<img class="movie_pic"
			src="<%=request.getContextPath()%>/movie/MovieGifReader?movieId=${movie.movieId}"
			alt="Image">
		<div class="movie_content">
			<h1 class="movie_name">${movie.movieName}</h1>
			<ul>
				<li class="key">級別 <span class="rating">${movie.rating}</span></li>
				<li class="key">片長 <span class="runtime">${movie.runtime}</span><span>分鐘</span></li>
				<li class="key">上映日 <span class="release_date">${movie.releaseDate}</span></li>
				<li class="key">類型 <span class="genre">${movie.genre}</span></li>
				<li class="key">語言 <span class="language">${movie.language}</span></li>
				<li class="key">簡介
					<p class="movie_info">${movie.movieInfo}</p>
				</li>
			</ul>
		</div>
	</div>

	<h2 class="movie_screen">場次資訊</h2>
	<div class="showtime_choice">
		<!-- 場次資訊 -->
		<ul>
			<c:forEach items="${playdates}" var="playdate">
				<li><a id="showtime_content"
					href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Info&movieId=${movie.movieId}&playdate=${playdate}&showtimeId=${showtime.showtimeId}">
						<c:out value="${playdate}" />
				</a></li>
			</c:forEach>
		</ul>

		<!-- .tabs -->
		<div id="tab${playdate.time}">
		<br><br><br>
		<div class="showtime_btn_container">
			<c:forEach items="${showtimes}" var="showtime" varStatus="status">
				<form action="<%=request.getContextPath()%>/movie/movie.do"
					id="form${status.index}" method="post">
					<div class="choice">
						<input type="hidden" name="action" value="setshowtimeId">
						<input type="hidden" id="myshowId" name="showId"
							value="${showtime.showtimeId}">
							
						<!-- 在這裡處理符合條件的 showtime 資料 -->
						<a href="#" class="showtime_btn"
							onclick="submitForm('form${status.index}'); return false;"> <c:out
								value="${showtime.showtime}" /><br> <c:out
								value="${showtime.screen.screenId}" />
						</a>
					</div>
				</form>
			</c:forEach>
		</div>
		<!-- .tab_container -->
	</div>

	<!-- 點選場次時刻確認彈跳視窗 -->
	<div class="confirm">
		<p class="message">是否前往訂票?</p>
		<div class="options">

			<a href="#" class="yes" onclick="submitForm(); return false;"
				data-modal=".confirm">是</a> <a href="#" class="no"
				data-modal=".confirm">否</a>

		</div>
	</div>

	<!-- 電影PV，只需變動影片ID -->
	<h2 class="movie_PV">電影預告</h2>
	<div class='embed-container'>
		<iframe
			src='https://www.youtube-nocookie.com/embed/${movie.trailer}?rel=0&hd=1&loop=1&playlist=${movie.trailer}'
			allowfullscreen></iframe>
	</div>

	<!-- ========================以上區域可放置其他內容======================== -->
	<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />

	<!-- 主要js -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front_end/movie/js/singleMovie.js"></script>
	<script>
		function submitForm(formId) {
			document.getElementById(formId).submit();
		}
	</script>
</body>

</html>
