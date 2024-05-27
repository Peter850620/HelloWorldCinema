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
<form id="checkout-form" action="<%=request.getContextPath() %>/memBookingController"  method="post"  >
	
	<div class="theatre">
		<div class="screen-side">
			<div class="screen"></div>
			<h3 class="select-text">購物清單</h3>
			<div id="shoppingList"></div>
		</div>
		<br>
		<div class="screen-side" >總共價格: <span id="subtotal" name="subtotal"></span></div>


		<div style="text-align: center;">
			<button id="lastButton">上一步</button>
			<input type="hidden" id="paymentType" name="paymentType" value="">
			 <input type="hidden" name="action" value="bookingSuccess">
			 <input type="hidden" type="submit" name="payment">
			<button type="submit" id="nextButton">結帳</button>
		</div>
	</div>
</form>
	<jsp:include page="/back_end/orderTicket/index/indexFooter.jsp"
		flush="true" />
	<script type="text/javascript" src=./checkorder.js></script>

</body>

</html>
