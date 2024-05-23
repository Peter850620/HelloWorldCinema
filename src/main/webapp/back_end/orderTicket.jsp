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
        showId = 34;
    }
}

ShowtimeInfoDAOImpl showtimeInfoDAOImpl = new ShowtimeInfoDAOImpl();
ShowtimeInfo show = showtimeInfoDAOImpl.getById(showId);
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
<link rel="stylesheet"
    href="<%=request.getContextPath()%>/back_end/orderTicket/css/order.css" />
</head>

<body>
    <jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />
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
                        <p style="display:none;" id="seatStatus"><%=show.getSeatStatus()%></p>
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
                                <td>
                                    <form id="showtimeForm"
                                        action="<%=request.getContextPath()%>/MemBookingController"
                                        method="post">
                                        <input type="hidden" name="action" value="findScreen">
                                        <input type="hidden" name="screenId" value="<%=show.getShowtimeId()%>">
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script
        src="<%=request.getContextPath()%>/back_end/orderTicket/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        // 取得座位狀態
        var seatStatus = document.getElementById("seatStatus").textContent;

        // 將座位狀態存儲到 localStorage
        localStorage.setItem("seatStatus", seatStatus);

        // 測試打印出來確認已經存儲
        console.log("Seat status stored in localStorage:");
        console.log(localStorage.getItem("seatStatus"));
    </script>
</body>
<!-- 主要js -->
<script
    src="<%=request.getContextPath()%>/back_end/orderTicket/js/index.js"></script>
<script
    src="<%=request.getContextPath()%>/back_end/orderTicket/js/orderStore.js"></script>
<script
    src="<%=request.getContextPath()%>/back_end/orderTicket/js/order.js"></script>
</html>
