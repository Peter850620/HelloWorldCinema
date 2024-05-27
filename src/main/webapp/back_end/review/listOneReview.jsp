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
		margin: 20px auto;
		width: 100%;
		border-radius: 25px;
		justify-content: center;
		padding: 100px;
		background-color: rgb(0 0 0/ 60%);
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		left: 150px;
		border: 2px solid white;
		margin-left: 0px;
		font-size: 25px;
		color:white;
	}
	
	.nav_head {
		margin: 0px 0px 20px 50px;
	}
	
	.form_footer {
		margin: 20px 0px 0px 50px;
	}
	
	.form_footer a{
		background-color: rgb(135, 189, 250);
       	border: solid white;
       	color: white;
	}
	
	.container{
		width: 100%; 
	    margin-left: 50px;
		text-align: left;
		align: center;
	}
	
    span{
		display: inline-block;
		width: 300px;
		text-align: left;
		font-weight: bold;
		margin-bottom: 15px;
	}
	
	textarea{
		border:0px ; 
		font-weight: bold;
		font-size: 16px; 
		width: 500px; 
		height: 200px; 
		resize: none;
	}
	
</style>
</head>
<body>
<%@ include file="../management.jsp" %>
<div class="main">
	<nav class="nav_head">
	  	<h2>單一評論資料</h2>
	</nav>
	<div class="container">
		<span>評論編號:</span><span>${review.reviewId}</span><br/>
		<span>會員編號:</span><span>${review.mem.memId}</span><br/>
		<span>電影編號:</span><span>${review.movie.movieId}</span><br/>
		<span>評論日期:</span><span id="timeItem" data-time="${review.reviewDate}">${review.reviewDate}</span><br/>
		<span>狀態:</span><span>${review.reviewStatus}</span><br/>
		<span>評論內容:</span><br/>
		<textarea readonly>${review.reviewDetails}</textarea><br/>
	</div>
	<div class="form_footer">
		<h3><a href="<%= request.getContextPath() %>/back/review.do?action=getAll">回查詢頁</a></h3>
	</div>
</div>
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    var reviewDateElement = document.getElementById("timeItem");
	    var reviewDateValue = reviewDateElement.getAttribute("data-time");
	
	    if (reviewDateValue) {
	        var date = new Date(reviewDateValue);
	        var formattedDate = date.getFullYear() + '-' + 
	                            String(date.getMonth() + 1).padStart(2, '0') + '-' + 
	                            String(date.getDate()).padStart(2, '0') + ' ' + 
	                            String(date.getHours()).padStart(2, '0') + ':' + 
	                            String(date.getMinutes()).padStart(2, '0') + ':' + 
	                            String(date.getSeconds()).padStart(2, '0');
	        reviewDateElement.textContent = formattedDate;
	    }
	});
</script>
</body>
</html>