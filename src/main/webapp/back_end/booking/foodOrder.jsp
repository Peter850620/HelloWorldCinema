<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/back_end/booking/foodOrder.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    
    
</head>


<body >


<jsp:include page="../management.jsp" />


   
 <div class="all_area">

    <div class="container">
        <header>
            <h1>美食加購區</h1>
            <div class="shopping">
                <i class='bx bx-cart'></i>
                <span class="quantity">0</span>
            </div>
        </header>

        <div class="list">
          
        </div>
    </div>

    <form action="#" method="post">
      <div class="card">
        <h1>購物車</h1>
        <ul class="listCard">
        </ul>
        <div class="checkOut">
            <div class="total">0</div>
            <a href="./payment.jsp">
            <button type="button" class="payforcart">結帳</button>
            </a>
        </div>
     </div>

    </form>

</div>   
    <script src="<%=request.getContextPath() %>/back_end/booking/foodOrder.js"></script>

</body>
</html>