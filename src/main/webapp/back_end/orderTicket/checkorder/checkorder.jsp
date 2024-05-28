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
</head>
<body>
	<jsp:include page="/back_end/orderTicket/index/indexHeader.jsp"
		flush="true" />
	<form id="checkout-form"
		action="<%=request.getContextPath()%>/MemBookingController"
		method="post">
		<%
		ShowtimeInfo show = (ShowtimeInfo) session.getAttribute("whichShow");
		%>
		<div class="theatre">
			<div class="screen-side">
				<div class="screen"></div>
				<h3 class="select-text">購物清單</h3>
				<div id="shoppingList"></div>
			</div>
			<br>
			<div class="screen-side">
				總共價格: <span id="subtotalDisplay"></span> <input type="hidden"
					name="subtotal" id="subtotalHidden" value="subtotal">
			</div>
			<input type="hidden" id="tkId1" name="tkId1" value="tkId1">
			<input type="hidden" id="tkId2" name="tkId2" value="tkId2">
			<input type="hidden" id="tkId3" name="tkId3" value="tkId3">
			<input type="hidden" id="tkId4" name="tkId4" value="tkId4">
			<input type="hidden" name="seatSelection" value="">
			<input type="hidden" name="showId" value="showId">
			<div style="text-align: center;">
				<button type="button" id="lastButton">上一步</button>
				<input type="hidden" name="action" value="bookingSuccess"> <input
					type="hidden" id="paymentType" name="paymentType">
				<button type="submit" name="paymentType" id="nextButton">結帳</button>
			</div>
		</div>
	</form>

	<script type="text/javascript" src="./checkorder.js"></script>
	<jsp:include page="/back_end/orderTicket/index/indexFooter.jsp"
		flush="true" />

</body>
</html>
