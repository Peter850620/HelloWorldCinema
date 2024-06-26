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
<title>訂單明細</title>


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC&display=swap"
	rel="stylesheet">

<link href="<%=request.getContextPath()%>/front_end/booking/orderItem.css"
	rel="stylesheet">




</head>




<body>

<%@ include file="../index/indexHeader.jsp" %>
	<!-- ========================以下區域可放置其他內容======================== -->

	<form action="<%= request.getContextPath() %>/BookingController" method="post" style="display: inline;">



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
							alt="Movie Image" style="width: 220px; height: 288px;">


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
								<input type="hidden" class="date" value="<%=booking.getShowtimeInfo().getPlaydate()%>">
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
								src="data:image/jpeg;base64,<%=orderItem.getPicBase64()%>"
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
							style="width: 240px; height: 270px;">


					</div>
					<div class="ticket-info">
						<p class="date">
							<span class="day"><%=booking.dayofweek(booking)%></span> 
							<span class="date"><%=booking.dateformate(booking)%></span> <span>2024</span>
						</p>
						<div class="left-foodName">

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
								src="<%=request.getContextPath()%>/food/FoodGifReader?bookingNo=<%=booking.getBookingNo()%>"
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


  
  


	<script src="./front_end/jq/jq.js"></script>

 <script>
        $(document).ready(function() {
            $("button.cancelorder").on("click", function(event) {
                var dateString = $('input.date').val(); 
                var currentDate = new Date();
                var dateParts = dateString.split('-');
                var startDate = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);

           

                if (startDate <= currentDate) {
                    event.preventDefault(); // 阻止表單提交
                    console.log("Preventing submission");
                    alert("訂單已超過取消期效，無法取消。");
                } else {
                    $("div.cancel").toggleClass("-on");
                    $("button.confirm").toggleClass("-on");
                    $(this).hide();
                    $("html, body").animate({ scrollTop: 0 }, "slow");
                    alert("請勾選您要取消的座位或餐點並點擊確認鍵");
                }
            });

            $("button.confirm").on("click", function(event) {
                $("button.cancelorder").show();
            });
        });
    </script>



</body>
</html>