<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
        }

        .main {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            text-align: center;
        }

        .ticket_container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .ticket_price {
            flex: 0 1 calc(50% - 20px);
            background-color: #f0f0f0;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        .ticket_price h2 {
            color: #333;
            margin-top: 0;
        }

        .ticket_price p {
            color: #666;
            margin-bottom: 10px;
        }
        
        .ticket_price .price_show {
        	color: red;
        }
    </style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
    <div class="main" id="main">
    	<h1>票價說明</h1>
        <hr>
		<div class="ticket_container">
	        <div class="ticket_price">
	            <h1>全票</h1>
	            <p class="price_show">價格:300元</p>
	            <p></p>
	        </div>
	        <br>
	        <div class="ticket_price">
	            <h1>優待票</h1>
	            <p class="price_show">價格:250元</p>
	            <p>兒童、學生、軍警身分之觀眾，出示本人有效相關優待證件。</p>
	        </div>
	        <br>
	        <div class="ticket_price">
	            <h1>愛心票</h1>
	            <p class="price_show">價格:200元</p>
	            <p>身心障礙朋友，出示本人有效身心障礙手冊(證件)。</p>
	        </div>
	        <br>
	        <div class="ticket_price">
	            <h1>敬老票</h1>
	            <p class="price_show">價格:200元</p>
	            <p>六十五歲以上年長者，出示可證明年齡之證件。</p>
	        </div>
	        <br>
	        <div class="ticket_price">
	            <h1>預售票本</h1>
	            <p class="price_show">價格:5000元</p>
	            <p>每本預售票本內均含20張優惠劵。</p>
	        </div>
    	</div>

	</div>
</div>

<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    <script>
	
    </script>
</body>
</html>