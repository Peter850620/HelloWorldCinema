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
		 <div align="center"> <h2>單一公告資料</h2>
		 <h3><a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll">回查詢頁</a></h3></div>
	</nav>
	
	<div class="container">
		<span>公告編號:</span><span>${homeAnn.annId}</span><br/>
		<span>公告日期:</span><span class="timeItem">${homeAnn.annTime}</span><br/>
		<span>公告標題:</span><span>${homeAnn.annTitle}</span><br/>
		<span>公告內容:</span><br/>
		<textarea readonly>${homeAnn.annDetail}</textarea><br/>
	</div>
</div>


<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
</body>
</html>