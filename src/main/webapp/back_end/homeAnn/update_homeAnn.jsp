<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
		 .xxx {
			margin: 20px auto;
			width: 110%;
			border-radius: 25px;
			justify-content: center;
			padding: 50px 100px;
			background-color: rgb(0 0 0/ 60%);
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			left: 150px;
			border: 2px solid white;
			margin-left: 80px;
			font-size: 25px;
			color:white;
		}

		button {
		  border-radius: 25px;
		  background-color: red;
		  font-size: 20px;
		  width: 90px;
		  transition-duration: 0.5s;
		  color: white;
		}
		
		button:hover {
		  background-color: darkred;
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
			background-color: rgb(135, 189, 250);
        	border: solid white;
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
			resize: none;
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
	<div class="xxx" id="xxx">
		<div class="mainIndex" id="mainIndex">
			<form action="<%= request.getContextPath() %>/back/homeAnn.do" method="post" id="myForm">
				<div class="form_head">
					<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll">回主頁</a>
					<h3><b>公告詳細資料</b></h3>
				</div>
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
					<span  id ="annTitle.errors" class="error">${errorMsgs.annTitle}</span>
				</div>
				<div class="title">
					<label for="annDetail">公告內容:</label>
					<textarea id ="annDetail" name="annDetail">${param.annDetail}</textarea>
					<span  id ="annDetail.errors" class="error">${errorMsgs.annDetail}</span>
				</div>
				<div class="title">
					<input  type="hidden" name="action" value="update">
					<button type="submit" id="submit"> 送出修改 </button>
				</div>
			</form>
		</div>
	</div>
<script>
	function hideContent(d) {
	    document.getElementById(d).style.display = "none";
	}
	document.addEventListener("DOMContentLoaded", function() {
	    var annTimeInput = document.getElementById("annTime");
	    var annTimeValue = annTimeInput.value;
	    
	    if (annTimeValue) {
	        var date = new Date(annTimeValue);
	        var formattedDate = date.toISOString().slice(0, 19).replace('T', ' ');
	        annTimeInput.value = formattedDate;
	    }
	});	
	
	
</script>

</body>
</html>