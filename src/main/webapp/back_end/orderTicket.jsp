<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.entity.*"%>
<%@page import="com.service.*"%>
<%
FoodDAOImpl foodDAO = new FoodDAOImpl();
List<Food> foodList = foodDAO.getAll();
pageContext.setAttribute("foodList", foodList);

TicketDAOImpl ticketDAO = new TicketDAOImpl();
List<Ticket> ticketList = ticketDAO.getAll();
pageContext.setAttribute("ticketList", ticketList);

//優先從 session 獲取 showId
Integer showId = (Integer) session.getAttribute("showtimeId");
if (showId == null) {
	// 如果 session 中沒有，則嘗試從 request 獲取
	Object showIdObj = request.getAttribute("showtimeId");
	if (showIdObj != null) {
		showId = (Integer) showIdObj;
	} else {
		// 如果都沒有，設置默認值
		showId = 6;
	}
}

ShowtimeInfoDAOImpl showtimeInfoDAO = new ShowtimeInfoDAOImpl();
ShowtimeInfo show = showtimeInfoDAO.getById(showId);
%>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
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



<!-- 主要css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back_end/orderTicket/css/orderStore.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back_end/orderTicket/css/index.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/back_end/orderTicket/css/order.css" />
</head>


<body>
	<!-- 載入動畫 -->
	<canvas></canvas>


	<!-- 選單 -->
	<header class="header">
		<div id="box" class="logo">
			<h1 class="neon">
				<a href="index.html"><span class="logo_el">H</span>ello<span
					class="logo_el">W</span>orld <span class="logo_el">C</span>inema</a>
			</h1>
		</div>
		<div id="box">
			<nav class="nav">
				<ul class="nav_menu">
					<li class="nav__menu-item"><a href="">
							<h4 class="neon2">影城資訊</h4>
					</a>
						<ul class="nav__submenu">
							<li class="nav__submenu-item"><a href="">最新資訊</a></li>
							<li class="nav__submenu-item"><a href="">票價說明</a></li>
							<li class="nav__submenu-item"><a
								href="movieCommingSoon.html">即將上映</a></li>
							<li class="nav__submenu-item"><a href="movieNowShowing.html">現正熱映</a>
							</li>
						</ul></li>
					<li class="nav__menu-item"><a href="">
							<h4 class="neon2">線上訂票</h4>
					</a>
						<ul class="nav__submenu">
							<li class="nav__submenu-item"><a href=""></a></li>

						</ul></li>
					<li class="nav__menu-item"><a href="merchStore.html">
							<h4 class="neon2">周邊商城</h4>
					</a>
						<ul class="nav__submenu">
							<li class="nav__submenu-item"><a href=""></a></li>

						</ul></li>
					<li class="nav__menu-item"><a href="">
							<h4 class="neon2">場地租借</h4>
					</a>
						<ul class="nav__submenu">
							<li class="nav__submenu-item"><a href="">場地租借須知</a></li>
							<li class="nav__submenu-item"><a href="">可租借場地資訊</a></li>
							<li class="nav__submenu-item"><a href="">租借表單填寫</a></li>
						</ul></li>
					<li class="nav__menu-item"><a href="">
							<h4 class="neon2">Log In</h4>
					</a>
						<ul class="nav__submenu">
							<li class="nav__submenu-item"><a href=""></a></li>

						</ul></li>
				</ul>
			</nav>
		</div>

	</header>


	<br>
	<!-- ========================以下區域可放置其他內容======================== -->


	<div>
		<h1>線上訂票</h1>
		<div class="listing-item mb-20 section dark-translucent-bg">
			<div class="grid-space-0">
				<div class="call-to-action text-center">
					<h2 class="title" Align="Center">選擇電影票</h2>
					<p Align="Center">
						選擇您希望購買的電影票張數和類型.<br> 請注意系統將自動為您保留可訂的最佳座位, 若選擇特殊票種須到櫃台確認身分
					</p>

					<br>

					<div var="showtimeInfo">
						<h2 Align="Center"><%=show.getMovie().getMovieName()%></h2>
						<a href=""> <img class="moviepic"
							style="pointer-events: none;"
							src="data:image/jpeg;base64,<%=show.getMovie().getPicBase64()%>"></a>
						<br> <br>
						<p Align="Center"><%=show.getPlaydate()%></p>
						<p Align="Center"><%=show.getShowtime()%></p>
						<p Align="Center"><%=show.getScreen().getScreenId()%></p>
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
									<c:forEach var="Ticket" items="${ticketList}" varStatus="s">
										<tr class="ticket" id="${Ticket.tkId}">
											<td class="ticket-name">${Ticket.tkName}</td>
											<td class="ticket-price" value='${Ticket.tkPrice}'>${Ticket.tkPrice}</td>
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

			<c:forEach var="Food" items="${foodList}" varStatus="s">
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
								<form id="showtimeForm" action="<%=show.getScreen().getScreenId()%>" method="post">
									<input type="hidden" name="screenId"
										value="<%=show.getScreen().getScreenId()%>">
									<button type="submit" id="checkout">下一步</button>
								</form>
								<!-- 注意將button的type設為button以防自動提交 -->
								
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	

	<!-- ========================以上區域可放置其他內容======================== -->
	<br>





	<!-- 底部footer -->
	<footer class="footer">
		<div class="titleCont">
			<h1 class="main-title" id="main-title">"You must not be afraid
				to dream a little bigger, darling."</h1>
		</div>
		<div class="container">
			<div class="row">
				<div class="footer-col">
					<h4 class="neon2">關於我們</h4>
					<ul>
						<li><a href="#">影城簡介</a></li>
						<li><a href="#">影城交通</a></li>
						<li><a href="#">影城設備</a></li>
						<li><a href="#">注意事項</a></li>
					</ul>
				</div>
				<div class="footer-col">
					<h4 class="neon2">電影評論區</h4>
					<ul>
						<li><a href="#">影評查詢</a></li>
						<li><a href="#">電影分類</a></li>
						<li><a href="#">排行榜</a></li>
					</ul>
				</div>
				<div class="footer-col">
					<h4 class="neon2">客服中心</h4>
					<ul>
						<li><a href="#">FAQ</a></li>
						<li><a href="#">真人聊天室</a></li>
					</ul>
				</div>
				<div class="footer-col">
					<h4 class="neon2">follow us</h4>
					<div class="social-links">
						<a href="#"><i class="fab fa-facebook-f"></i></a> <a href="#"><i
							class="fab fa-twitter"></i></a> <a href="#"><i
							class="fab fa-instagram"></i></a> <a href="#"><i
							class="fab fa-linkedin-in"></i></a>
					</div>
				</div>
			</div>
		</div>
	</footer>





	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/back_end/orderTicket/js/jquery-3.4.1.min.js"></script>


</body>
<!-- 主要js -->
<script
	src="<%=request.getContextPath()%>/back_end/orderTicket/js/index.js"></script>
<script
	src="<%=request.getContextPath()%>/back_end/orderTicket/js/orderStore.js"></script>
<script
	src="<%=request.getContextPath()%>/back_end/orderTicket/js/order.js"></script>
</html>