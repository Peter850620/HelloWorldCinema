<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>結帳頁面</title>
<style>


.container {
  
    padding: 20px;
    border-radius: 10px;
  padding:50px;
    width: 500px;
    margin: 20px auto;
   background-color: rgb(0 0 0/ 60%);
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-left:450px;
    margin-top:50px;
    
}

.container h2 {
    text-align: center;
    color:red;
}

.container form {
    display: flex;
    flex-direction: column;
}

.container form div {
    display: flex;
    flex-direction: column;
    margin-bottom: 15px;
    color:white;
    
}

.container form label {
    margin-bottom: 8px;
    font-size: 15px;
    font-weight: bold;
}

.container form input[type="text"],
.container form input[type="number"],
.container form select {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    margin-bottom: 10px;
}

.container form input[type="submit"] {
    background-color: #4caf50;
    color: #fff;
    cursor: pointer;
    height:30px;
    margin-bottom: 5px;
    font-size: 20px;
}

.container form input[type="submit"]:hover {
    background-color: #45a049;
}
</style>
</head>
<body>

<jsp:include page="../management.jsp" />
<div class="container">
    <h2>結帳明細</h2>
    <form id="checkout-form" action="<%=request.getContextPath() %>/BookingController"  method="post"  >
        <!-- 上半部分 -->
        
        <% ShowtimeInfo show =(ShowtimeInfo) session.getAttribute("whichShow"); %>
      
        <div>
            <input type="hidden" name="showId" value=<%=show.getShowtimeId()%>>
            <label for="session-date">場次日期:</label>
            <input type="text" id="session-date" readonly name="platdate" value=<%=show.getPlaydate()%>>

            <label for="session-time">場次時間:</label>
            <input type="text" id="session-time" readonly name="platdate" value=<%=show.getShowtime() %>>

            <label for="theater-number">影廳編號:</label>
            <input type="text" id="theater-number" readonly  name="screenId" value=<%=show.getScreen().getScreenId()%>>
           
            
            <label for="movie-name">電影名字:</label>
            <input type="text" id="movie-name" readonly  name="movieName" value=<%=show.getMovie().getMovieName()%>>

            <label for="seatNo">座位:</label>
            <input type="text" id="seatNo" readonly  name="seatNo" >
            
            <label for="tkId1">全票:</label>
            <input type="number" id="tkId1" name="tkId1" readonly >

            <label for="tkId2">優待票:</label>
            <input type="number" id="tkId2" name="tkId2" readonly>

            <label for="tkId3">愛心票:</label>
            <input type="number" id="tkId3" name="tkId3"readonly>

            <label for="tkId4">敬老票:</label>
            <input type="number" id="tkId4"  name="tkId4" readonly>

            <label for="movieTotal">電影金額:</label>
            <input type="number" id="movieTotal" readonly name="movieTotal">
        </div>
     
        <!-- 下半部分 -->
        <div>
            <h2>餐點加購</h2>
            
            
         

            <label for="foodTotal">食物金額:</label>
            <input type="number" id="foodTotal" readonly  name="foodTotal">

            <label for="total">總金額:</label>
            <input type="number" id="total" readonly name="total">

            <h2>選擇付款方式</h2>
            <input type="hidden" id="paymentType" name="paymentType" value="">
            <input type="submit" name="payment" value="現金">
            <input type="submit" name="payment" value="刷卡">
            
            <input type="hidden" name="action" value="bookingSuccess">
        </div>
    </form>
</div>

<script type="text/javascript"  src="./payment.js"></script>

</body>
</html>
