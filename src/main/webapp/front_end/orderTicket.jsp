<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.entity.*"%>
<%@page import="com.service.*"%>
<%
ShowtimeInfo show = (ShowtimeInfo) request.getAttribute("selectedShow");

TicketDAOImpl ticketdao = new TicketDAOImpl();
List<Ticket> ticket = ticketdao.getAllforbooking();
request.setAttribute("ticket", ticket);

FoodDAOImpl fooddao = new FoodDAOImpl();
List<Food> food = fooddao.getAllfoodForbooking();
request.setAttribute("food", food);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>世界影城 HelloWorld Cinema</title>

<!-- RWD -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=yes">

<!-- 底部footer -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

<!-- 主要css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/orderTicket/css/orderStore.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/orderTicket/css/order.css" />
</head>

<body>
	<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />
	<br>
	<!-- ========================以下區域可放置其他內容======================== -->
	<div>

		<input type="hidden" id="selectedShowId" value="">


		<h1>線上訂票</h1>
		<div class="listing-item mb-20 section dark-translucent-bg">
			<div class="grid-space-0">
				<div class="call-to-action text-center">
					<h2 class="title" Align="Center">選擇電影票</h2>
					<p Align="Center">
						選擇您希望購買的電影票張數和類型.<br> 請注意系統將自動為您保留可訂的最佳座位, 若選擇特殊票種須到櫃台確認身分
					</p>
					<br>
					<div class="showtimeInfo">
						<h2 Align="Center"><%=show.getMovie().getMovieName()%></h2>
						<a href=""> <img class="moviepic"
							style="pointer-events: none;"
							src="data:image/jpeg;base64,<%=show.getMovie().getPicBase64()%>"></a>
						<br> <br>
						<p Align="Center" id="playDate"><%=show.getPlaydate()%></p>
						<p Align="Center" id="showTime"><%=show.getShowtime()%></p>
						<p Align="Center" id="screenId"><%=show.getScreen().getScreenId()%></p>
						<p style="display: none;" id="seatStatus"><%=show.getSeatStatus()%></p>
					</div>
				</div>
				<div class="accordion"
					style="margin: 4%; padding: 10px 40px 10px 15px;; margin-bottom: 5px;">
					<div class="accordion-item">
						<div class="accordion-header">
							<h3>選擇電影票</h3>
						</div>
						<div class="accordion-content show">
							<table class="table table-bordered">
								<thead>
									<tr class="order-type">
										<th>票種</th>
										<th>價格</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="ticket" items="${ticket}" varStatus="s">
										<tr class="ticket" id="${ticket.tkId}">
											<td class="ticket-name">${ticket.tkName}</td>
											<td class="ticket-price" value='${ticket.tkPrice}'>${ticket.tkPrice}</td>
											<td><button class="add-to-cart" id='test1'>加入購物車</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div style="width: 1000px; margin: 100px;">
		<button id='cart-button' class="trigger cart-button-style">查看購物車</button>
		<div id="shop">
			<c:forEach var="Food" items="${food}" varStatus="s">
				<div class="products" id="${Food.foodId}">
					<a href=""><img class="small-image"
						style="pointer-events: none;"
						src="<%=request.getContextPath()%>/food/DBGifReader?foodId=${Food.foodId}"></a>
					<p class="product-name">${Food.foodName}</p>
					<input type="hidden" name="">
					<p class="product-price" value='${Food.foodPrice}'>${Food.foodPrice}</p>
					<button class="add-to-cart" id='test'>加入購物車</button>
				</div>
			</c:forEach>
		</div>
		<div id='cart-wrapper' class="slider close">
			<div id='cart'>
				<div id="cart-products-wrapper">
					<table id="cart-table">
						<thead id="cart-table-header">
							<th class="name-col">商品名稱</th>
							<th class="quantity-col">數量</th>
							<th class="price-col">價格</th>
							<th class="updated-price-col">小計</th>
							<th class="remove-col">移除</th>
						</thead>
						<tbody id="cart-table-body"></tbody>
						<tbody id="ticket-table-body"></tbody>
					</table>
				</div>
			</div>

			<div id='amount-controls'>
				<div id="cart-amount-wrapper">
					<table>
						<tbody>
							<tr id='subtotal-wrappper'>
								<td id="subtotal-label">合計:</td>
								<td id="subtotal">0.00</td>
							</tr>
							<tr id="promo-checkout">
								<td>
									<button id="ks" class="keep-shopping">繼續購物</button>
								</td>
								<td>
									<form id="showtimeForm"
										action="<%=request.getContextPath()%>/MemBookingController"
										method="post">
										<input type="hidden" name="action" value="findScreen">
										<input type="hidden" name="screenId"
											value="<%=show.getShowtimeId()%>">
										<button type="submit" id="checkout">下一步</button>
									</form>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- ========================以上區域可放置其他內容======================== -->
	<br>


	<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />

	<script type="text/javascript">
		// 取得座位狀態
		var seatStatus = document.getElementById("seatStatus").textContent;
		var playDate = document.getElementById("playDate").textContent;
		var showTime = document.getElementById("showTime").textContent;
		var screenId = document.getElementById("screenId").textContent;

		// 將座位狀態存儲到 localStorage
		localStorage.setItem("seatStatus", seatStatus);
		sessionStorage.setItem("playDate", playDate);
		sessionStorage.setItem("showTime", showTime);
		sessionStorage.setItem("screenId", screenId);

		// 測試打印出來確認已經存儲
		console.log("Seat status stored in localStorage:");
		console.log(localStorage.getItem("seatStatus"));
		console.log(sessionStorage.getItem("playDate"));
		console.log(sessionStorage.getItem("showTime"));
		console.log(sessionStorage.getItem("screenId"));
	</script>

	<script
		src="<%=request.getContextPath()%>/front_end/orderTicket/js/index.js"></script>
	<script
		src="<%=request.getContextPath()%>/front_end/orderTicket/js/orderStore.js"></script>
	<script
		src="<%=request.getContextPath()%>/front_end/orderTicket/js/order.js"></script>
</body>


</html>
