<%@page import="java.sql.Time"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>

<%@ page import="java.util.Set"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.text.DateFormatSymbols"%>





<!DOCTYPE html>


<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC&display=swap"
	rel="stylesheet">

<link href="<%=request.getContextPath()%>/front_end/booking/orderItem.css"
	rel="stylesheet">



<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>世界影城 HelloWorld Cinema</title>

<meta name="description"
	content="世界影城、提供電影介紹、場次時刻表、購票資訊、會員網路訂票服務、電影周邊商品販售、影廳場地租借服務">
<meta name="keywords" content="世界、電影、世界影城、HelloWorld Cinema" />
<meta name="robots" content="Index,follow">
<meta property="og:title" content="世界影城" />
<meta property="og:image" content=".img/bk.jpg" />
<meta property="og:site_name" content="世界影城網站" />
<meta property="og:url" content="https://www.ambassador.com.tw" />
<meta property="og:description"
	content="世界影城、提供電影介紹、場次時刻表、購票資訊、會員網路訂票服務、電影周邊商品販售、影廳場地租借服務" />
<!-- RWD -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=yes">



<!-- 底部footer -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">


</head>




<body>

<%@ include file="../index/indexHeader.jsp" %>
	<!-- ========================以下區域可放置其他內容======================== -->

	<form action="BookingController" method="post" style="display: inline;">



		<div class="container_order_item">


			<%
			Booking booking = (Booking) request.getAttribute("myBooking");
			%>
			<input type="hidden" name="bookingNo"
				value="<%=booking.getBookingNo()%>">

			<%
			Set<OrderItem> orderItems = booking.getOrderItem();
			for (OrderItem orderItem : orderItems) {
			%>

			<input type="hidden" name="allSeats"
				value="<%=orderItem.getSeatNo()%>">
			<div class="cancel">

				<input type="checkbox" name="selectedSeats"
					value="<%=orderItem.getSeatNo()%>">

			</div>

			<div class="ticket created-by-anniedotexe">

				<div class="left">


					<div class="image">
						<img
							src="data:image/jpeg;base64,<%=booking.getShowtimeInfo().getMovie().getPicBase64()%>"
							alt="Movie Image" style="width: 200px; height: 288px;">


					</div>
					<div class="ticket-info">
						<p class="date">
							<span class="day"><%=booking.dayofweek(booking)%></span> <span
								class="date"><%=booking.dateformate(booking)%></span> <span>2024</span>
						</p>
						<div class="movieName">

							<h3><%=booking.getShowtimeInfo().getMovie().getMovieName()%></h3>

						</div>
						<div class="time">
							<p>
								<%=booking.timeformat(booking)%>
								<span>TO</span>
								<%=booking.endtime(booking)%>
							</p>
							<p><%=booking.getScreen().getScreenId()%>
								<span>預計入場: 開演前15分鐘</span>
							</p>
						</div>
						<p class="location">
							<span>中壢市幸福街1號8樓</span> <span class="separator"><i
								class="far fa-smile"></i></span><span>8th Fl, No1.Happinese St</span>
						</p>
					</div>
				</div>
				
				<div class="right">
					<p class="admit-one">
						<span>世界影城</span> <span>世界影城</span> <span>世界影城</span>
					</p>
					<div class="right-info-container">
						<div class="movieName">
							<h4><%=booking.getShowtimeInfo().getMovie().getMovieName()%></h4>
						</div>
						<div class="time">
							
							<p>
								座位: <span>@</span><%=orderItem.getSeatNo()%>
							</p>
							<p>
								票種: <%=orderItem.getTicket().getTkName()%>
							</p>
							<p>
								入場: <%=orderItem.getEntryStatus()%>
							</p>
						</div>
						<div class="barcode">
							<img
								src="https://external-preview.redd.it/cg8k976AV52mDvDb5jDVJABPrSZ3tpi1aXhPjgcDTbw.png?auto=webp&s=1c205ba303c1fa0370b813ea83b9e1bddb7215eb"
								alt="QR code">
						</div>
						<p class="ticket-number">
							#<%=booking.getBookingNo()%>


						</p>

					</div>
				</div>
			</div>
			<%
			}
			%>


			<%--======================這識食物區=============================--%>

			<%
			Set<FoodItem> foodItems = booking.getFoodItem();
			String foodName = "";

			if (foodItems != null && !foodItems.isEmpty()) {
			%>

			<div class="cancel">

				<input type="checkbox" name="selectedfood"
					value="<%=booking.getBookingNo()%>">

			</div>
			<div class="ticket-food created-by-anniedotexe">
				<div class="left">
					<div class="image">
						<img src="./images/set1.jpg" alt="Movie Image"
							style="width: 260px; height: 260px;">


					</div>
					<div class="ticket-info">
						<p class="date">
							<span class="day"><%=booking.dayofweek(booking)%></span> 
							<span class="date"><%=booking.dateformate(booking)%></span> <span>2024</span>
						</p>
						<div class="movieName">

							<%
							for (FoodItem foodItem : foodItems) {
								foodName = foodItem.getFood().getFoodName();
							%>
							<h6><%=foodName%></h6>

							<%
							}
							%>

						</div>
						<div class="time">

							<p>請至9樓食物區取餐喔!</p>
						</div>
						<p class="location">
							<span>中壢市幸福街1號8樓</span> <span class="separator"><i
								class="far fa-smile"></i></span><span>8th Fl, No1.Happinese St</span>
						</p>
					</div>
				</div>
				<div class="right">
					<p class="admit-one">
						<span>世界影城</span> <span>世界影城</span> <span>世界影城</span>
					</p>
					<div class="right-info-container">
						<div class="movieName">

							<%
							for (FoodItem foodItem : foodItems) {
								foodName = foodItem.getFood().getFoodName();
							%>
							<h1><%=foodName%>
								X
								<%=foodItem.getFoodAmount()%></h1>

							<%
							}
							%>

						</div>
						<div class="time">
							<%
							String status = "";
							for (FoodItem foodItem : foodItems) {
								foodName = foodItem.getFood().getFoodName();
								status = foodItem.getPickStatus();

							}
							%>
							<p>
								餐點狀態 <span>@</span><%=status%>
							</p>
						</div>
						<div class="barcode">
							<img
								src="https://external-preview.redd.it/cg8k976AV52mDvDb5jDVJABPrSZ3tpi1aXhPjgcDTbw.png?auto=webp&s=1c205ba303c1fa0370b813ea83b9e1bddb7215eb"
								alt="QR code">
						</div>


						<p class="ticket-number">
							#
							<%=booking.getBookingNo()%>
						</p>

					</div>
				</div>
			</div>


	<div class="button-container">
		<a href="./front_end/booking/booking.jsp">
			<button type="button" class="custom-btn btn-16">往前一頁</button>
		</a>
		<button type="button" class="custom-btn btn-16 cancelorder cancelling">取消訂單</button>
		<input type="hidden" name="action" value="cancelbooking">

		<button type="submit" class="custom-btn btn-16 confirm">確認</button>
		

	</div>
	
		</form>
	<%
	} else {

		%>
		
			<div class="button-container">
		<a href="front_end/booking/booking.jsp">
			<button type="button" class="custom-btn btn-16">往前一頁</button>
		</a>
		<button type="button" class="custom-btn btn-16 cancelorder cancelling">取消訂單</button>
		<input type="hidden" name="action" value="cancelbooking">

		<button type="submit" class="custom-btn btn-16 confirm">確認</button>
		

	</div>
	
		</form>
		
		<%
	
	}
	%>





	<!-- ========================主區 container 結束標籤======================== -->
</div>

	<!-- =======================區域可放置其他內容======================== -->
	<br>



	<!-- 底部footer -->
<%@ include file="../index/indexFooter.jsp" %>

  
    <script src="<%= request.getContextPath() %>/js/index.js"></script>


	<script src="./front_end/jq/jq.js"></script>

	<script>
		$("button.cancelorder").on("click", function() {
			$("div.cancel").toggleClass("-on");
			$("button.confirm").toggleClass("-on");
			$(this).hide();
		      $("html, body").animate({ scrollTop: 0 }, "slow");

			alert("請勾選您要取消的座位或餐點並點擊確認鍵");
		});

		$("button.confrim").on("click", function() {

			$("button.cancelorder").show();

		});
	</script>



</body>
</html>