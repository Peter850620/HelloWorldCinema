<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>


<%
MovieServiceYuan movieSvc = new MovieServiceYuan();
	List<Movie> list = movieSvc.getSoonMovies("即將上映");
    pageContext.setAttribute("list",list);
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    
    
    <!-- 主要css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/movie/css/movieInfo.css" />
</head>
<body>

   <jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />    
<br>
<!-- ========================以下區域可放置其他內容======================== -->

<div class="link-container">
    <h4 class="link"><a href="<%=request.getContextPath()%>/front_end/homePage.jsp">首頁</a></h4>
    <span>/</span>
    <h4 class="link"><a href="<%=request.getContextPath()%>/front_end/movie/movieNowShowing.jsp">現正熱映</a></h4>
</div>
<br>

<h1 class="movie_list" style="display: block; color: #c1a57b; margin-left: 640px;">即將上映</h1>
<br>



<main id="main">
        <c:forEach var="movie" items="${list}">
        <a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Info&movieId=${movie.movieId}">
            <div class="movie" id="${getByStatus}">
                <img src="<%=request.getContextPath()%>/movie/MovieGifReader?movieId=${movie.movieId}" alt="Image">
                <div class="movie-info">
                	<ul>
	                    <li><h3>${movie.movieName}</h3></li>
	                    <li><p>上映日期 : <span>${movie.releaseDate}</span></p></li>
                    </ul>
                </div>
            </div>
          </a>
        </c:forEach>
</main>




<!-- ========================以上區域可放置其他內容======================== -->
<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />  
    
    <!-- 電影瀏覽 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.0/axios.min.js" integrity="sha512-DZqqY3PiOvTP9HkjIWgjO6ouCbq+dxqWoJZ/Q+zPYNHmlnI2dQnbJ5bxAHpAMw+LXRm4D72EIRXzvcHQtE8/VQ==" crossorigin="anonymous"></script>

    <!-- 主要js -->
    <script src="<%=request.getContextPath()%>/front_end/movie/js/movieInfo.js"></script>
    
</body>
</html>