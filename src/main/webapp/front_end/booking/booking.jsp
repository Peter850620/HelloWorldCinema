<%@page import="com.mysql.cj.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>

<%@ page import="java.util.Set"%>
<%@ page import="java.util.List"%>
<%@ page import="com.service.BookingService"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>


<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>訂單查詢</title>


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC&display=swap"
	rel="stylesheet">

<link href="<%=request.getContextPath()%>/front_end/booking/booking.css"
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

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">

<!-- 底部footer -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">


</head>




<body>

<%@ include file="../index/indexHeader.jsp" %>

	<!-- ========================以下區域可放置其他內容======================== -->

	<div class="container-main">
	
	
	
<% 
Integer currentPage;
Integer memId = session.getAttribute("mem") != null ? ((Mem) session.getAttribute("mem")).getMemId() : 240005;
%>

			


			
<% 
   
List<Booking> bookings = null;
 

BookingService bookingSvc= new BookingService();

if(request.getAttribute("currentPage") == null){
    currentPage = 1;
    
	 
	  bookings = bookingSvc.getMemBookings(memId,currentPage,"bookingNo");
	   
} else {
    currentPage = (Integer) request.getAttribute("currentPage");
     bookings = (List<Booking>) request.getAttribute("bookings");  
}
%>			
	<form action="<%= request.getContextPath() %>/BookingController" method="post" id="sortform">
	<H3>依排序方式</H3>
	<select id="sorted" name="sorted" class="browser-default">
        <option value="訂單編號" selected>訂單編號</option>
        <option value="訂單成立日期"  >訂單成立日期</option>
        <option value="開演日期"  >開演日期</option>
       
    </select>
    <input type="hidden" name="action" value="getmembooking">
    <input type="hidden" name="memId" value=<%=memId %>>
    
    <button type="submit" class="btn waves-effect waves-light red btn_search btnCalss" >
                    
                    <i class='bx bx-search'></i>查詢</button>
              
    </form>
    
    
		<h1 class="booking">電影訂票記錄</h1>
		
		<table>
			<tr>
				<th>訂單編號</th>
				<th>訂單成立日期</th>
				<th>電影名稱</th>
				<th>開演日期</th>
				<th>時間</th>
				<th>廳位</th>
				<th>張數</th>
				<th>取票方式</th>
				<th>查看詳情</th>
			</tr>

<% 

		 
		if (bookings != null&& !bookings.isEmpty()) {
		    for (Booking booking : bookings) {
		        int count = 0;
		        Set<OrderItem> orderItems = booking.getOrderItem();
		        for (OrderItem item : orderItems) {
		            count++;
		        }
		    %>
        <tr>
       
            <td><%= booking.getBookingNo() %></td>
            <td><%= booking.getBookingDate() %></td>
            <td><%= booking.getShowtimeInfo().getMovie().getMovieName() %></td>
            <td><%= booking.getShowtimeInfo().getPlaydate() %></td>
            <td><%= booking.timeformat(booking)%></td>
            <td><%= booking.getScreen().getScreenId() %></td>
            <td><%= count %>張</td>
            <td><%= booking.getPickupOption() %></td>
            <td>
                <a href="#">
                    <form action="<%= request.getContextPath() %>/BookingController" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="moreDetails">
                        <input type="hidden" name="bookingNo" value="<%= booking.getBookingNo() %>">
                        <button type="submit" class="btn">查看詳情</button>
                    </form>
                </a>
            </td>
        </tr>
        <% 
       
           }

		} else { %>
    <tr>
        <td class="norecord" colspan="9">暫無訂購紀錄</td>
    </tr>
<% } %>



		</table>
	</div>
	


<% 

Object totalPageObj = request.getAttribute("totalPage");
int pageQty = totalPageObj != null ? (Integer)totalPageObj : bookingSvc.getPageTotal(memId);

%>




<div class="button-container">
    <% for(int i=1; i<=pageQty; i++) { %>
        <a id="link<%=i%>" href="<%=request.getContextPath()%>/BookingController?action=getmembooking&currentPage=<%=i%>">
            <button type="button" class="custom-btn btn-16 <%= i == currentPage ? "active" : "" %>"><%=i%></button>
        </a>
    <% } %>
</div>
<br>



	<!-- ========================主區 container 結束標籤======================== -->



	<!-- =======================區域可放置其他內容======================== -->



	<!-- 底部footer -->
<%@ include file="../index/indexFooter.jsp" %>

  
    <script src="<%= request.getContextPath() %>/js/index.js"></script>


<script>

document.addEventListener("DOMContentLoaded", function() {
    let sorted = document.getElementById("sorted");


    let storedValue = sessionStorage.getItem("sorted");


    if (storedValue) {
        sorted.value = storedValue;
    }

   
    sorted.addEventListener("change", function() {
        sessionStorage.setItem("sorted", sorted.value);
        checkpage();
    });
    
    checkpage();
});

function checkpage() {
    let buttonCount = <%= pageQty %>;
    let memId = <%= memId %>;
    let selectedSorted = sessionStorage.getItem("sorted") || '訂單編號';  // Default value
    let link;

    for (let i = 1; i <= buttonCount; i++) {
        let buttonId = "link" + i;
        let buttonElement = document.getElementById(buttonId);

        link = '<%=request.getContextPath()%>/BookingController?action=getmembooking&sorted=' + selectedSorted + '&memId=' + memId + '&currentPage=' + i;
        
        buttonElement.setAttribute("href", link);
    }
}

</script>


</body>
</html>
