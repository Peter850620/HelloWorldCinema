<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%
	// 系統日期
	Date currentDate = new Date(System.currentTimeMillis());
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String currentDateForString = sdf.format(currentDate);
	
	// 系統日期+一個月
	Calendar calendar = Calendar.getInstance();
    calendar.setTime(currentDate);
    calendar.add(Calendar.MONTH, 1);
	Date onemonthlater = new Date(calendar.getTimeInMillis());
	String onemonthlaterForString = sdf.format(onemonthlater);
%>






<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>場次資料修改</title>

<style type="text/css">
.main{	

		body {
			margin: 20px auto;
			padding: 20px;
			width: 80%;
			border-radius: 25px;
			justify-content: center;
			padding: 100px;
			background-color: rgb(0 0 0/ 60%);
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			left: 150px;
			border: 2px solid white;
			margin-left: 80px;
			color:white;
		}
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
	
		input[type="text"], input[type="date"], select {
			width: calc(100% - 15px);
			margin-bottom: 10px;
			padding: 10px;
			border: 1px solid #ccc;
			border-radius: 5px;
			 color: white;
		}
	
		input[type="date"] {
    		font-weight: bold;
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
		
		ul {
			list-style-type: none;
			padding: 0;
			margin: 0;
		}
		
		li {
			color: red;
			margin-bottom: 5px;
		}
		
		h4{
		  font-size: 30px;
		}
		
		h4{
		  font-size: 30px;
		}
		
		#a{
		  font-size: 30px;
		  color: white; /* 设置背景颜色为蓝色 */
		}
		
		select {
		  appearance: none;
		  -webkit-appearance: none;
		 width:calc(100% - 15px);
		  padding: 5px;
		  font-size: 20px;
		  background-color: rgba(162, 161, 167, 0.5);
		  border: 1px solid #caced1;
		  border-radius: 5px;
		  color: #ffff;
		  cursor: pointer;
		  text-align: center;
		  height:42px;
		}
		
		input {
		  width: 150px;
		  font-size: 15px;
		  border-radius: 5px;
		  background-color: rgba(162, 161, 167, 0.5);
		  color: #ffff;
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
	}
}
</style>
</head>
<body>
<%@ include file="../management.jsp" %>

<div class="main">
	<nav class="navbar navbar-expand-md navbar-dark bg-success fixed-top justify-content-center">
			 <div align="center"> <h2>場次資料修改</h2>
			 <h3><a class="navbar-brand" href="<%=request.getContextPath()%>/back_end/showtimeInfo/listAllShowtimeInfo.jsp"><img src="<%=request.getContextPath()%>/resources/images/back1.gif">回查詢頁</a></h3></div>
	</nav>

	<div align="center">
		<h3><b>所有欄位皆為必填欄位</b></h3>
			
			
			<jsp:useBean id="MovieSvc" scope="page" class="com.service.MovieService" />
			<jsp:useBean id="ScreenSvc" scope="page" class="com.service.ScreenServicePeter" />
			<form action="<%=request.getContextPath()%>/showtimeInfo/showtimeInfoPeter.do" method="post">
				
	
				
				
				<div>
					<label for="showtimeId">場次編號:</label>
					<input id ="showtimeId" name="showtimeId" type="text" value="${param.showtimeId}" style="border:0px ; font-weight: bold;" readonly />
				</div>
				
				<div>
					<label for="movieName">電影名稱:</label>
					<input id ="movieName" name="movieName" type="text" value="${param.movieName}" style="border:0px ; font-weight: bold;" readonly />
				</div>
								
				<div>
			        <label for="runtime">電影時長 (分鐘):</label>
			        <input type="number" id="runtime" name="runtime" value="${param.runtime}" readonly>
			    </div>
				
				<div>
					<label for="screenId">影廳:</label>
					<select size="1" name="screenId">
					    <c:forEach var="Screen"  items="${ScreenSvc.screenId}">
					    		<option value="${Screen.getScreenId()}">${Screen.getScreenId()}</option>
						</c:forEach>    
					</select>
				</div>
								
				<div>
					<label for="playdate">播放日期:</label>
					<input type="date" value="<%=currentDateForString%>" name="playdate" min="<%=currentDateForString%>" max="<%=onemonthlaterForString%>">
				</div>
				
				<div>
					<label for="showtime">選擇起始時間：</label>
					<input type="time" id="showtime" name="showtime" value="${param.showtime}" onclick="hideContent('showtime.errors');" onchange="calculateTotalTime()" >
					<span  id ="showtime.errors" class="error">${errorMsgs.showtime}</span>
				
				</div>
				
				<div>
					<label for="endtime">結束時間：</label>
					<input type="time" id="endtime" name="endtime" value="${param.endtime}" onclick="hideContent('endtime.errors');" readonly>
					<span  id ="endtime.errors" class="error">${errorMsgs.endtime}</span>
				</div>
				
				
			    <div>
			        <label for="additionalTime">附加清潔時間 (分鐘):</label>
			        <input type="number" id="additionalTime" name="additionalTime" value="30" onchange="calculateTotalTime()">
			    </div>
				
				<div>
					<div></div>
					<input  type="hidden" name="action" value="update">
					<button type="submit" id="submit"> 送出更新 </button>
					<div></div>
				</div>
				
			</form>
	</div>
</div>

<!-- JavaScript part -->
<script type="text/javascript">
//清除提示信息
function hideContent(d) {
     document.getElementById(d).style.display = "none";
}

//照片上傳-預覽用
var filereader_support = typeof FileReader != 'undefined';
if (!filereader_support) {
	alert("No FileReader support");
}
acceptedTypes = {
		'image/png' : true,
		'image/jpeg' : true,
		'image/gif' : true
};
function previewImage() {
	var upfile1 = document.getElementById("upFiles");
	upfile1.addEventListener("change", function(event) {
		var files = event.target.files || event.dataTransfer.files;
		for (var i = 0; i < files.length; i++) {
			previewfile(files[i])
		}
	}, false);
}
function previewfile(file) {
	if (filereader_support === true && acceptedTypes[file.type] === true) {
		var reader = new FileReader();
		reader.onload = function(event) {
			var image = new Image();
			image.src = event.target.result;
			image.width = 100;
			image.height = 75;
			image.border = 2;
			if (blob_holder.hasChildNodes()) {
				blob_holder.removeChild(blob_holder.childNodes[0]);
			}
			blob_holder.appendChild(image);
		};
		reader.readAsDataURL(file);
		document.getElementById('submit').disabled = false;
	} else {
		blob_holder.innerHTML = "<div  style='text-align: left;'>" + "● filename: " + file.name
				+ "<br>" + "● ContentTyp: " + file.type
				+ "<br>" + "● size: " + file.size + "bytes"
				+ "<br>" + "● 上傳ContentType限制: <b> <font color=red>image/png、image/jpeg、image/gif </font></b></div>";
		document.getElementById('submit').disabled = true;
	}
}
</script>

</body>
<script src="<%=request.getContextPath()%>/back_end/showtimeInfo/showtimeInfo.js"></script>
</html>