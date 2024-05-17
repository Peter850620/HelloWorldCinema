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
		<div class="main" id="main">
			<div align="center">		
				<form action="<%= request.getContextPath() %>/back/homeAnn.do" method="post" id="myForm">
					<a href="<%= request.getContextPath() %>/management.jsp">回主頁</a>
					<h3><b>所有欄位皆為必填欄位</b></h3>
					<div class="title">
					<label for="annId">公告編號:</label>
					<input id ="annId" name="annId" type="text" value="${param.annId}" style="border:0px ; font-weight: bold;" readonly />
					</div>
					
					<!-- 用js將timestamp型態轉換 -->
					<div class="title">
					<label for="annTime">公告日期:</label>
					<input id ="annTime" class="timeItem" name="annTime" type="text" value="${param.annTime}" style="border:0px ; font-weight: bold;" readonly />
					</div>
					
					<div class="title">
					<label for="annTitle">公告標題:</label>
					<input id ="annTitle" name="annTitle" type="text" value="${param.annTitle}"  style="border:0px ; font-weight: bold;"/>
					</div>
					
					<div class="title">
					<label for="annDetail">公告內容:</label>
					<textarea id ="annDetail" name="annDetail" style="border:0px ; font-weight: bold; width: 300px; height: 100px; resize: vertical;">${param.annDetail}</textarea>
					</div>

					<div class="title">
						<div></div>
						<input  type="hidden" name="action" value="update">
						<button type="submit" id="submit"> 送出修改 </button>
						<div></div>
					</div>
				</form>
			</div>
		</div>
	</div>
    

<script src="<%= request.getContextPath() %>/back_end/management.js"></script>
<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
 
	

<script>

	
	
</script>

</body>
</html>