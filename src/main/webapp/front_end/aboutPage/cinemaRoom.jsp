<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
     	body {
           font-family: Arial, sans-serif;
           background-color: #f5f5f5;
           margin: 0;
           padding: 0;
       }
       .main {
           width: 80%;
           margin: 50px auto;
           background-color: #fff;
           padding: 20px;
           box-shadow: 0 0 10px rgba(0,0,0,0.1);
       }
       h1 {
           color: #333;
       }
       h1 {
           text-align: center;
           margin-bottom: 20px;
       }
       .room_main h2 {
           margin-top: 20px;
           border-bottom: 2px solid #333;
           padding-bottom: 5px;
           color: red;
       }
       .room_main p {
           font-size: 1.1em;
           line-height: 1.6;
           margin: 10px 0 20px 0;
       }
       hr {
           margin: 20px 0;
           border: 0;
           border-top: 1px solid #ddd;
       }
    </style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
    <div class="main" id="main">
    	<h1>影城設備</h1>
        <hr>
		<div class="room_main">
			<h2>A廳</h2>
            <p>A廳是我們的主要影廳，配備了先進的影音設備和寬敞舒適的座位。這裡舉辦各種大型電影首映和特別活動，給您帶來極致的觀影體驗。</p>
            <br>
            <h2>B廳</h2>
            <p>B廳是我們的小型影廳，提供親密的觀影體驗。</p>
            <br>
            <h2>C廳</h2>
            <p>C廳是我們的中型影廳，適合家庭觀影和小型活動。</p>
            <br>
            <h2>D廳</h2>
            <p>D廳是我們最大的影廳，擁有巨大的螢幕，提供給觀眾極致震撼的觀影體驗。</p>
            <br>
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