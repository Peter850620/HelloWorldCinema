<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>評論資料 - listOneReview.jsp</title>


<style type="text/css">
	
	.main{
		background-color: white;
	}
	
	.container{
		width: 50%; 
	    margin-left: 500px;
		text-align: left;
	}
	
    span, textarea {
		display: inline-block;
		width: 150px;
		text-align: left;
		font-weight: bold;
	}
	
	
</style>
</head>
<body onload="formatTime()">
<%@ include file="../management.jsp" %>
<div class="main">
	<nav class="navbar navbar-expand-md navbar-dark bg-success fixed-top justify-content-center">
		 <div align="center"> <h2>單一評論資料 - listOneReview.jsp</h2>
		 <h3><a class="navbar-brand" href="<%= request.getContextPath() %>/back/review.do?action=getAll">回查詢頁${success}</a></h3></div>
</nav>

	<div align="center" class="container">
		<h3><span>查詢結果 :</span></h3>
		<span>評論編號:</span><span>${review.reviewId}</span><br/>
		<span>會員編號:</span><span>${review.mem.memId}</span><br/>
		<span>電影編號:</span><span>${review.movie.movieId}</span><br/>
		<span>評論內容:</span><textarea style="border:0px ; font-weight: bold; width: 300px; height: 100px; resize: vertical;" readonly>${review.reviewDetails}</textarea><br/>
		<span>評論日期:</span><span class="timeItem" style="width: 300px;">${review.reviewDate}</span><br/>
		<span>狀態:</span><span>${review.reviewStatus}</span><br/>
	</div>
</div>


<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
</body>
</html>