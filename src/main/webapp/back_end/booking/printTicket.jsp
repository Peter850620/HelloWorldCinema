<%@page import="java.sql.Time"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.service.*"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.text.DateFormatSymbols"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>列印電影票</title>

<link href="<%=request.getContextPath()%>/back_end/booking/printTicket.css"
	rel="stylesheet">
</head>
<body>

<jsp:include page="../management.jsp" />

<form action="BookingController" method="post" style="display: inline;">



		<div class="container_order_item">


			<%
			Integer bookingNo = (Integer) session.getAttribute("newbookingno");
			BookingService bookingSvc=new BookingService();
			Booking booking=bookingSvc.getOneBooking(bookingNo);
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


              <div class="printable-content">
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
							  現場票
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

		
			<div class="ticket-food created-by-anniedotexe">
				<div class="left">
					<div class="image">
						<img src="<%=request.getContextPath() %>/images/set1.jpg" alt="Movie Image"
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
					<div class="right-info-container-food">
						<div class="foodName">

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
						
							<p>
								餐點: 現場票
							</p>
						</div>
						<div class="barcode">
							<img
								src="https://external-preview.redd.it/cg8k976AV52mDvDb5jDVJABPrSZ3tpi1aXhPjgcDTbw.png?auto=webp&s=1c205ba303c1fa0370b813ea83b9e1bddb7215eb"
								alt="QR code">
						</div>


					</div>
				</div>
			</div>
		</div>
		
		<button type="button" onclick="printPage()" class="btn">列印票卷</button>
		<button type="button" class="btn" id="back" onclick="redirectToSearch()">返回</button>
		<%
	} else {

		%>
			
			<button type="button" onclick="printPage()" class="btn">列印票卷</button>
			<button type="button" class="btn" id="back" onclick="redirectToSearch()">返回</button>
			<%} %>
			
			
			  <script type="text/javascript">
        function printPage() {
            window.print();
        }
        
        

        function redirectToSearch(){
        	
        	
        	window.location.href="back_end/booking/bookingSearch.jsp"
        }
    </script>

</body>
</html>