<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<style>

		 .xxx {
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
			width: 80px;
			height: 35px;
			font-size: 16px;
		}
		
		a{
			color: white;
		}

	</style>
</head>



<body>
<%@ include file="../management.jsp" %>

	<div class="xxx" id="xxx">
		<div class="mainIndex" id="mainIndex">
			<form action="<%= request.getContextPath() %>/back/homeAnn.do" method="post" id="myForm">
				<a href="<%= request.getContextPath() %>/back_end/management.jsp">回主頁</a>
				<h3><b>所有欄位皆為必填欄位</b></h3>
				<div class="title">
					<label for="annId">公告編號:</label>
					<input id ="annId" name="annId" type="text" value="${param.annId}" readonly />
				</div>

				<div class="title">
					<label for="annTime">公告日期:</label>
					<input id ="annTime" class="timeItem" name="annTime" type="text" value="${param.annTime}" readonly />
				</div>
				
				<div class="title">
					<label for="annTitle">公告標題:</label>
					<input id ="annTitle" name="annTitle" type="text" value="${param.annTitle}"/>
				</div>
				
				<div class="title">
					<label for="annDetail">公告內容:</label>
					<textarea id ="annDetail" name="annDetail">${param.annDetail}</textarea>
				</div>

				<div class="title">
					<input  type="hidden" name="action" value="update">
					<button type="submit" id="submit"> 送出修改 </button>
				</div>
			</form>
		</div>
	</div>
    

<script src="<%= request.getContextPath() %>/back_end/management.js"></script>
<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
 
	

<script>

	
	
</script>

</body>
</html>