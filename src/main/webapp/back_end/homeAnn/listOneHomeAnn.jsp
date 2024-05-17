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
		background-color: white;
	}
	
    span {
		display: inline-block;
		width: 150px;
		text-align: left;
		font-weight: bold;
	}
</style>
</head>
<body>
<%@ include file="../management.jsp" %>
<div class="xxx" id="xxx">
	<nav class="navbar navbar-expand-md navbar-dark bg-success fixed-top justify-content-center">
		 <div align="center"> <h2>單一檢舉資料 - listOneHomeAnn.jsp</h2>
		 <h3><a class="navbar-brand" href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll">回查詢頁${success}</a></h3></div>
	</nav>
	
	<div align="center">
		<h3><span>查詢結果 :</span></h3>
		<span>公告編號:</span><span>${homeAnn.annId}</span><br/>
		<span>公告日期:</span><span class="timeItem">${homeAnn.annTime}</span><br/>
		<span>公告標題:</span><span>${homeAnn.annTitle}</span><br/>
		<span>公告內容:</span><span>${homeAnn.annDetail}</span><br/>
	</div>
</div>


<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
</body>
</html>