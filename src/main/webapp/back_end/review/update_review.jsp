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
		
		.form_head{
            display: flex;
            align-items: center;
            color: white;
            text-align: center;
            position: relative;
		}
		
		.form_head a{
			color: white;
			text-align: left;
			margin-right: 150px;
		}
		
		.title{
			text-align: left;
			position: relative;
			display: flex; 
		    align-items: center; 
		    margin-bottom: 15px;
		    border:0px ; 
		    font-weight: bold;
		}
		
		.title label {
		    margin-right: 10px;
    		min-width: 150px;  
		}
		
		.title textarea{
			width: 500px; 
			height: 200px; 
			resize: vertical;
			font-size: 16px;
		}
		
		.title input[type="text"] {
		    width: 300px; 
		    height: 30px; 
		    font-size: 16px;
		}
		
		.title select{
			width: 60px;
			height: 25px;
			font-size: 16px;
		}

	</style>
</head>



<body>

<%@ include file="../management.jsp" %>

	<div id="xxx">
		<div class="mainIndex" id="mainIndex">	
			<form action="<%= request.getContextPath() %>/back/review.do" method="post" id="myForm">
				<div class="form_head">
					<a href="<%= request.getContextPath() %>/back/review.do?action=getAll">回首頁</a>
					<h3><b>評論詳細資料</b></h3>
				</div>
				<br>
				<div class="title">
				<label for="reviewId">評論編號:</label>
				<input id ="reviewId" name="reviewId" type="text" value="${param.reviewId}" readonly />
				</div>
				
				<div class="title">
				<label for="mem">會員編號:</label>
				<input id ="mem" name="mem" type="text" value="${param.mem}" readonly />
				</div>
				
				<div class="title">
				<label for="movie">電影編號:</label>
				<input id ="movie" name="movie" type="text" value="${param.movie}" readonly />
				</div>
	 
				
				<!-- 用js將timestamp型態轉換 -->
				<div class="title">
				<label for="reviewDate">評論日期:</label>
				<input id ="reviewDate" class="timeItem" name="reviewDate" type="text" value="${param.reviewDate}" readonly />
				</div>
				
	            <div class="title">
				<label for="reviewStatus" class="statusLabel">評論狀態:</label>
				<select id="reviewStatus" name="reviewStatus">
			        <option value="顯示" ${"顯示" == param.reviewStatus ? 'selected' : ''}>顯示</option>
			        <option value="隱藏" ${"隱藏" == param.reviewStatus ? 'selected' : ''}>隱藏</option>
			    </select>
				<span  id ="reviewStatus.errors" class="error">${errorMsgs.reviewStatus}</span>
				</div>
				
				<div class="title">
				<label for="reviewDetails">評論內容:</label>
				<textarea id ="reviewDetails" name="reviewDetails" readonly>${param.reviewDetails}</textarea>
				<span  id ="reviewDetails.errors" class="error">${errorMsgs.reviewDetails}</span>
				</div>
				
				<div class="title">
					<div></div>
					<input  type="hidden" name="action" value="update">
					<input type="hidden" name="reviewDate" value="${param.reviewDate}" id="newTime">
					<button type="submit" id="submit"> 送出修改 </button>
					<div></div>
				</div>
			</form>
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