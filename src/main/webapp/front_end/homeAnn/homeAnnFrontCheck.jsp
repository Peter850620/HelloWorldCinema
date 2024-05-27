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
        }

        .xxx {
            background-color: white;
            max-width: 900px;
            height:500px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .main {
            padding: 20px;
        }

        .main a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 20px;
        }

        .time {
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .container {
            text-align: center;
        }

        .container h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        .content {
            font-size: 18px;
            color: #555;
            line-height: 1.6;
            text-align: left;
        }

        .content p {
            margin: 0;
        }
	</style>
</head>
<body>

<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
 	<div class="xxx" id="xxx">
 		<div class="main">
 			<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getAll">回首頁</a>
			<time id="timeItem">${param.annTime}</time>
	 		<div class="container">
				<h1>${param.annTitle}</h1>
				<div class="content">
					<p>${param.annDetail}</p>
				</div> 		
	 		</div>
 		</div>
	</div>
<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    <script>
	    document.addEventListener('DOMContentLoaded', () => {
	        const annTimeElement = document.getElementById('timeItem');
	        const annTimeValue = annTimeElement.textContent;
	        const formattedTime = new Date(annTimeValue).toISOString().slice(0, 19).replace('T', ' ');
	        annTimeElement.textContent = formattedTime;
	    });
    </script>
</body>
</html>