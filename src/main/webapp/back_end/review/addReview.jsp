<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>世界影城</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/management.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<style>
		form {
			margin: 20px auto;
			padding: 20px;
			width: 110%;
			border-radius: 25px;
			justify-content: center;
			padding: 100px;
			background-color: rgb(0 0 0/ 60%);
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			left: 150px;
			border: 2px solid white;
			margin-left: 80px;
			font-size: 25px;
			color:white;
			
		}
		
		
		
		button {
		  background-color: grey;
		  border-radius: 25px;
		  background-color: rgba(162, 161, 167, 0.5);
		  font-size: 20px;
		  width: 90px;
		
		  transition-duration: 0.5s;
		  color: white;
		}
		
		button:hover {
		  background-color: rgba(87, 87, 89, 0.8);
		}
		
		
		input[type="submit"] {
		  background-color: grey;
		  border-radius: 15px;
		  background-color: rgba(162, 161, 167, 0.5);
		  font-size: 30px;
		  width: 150px;
		  
		  cursor:pointer;
		  transition-duration: 0.5s;
		  color: white;
		}
		
		input[type="submit"]:hover {
			background-color: rgba(87, 87, 89, 0.8);
		}
		
		.title{
			text-align: left;
		}
	</style>
</head>



<body>

<%@ include file="../management.jsp" %>

	<!-- ====================這是main==================== -->
	<div id="xxx">
	
		<div class="main" align="center">
			<h3><b>所有欄位皆為必填欄位</b></h3>
			
			
			<div class="comment_body">
		       <form action="<%= request.getContextPath() %>/back/review.do" method="post">
					<div>
						
						<label for="mem">會員編號:</label>
						<input id ="mem" name="mem" type="text" value="${param.mem}" onclick="hideContent('mem.errors');" />
						<span  id ="mem.errors" class="error">${errorMsgs.mem}<br/></span>
						</div>
						
						<div>
						<label for="movie">電影編號:</label>
						<input id ="movie" name="movie" type="text" value="${param.movie}" onclick="hideContent('movie.errors');" />
						<span  id ="movie.errors" class="error">${errorMsgs.movie}</span>
						</div>
						
						<div>
						<label for="reviewDetails">評論內容:</label>
						<input id ="reviewDetails" name="reviewDetails" type="text" value="${param.reviewDetails}" onclick="hideContent('reviewDetails.errors');" />
						<span  id ="reviewDetails.errors" class="error">${errorMsgs.reviewDetails}</span>
						</div>
						<!-- 
						<div>
						<label for="review_date">評論日期:</label>
						<input id ="review_date" name="review_date" type="text" value="${param.review_date}" onclick="hideContent('review_date.errors');" />
						<span  id ="review_date.errors" class="error">${errorMsgs.review_date}</span>
						</div>
						 -->
						
						
			            <div>
						<label for="reviewStatus">狀態:</label>
						<select id="reviewStatus" name="reviewStatus">
					        <option value="顯示" ${"顯示" == param.review_status ? 'selected' : ''}>顯示</option>
					        <option value="隱藏" ${"隱藏" == param.review_status ? 'selected' : ''}>隱藏</option>
					    </select>
						<span  id ="reviewStatus.errors" class="error">${errorMsgs.reviewStatus}</span>
						</div>
	
						
						<div>
							<div></div>
							<input  type="hidden" name="action" value="insert">
							<input id ="newTime" name="reviewDate" type="hidden" value="${param.reviewDate}"/>
							<button type="submit" id="submit"> 送出新增 </button>
							<div></div>
						</div>
					</form>
					<a href="<%= request.getContextPath() %>/back/review.do?action=getAll">回查詢頁</a>
			</div>
	
		
		</div>
	</div>
    

<script src="<%= request.getContextPath() %>/js/management.js"></script>
<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
	

<script>
	function hideContent(d) {
	    document.getElementById(d).style.display = "none";
	}
</script>

</body>

   




</html>