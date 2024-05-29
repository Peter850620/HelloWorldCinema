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




<link href="<%=request.getContextPath()%>/back_end/booking/bookingSearch.css"
	rel="stylesheet">



</head>




<body>

	<jsp:include page="../management.jsp" />
	
	  <form action="<%= request.getContextPath() %>/MgmBookingController" id="sortedListAll" method="post">
           
            
              <input type="hidden" name="action" value="listAll">
                <div class="search">
                    <h1 class="title">查詢訂單 Bookings</h1>
                 <select name="pickupOption" id="pickupOption">
                        <option value="全部">全部</option>
					    <option value="現場票">現場票</option>
					    <option value="實體票">實體票</option>
					    <option value="電子票">電子票</option>
				</select>
                    <input type="text" id="bookingNo" name="bookingNo" placeholder="輸入訂單編號">
                    <input type="month" id="bookingDate" name="bookingDate" placeholder="月份查詢">
                    <button class="btn waves-effect waves-light red btn_search btnCalss" type="submit" >
                    <i class='bx bx-search'></i>查詢</button>
                    <button class="btn waves-effect all red btn_search btnCalss" type="button" onclick="redirect()" >全部</button>
                </div>
            </form>
            
          

	<div class="container-main">
		<h1 class="booking">瀏覽訂票記錄</h1>
		
		<table>
			<tr>
			    <th>會員編號</th>
				<th>訂單編號</th>
				<th class="esdate">訂單成立日期</th>
				<th>電影名稱</th>
				<th class="startdate">開演日期</th>
				<th>時間</th>
				<th>廳位</th>
				<th>張數</th>
				<th>取票方式</th>
				<th>取票狀態</th>
				<th class="moredetails">查看詳情</th>
				
			</tr>

<%! Integer currentPage; 
BookingService bookingSvc= new BookingService();
%>
			
<% List<Booking> bookings =(List<Booking>)request.getAttribute("bookings");


     
if(request.getAttribute("page") == null){
    currentPage = 1;
    if(bookings==null){
  	  bookings = bookingSvc.mgmGetAllBookings(currentPage,"",-1,"");
  	  
  }
   
	   
} else {
    currentPage = (Integer) request.getAttribute("page");
    
}
			

		 
		if (bookings != null&& !bookings.isEmpty()) {
		    for (Booking booking : bookings) {
		        int count = 0;
		        Set<OrderItem> orderItems = booking.getOrderItem();
		        for (OrderItem item : orderItems) {
		            count++;
		        }
		    %>
        <tr>
            <td><%= booking.getMem()!= null ? booking.getMem().getMemId() : "" %></td>

            <td><%= booking.getBookingNo() %></td>
            <td><%= booking.getBookingDate() %></td>
            <td><%= booking.getShowtimeInfo().getMovie().getMovieName() %></td>
            <td><%= booking.getShowtimeInfo().getPlaydate() %></td>
            <td><%= booking.timeformat(booking)%></td>
            <td><%= booking.getScreen().getScreenId() %></td>
            <td><%= count %>張</td>
            <td><%= booking.getBookingStatus()%></td>
            <td><%= booking.getPickupOption() %></td>
            <td>
             
                    <form action="<%= request.getContextPath() %>/MgmBookingController" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="moreDetails">
                        <input type="hidden" name="bookingNo" value="<%= booking.getBookingNo() %>">
                        <button type="submit" class="btn">查看詳情</button>
                    </form>
                
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
int pageQty = totalPageObj != null ? (Integer)totalPageObj : bookingSvc.getTotalOfBookings();

%>


<div class="button-container">
    <% for(int i=1; i<=pageQty; i++) { %>
        <a id="link<%=i%>" href="<%=request.getContextPath()%>/MgmBookingController?action=listAll&currentPage=<%=i%>">
            <button type="button" class="custom-btn btn-16 <%= i == currentPage ? "active" : "" %>"><%=i%></button>
        </a>
    <% } %>
</div>



	<!-- ========================主區 container 結束標籤======================== -->



<script src="<%=request.getContextPath() %>/back_end/jq/jq.js"></script>

<script>
    $(document).ready(function() {
      
        $('.custom-btn').click(function(event) {
           


            $('.custom-btn').removeClass('active');
     
            $(this).addClass('active');

           
            var currentPage = $(this).text();
          

           
        });
    });
    
    //全部按鈕
    function redirect() {
    	                 //呼叫到 portNo
        var dynamicPath = window.location.origin + window.location.pathname.replace(/\/[^/]*$/, '');
        if (!dynamicPath.endsWith("/back_end/booking")) {
            dynamicPath += "/back_end/booking";
        }
        dynamicPath += "/bookingSearch.jsp";
        window.location.href = dynamicPath;
    }

  
</script>	


<script>



document.addEventListener("DOMContentLoaded", function() {
   var pickupOption = document.getElementById("pickupOption");
   var bookingNo=document.getElementById("bookingNo");
   var storeNo=sessionStorage.getItem("selectedNo");
   var bookingDate=document.getElementById("bookingDate");
   
   var storeDate=sessionStorage.getItem("bookingDate");
   
   if(storeDate){
	   
	   bookingDate.value=storeDate;
   }
   
   bookingDate.addEventListener("change",function(){
	   
	   sessionStorage.setItem("bookingDate",bookingDate.value);
	   
   });
   
   
   if(storeNo){
	   bookingNo.value=storeNo;
	   
   }
   // 當頁面加載時，設置 select 元素的值為 sessionStorage 中存儲的值（如果存在的話）
   var storedValue = sessionStorage.getItem("selectedOption");
  
   if (storedValue) {
       pickupOption.value = storedValue;
   }
   
   bookingNo.addEventListener("input",function(){
	   
	   sessionStorage.setItem("selectedNo",bookingNo.value);
	
	   
	   checkpage();
	   
   });

   // 監聽 select 元素的改變事件
   pickupOption.addEventListener("change", function() {
       // 將選擇的值存儲在 sessionStorage 中
       sessionStorage.setItem("selectedOption", pickupOption.value);
       
       // 在這裡更新按鈕的鏈接
       checkpage();
   });

   // 頁面載入時執行一次更新按鈕鏈接的函數
   checkpage();
});

//定義 checkpage 函數
function checkpage() {
   var buttonCount = <%= pageQty %>;
   var selectedBookingNo = document.getElementById("bookingNo").value;
   var pickupOption = sessionStorage.getItem("selectedOption");
  var bookingDate=sessionStorage.getItem("bookingDate");
    console.log(bookingDate);
   // 循环为每个按钮设置链接
   for (var i = 1; i <= buttonCount; i++) {
       // 獲取頁數每個按鈕的ID
       var buttonId = "link" + i;

       // 綁定按鈕
       var buttonElement = document.getElementById(buttonId);

       // 构建当前按钮的链接
       var link;
       if (selectedBookingNo !== "" &&bookingDate===null) {  //如果有填訂單號碼 表示唯獨一筆 所以頁數只放訂單編號參數
           link = '<%=request.getContextPath()%>/MgmBookingController?action=listAll&pickupOption=' + pickupOption+'&bookingNo=' + selectedBookingNo + '&currentPage=' + i;
       }else if(selectedBookingNo !== "" &&bookingDate!==null) {
    	   link = '<%=request.getContextPath()%>/MgmBookingController?action=listAll&pickupOption=' + pickupOption+'&bookingNo=' + selectedBookingNo +'&bookingDate=' + bookingDate + '&currentPage=' + i;
        }else if(pickupOption!==null &&bookingDate===null){   //如果有取票方式 但是沒有選日期
           link = '<%=request.getContextPath()%>/MgmBookingController?action=listAll&pickupOption=' + pickupOption + '&currentPage=' + i;
       }else if(bookingDate!==null && pickupOption!==null){    //如果選了日期 也選了取票方式
           link= '<%=request.getContextPath()%>/MgmBookingController?action=listAll&pickupOption=' + pickupOption+'&bookingDate=' + bookingDate + '&currentPage=' + i;
       }else if(bookingDate!==null && pickupOption===null){   //選日期 但不選取票\
    	   link= '<%=request.getContextPath()%>/MgmBookingController?action=listAll&bookingDate=' + bookingDate + '&currentPage=' + i;
    	   
       }else{                                                  //全部都不選
    	   link = '<%=request.getContextPath()%>/MgmBookingController?action=listAll&currentPage=' + i;
    	   
       }

       // 设置当前按钮的链接
       buttonElement.setAttribute("href", link);
   }
}


let selectAll=document.getElementsByClassName("all")[0];


selectAll.addEventListener("click",function(){
	
	
	sessionStorage.clear();
});
</script>
</body>
</html>
