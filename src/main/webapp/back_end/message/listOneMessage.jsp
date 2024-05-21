<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>評論資料 - listOneReview.jsp</title>


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
	
    .nav_head{
		margin-left: 50px;
	}
	
	a{
		color:white;
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
		 <h3><a href="<%= request.getContextPath() %>/back/message.do?action=getAll">回主頁</a></h3>
	</nav>
	
	<div class="container">
		<h3><span>查詢結果 :</span></h3>
		<span>通知編號:</span><span>${message.msgId}</span><br/>
		<span>會員編號:</span><span>${message.mem.memId}</span><br/>
		<span>通知日期:</span><span class="timeItem">${message.msgTime}</span><br/>
		<span>通知狀態:</span><span>${message.msgStatus}</span><br/>
		<span>通知標題:</span><span>${message.msgTitle}</span><br/>
		<span>通知內容:</span><br/>
		<textarea readonly>${message.msgDetail}</textarea><br/>
	</div>
</div>

<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
</body>
</html>