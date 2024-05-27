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
            margin-bottom: 20px;
        }

        h3 {
            color: #555;
            margin: 0;
        }

        .aboutus_main ul {
            padding: 0;
            list-style: none;
        }

        .aboutus_main li {
            background-color: #f9f9f9;
            margin-bottom: 10px;
            padding: 15px;
            border-left: 4px solid #007BFF;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .aboutus_main li h3 {
            margin: 0;
            font-size: 1.1em;
            color: #007BFF;
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
    	<h1>注意事項</h1>
        <hr>
		<div class="aboutus_main">
			<ul>
				<li><h3>電影票皆有使用期限，購買前可先詢問。</h3></li>
				<br>
				<li><h3>本賣場票券為專案採購，載明之票面價值，不等同於本賣場零售價，無法接受者請勿購買。</h3></li>
				<br>
				<li><h3>如有退貨問題須於鑑賞期內聯絡原購買單位，逾鑑賞期恕不受理。</h3></li>
				<br>
				<li><h3>文案內容之圖片僅供參考，實際影廳狀況依現場為主。</h3></li>
				<br>
			</ul>
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