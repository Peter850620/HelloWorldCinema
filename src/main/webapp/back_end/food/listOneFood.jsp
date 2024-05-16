<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>







<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>餐點單項資料</title>

<%@ include file="included-fragment.file" %>
<style type="text/css">
	
    span {
		display: inline-block;
		width: 150px;
		text-align: left;
		font-weight: bold;
	}
</style>
</head>
<body>

<nav class="navbar navbar-expand-md navbar-dark bg-success fixed-top justify-content-center">
		 <div align="center"> <h2>餐點單項資料</h2>
		 <h3><a class="navbar-brand" href="<%=request.getContextPath()%>/back_end/food/select_page.jsp"><img src="<%=request.getContextPath()%>/images/back1.gif">回查詢頁${success}</a></h3></div>
</nav>

	<div align="center">
		<h3><span>查詢結果 :</span></h3>
		<span>食物編號:</span><span>${Food.foodId}</span><br/>
		<span>食物名稱:</span><span>${Food.foodName}</span><br/>
		<span>食物描述:</span><span>${Food.foodDetails}</span><br/>
		<span>價格:</span><span>${Food.foodPrice}</span><br/>
		<span>上/下架:</span><span>${Food.foodStatus}</span><br/>
		<span>食物圖片:</span><span><img src="<%=request.getContextPath()%>/food/DBGifReader?foodId=${Food.foodId}" width="100px"></span><br/>
	</div>


</body>
</html>