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
<title>瀏覽會員全部訂單</title>




<link href="<%=request.getContextPath()%>/back_end/booking/checkBooking.css"
	rel="stylesheet">



</head>




<body>

	<jsp:include page="../management.jsp" />


<%Booking booking=(Booking)request.getAttribute("booking");
Set <OrderItem> orderitems=booking.getOrderItem();
 %>
	<div class="container-main">
		<h1 class="booking">訂單詳情  <%=booking.getMem()!=null? booking.getMem().getMemName():"" %></h1>
		<form action="<%=request.getContextPath() %>/MgmBookingController" id="myform" method="post">
		<table>
			<tr>
			    <th>取消(勾選)</th>
				<th>訂單編號</th>
				<th>電影名稱</th>
				<th>開演日期</th>
				<th>時間</th>
				<th>廳位</th>
				<th>票種</th>
				<th>座位</th>
				<th>座位狀態</th>	
				
			</tr>
			
			
         <% 
         for(OrderItem order:orderitems){
         
        	
         
         %>
         
        

        <tr>
            <td><input type="checkbox" name="selectedSeats" class="regular-checkbox big-checkbox" value="<%=order.getSeatNo()  %>"/></td>
            <td><%= booking.getBookingNo() %></td>
            <td><%= booking.getShowtimeInfo().getMovie().getMovieName() %></td>
            <td><%= booking.getShowtimeInfo().getPlaydate() %></td>
            <td><%= booking.timeformat(booking)%></td>
            <td><%= booking.getScreen().getScreenId() %></td>
            <td><%=order.getTicket().getTkName() %></td>
            <td><%=order.getSeatNo()  %></td>
            <td><%=order.getEntryStatus()%></td>
            <td>  <input type="hidden" name="allSeats" value="<%=order.getSeatNo()%>">  </td>
           
        </tr>
        
             
        <% 
     
             } 
         %>



		</table> 
		
	<%  
    Set<FoodItem> food = booking.getFoodItem();
    if (food != null && !food.isEmpty()) {	
%>	 
    <table>
        <tr>
            <th>取消(勾選)</th>
            <th>訂單編號</th>
            <th>食物</th>
            <th>數量</th>
            <th>取餐狀態</th>	
        </tr>
        
        <% 
            for(FoodItem eachOrder : food) { 
        %>
            <tr>
                <td><input type="checkbox" name="foodSeq" class="regular-checkbox big-checkbox" value="<%= eachOrder.getFoodSeq() %>"/></td>
                <td><%= booking.getBookingNo() %></td>
                <td><%= eachOrder.getFood().getFoodName() %></td>
                <td><%= eachOrder.getFoodAmount() %></td>
                <td><%= eachOrder.getPickStatus() %></td>	
            </tr>
        <% 
            } 
        %>
    </table> 
<% 
    } 
%>

		<input type="hidden" name="action" value="cancelBooking">
		<input type="hidden" name="bookingNo" value="<%= booking.getBookingNo() %>"> 
		<button type="button" class="btn" id="selectAll" onclick="">全選</button>
		<button type="submit" class="btn" onclick="confirmSubmit()">取消</button>
	     <button type="button" class="btn" id="back" onclick="redirectToSearch()">返回</button>
		</form>
	
		
		
	</div>
	



<script type="text/javascript">


function redirectToSearch(){
	
	
	window.location.href="back_end/booking/bookingSearch.jsp"
}



function confirmSubmit() {
    if (confirm("確定要取消嗎？")) {
        document.getElementById("myForm").submit();
    } else {
     
    }
}


document.getElementById('selectAll').addEventListener('click', function() {
    var checkboxes = document.querySelectorAll('.regular-checkbox');
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = !checkbox.checked;
    });
});

</script>

</body>
</html>




               