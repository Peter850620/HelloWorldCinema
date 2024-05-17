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
		 <div align="center"> <h2>單一檢舉資料 - listOneMessage.jsp</h2>
		 <h3><a class="navbar-brand" href="<%= request.getContextPath() %>/back/message.do?action=getAll">回查詢頁${success}</a></h3></div>
	</nav>
	
	<div align="center">
		<h3><span>查詢結果 :</span></h3>
		<span>通知編號:</span><span>${message.msgId}</span><br/>
		<span>會員編號:</span><span>${message.mem.memId}</span><br/>
		<span>通知日期:</span><span class="timeItem">${message.msgTime}</span><br/>
		<span>通知狀態:</span><span>${message.msgStatus}</span><br/>
		<span>通知標題:</span><span>${message.msgTitle}</span><br/>
		<span>通知內容:</span><span size="70">${message.msgDetail}</span><br/>
	</div>
</div>

<script src="<%= request.getContextPath() %>/back_end/management.js"></script>
<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
</body>
</html>