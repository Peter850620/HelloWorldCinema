<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>檢舉資料</title>


<style type="text/css">
	.xxx{
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
		resize: vertical;
	}
	
</style>
</head>
<body>
<%@ include file="../management.jsp" %>
<div class="xxx" id="xxx">
	<nav class="nav_head">
		<h2>單一檢舉資料</h2>
	</nav>
	<div class="container">
		<span>檢舉編號:</span><span>${param.rptId}</span><br/>
		<span>會員編號:</span><span>${param.mem}</span><br/>
		<span>評論編號:</span><span>${param.review}</span><br/>
		<span>檢舉日期:</span><span id="timeItem" data-time="${param.rptDate}">${param.rptDate}</span><br/>
		<span>檢舉類型:</span><span>${param.rptType}</span><br/>
		<span>檢舉內容:</span><br/>
		<textarea readonly>${param.rptDetail}</textarea><br/>
		<span>狀態:</span><span>${param.rptStatus}</span><br/>
	</div>
	<div class="form_footer">
		<h3><a href="<%= request.getContextPath() %>/back/report.do?action=getAll">回查詢頁${success}</a></h3>
	</div>
</div>
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    var rptDateElement = document.getElementById("timeItem");
	    var rptDateValue = rptDateElement.getAttribute("data-time");
	
	    if (rptDateValue) {
	        var date = new Date(rptDateValue);
	        var formattedDate = date.getFullYear() + '-' + 
	                            String(date.getMonth() + 1).padStart(2, '0') + '-' + 
	                            String(date.getDate()).padStart(2, '0') + ' ' + 
	                            String(date.getHours()).padStart(2, '0') + ':' + 
	                            String(date.getMinutes()).padStart(2, '0') + ':' + 
	                            String(date.getSeconds()).padStart(2, '0');
          	rptDateElement.textContent = formattedDate;	
	    }
	});
</script>
</body>
</html>