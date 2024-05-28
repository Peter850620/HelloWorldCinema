<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>


<%
MovieServiceYuan movieSvc = new MovieServiceYuan();
List<Movie> list = movieSvc.showNowMovies("熱映中");
pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- 消息輪播 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/slick/slick-theme.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/slick/slick.css">
    
    <!-- 電影輪播 -->
    <!-- 現正熱映連結 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:400,700">
    <!--插件基本框架-->
    <link rel="stylesheet" type="text/css" href="https://cdn.bootcss.com/Swiper/4.5.0/css/swiper.min.css" />
    <!--页面布局样式-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/movieSlide.css" />

	<!-- 首頁內容 -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/homePage.css" />
    
<!-- 主要css -->

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/movie/css/movieInfo.css" />
</head>
<body>

	<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />
	<!-- ========================以下區域可放置其他內容======================== -->

	<!-- 消息輪播 -->

    <div class="your-class">
        <div><image src="<%=request.getContextPath()%>/images/movie6.jpg"></div>
        <div><image src="<%=request.getContextPath()%>/images/movie7.jpg"></div>
        <div><image src="<%=request.getContextPath()%>/images/movie8.jpg"></div>
        <div><image src="<%=request.getContextPath()%>/images/movie9.jpg"></div>
        <div><image src="<%=request.getContextPath()%>/images/movie10.jpg"></div>
    </div>




    <!-- 現正熱映連結 -->
    <div class="container1">
        <a class="btn" href="<%=request.getContextPath()%>/front_end/movie/movieNowShowing.jsp">現正熱映</a>
    </div>

    

    
    <!-- 電影輪播 -->
    <div class="swiper-container-solution">
        <div class="selected-solution">
            <div>
                <div class="swiper-container">
                
                    <div class="solution-cardlist swiper-wrapper">
                    	<c:forEach var="movie" items="${list}">
	                        <div class="col-sm-4 swiper-slide">
	                            <div class="solution-card">
	                                <img src="<%=request.getContextPath()%>/movie/MovieGifReader?movieId=${movie.movieId}" alt="Image" width="100%">
	                                <h3>${movie.movieName}</h3>
	                                <!-- <p></p> -->
	                                <span><a  href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Info&movieId=${movie.movieId}"><span class="arrow-more">場次時刻</span><span class="arrow-f"></span></a>
	                                </a>
	                                </span>
	                            </div>
	                        </div>
                        </c:forEach>
                      
                    </div>
                    <!-- <div class="swiper-pagination solution-pagination"></div> -->
                </div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </div>
    </div>





	<!-- ========================以上區域可放置其他內容======================== -->

	<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />


	<script src="<%=request.getContextPath()%>/front_end/index/js/jquery-3.4.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/front_end/slick/slick.min.js"></script>
	

	<!-- 首頁內容 -->
    <script src="<%=request.getContextPath()%>/front_end/homePage.js"></script>
    <!-- 電影輪播 -->
    <script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.min.js" type="text/javascript" charset="utf-8"></script>

</body>
</html>