<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
     	body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        .main {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            text-align: center;
        }

        h3 {
            color: #555;
            margin-top: 20px;
        }

        .aboutus_main p {
            color: #666;
            margin: 10px 0;
        }

        .aboutus_main p:first-child {
            margin-top: 0;
        }

        hr {
            border: 0;
            height: 1px;
            background: #ddd;
            margin: 20px 0;
        }
    </style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
    <div class="main" id="main">
    	<h1>影城交通</h1>
        <hr>
		<div class="aboutus_main">
			<h3>服務專線</h3>
			<p>(03) 425-1108</p>
			<h3>影城地址：</h3>
			<p>320桃園市中壢區復興路46號9樓</p>
			<h3>交通資訊：</h3>
			<p>－台鐵：中壢車站站，從中壢火車站前站出口，步行約10分鐘即抵</p>
			<p>－公車︰可搭乘公車或客運至「中壢車站」站下車</p>
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