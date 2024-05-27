<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.dao.*"%>
<%@page import="com.entity.*"%>
<%@page import="com.service.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>世界影城 HelloWorld Cinema</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen1/screen1.css">
<style>
</style>
</head>

<jsp:include page="/back_end/orderTicket/index/indexHeader.jsp"
	flush="true" />


<body>
	<div>
		<li><form method="post"
				action="<%=request.getContextPath()%>/food/food.do">
				選擇食物編號: <select size="1" name="foodId">
					<c:forEach var="Food" items="${foodSvc.all}">
						<option value="${Food.foodId}">${Food.foodId}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</form>
			</li>
	</div>


	<script
		src="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen.js">
		
	</script>

</body>
<jsp:include page="/back_end/orderTicket/index/indexFooter.jsp"
	flush="true" />
</html>