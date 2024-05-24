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
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h3 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .title {
            margin-bottom: 20px;
        }

        .title label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .title input, .title select {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .title textarea {
        	width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            height: 200px;
            resize: none;
        }

        .title input[readonly], .title textarea[readonly] {
            background-color: #e9ecef;
        }

        .title .error {
            color: red;
            font-size: 12px;
        }

        .form-actions {
            text-align: center;
        }

        .form-actions button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-actions button:hover {
            background-color: #0056b3;
        }

        a {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }
		
		
	</style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div class="xxx" id="xxx">
	<form action="<%= request.getContextPath() %>/front/review.do" method="post" id="myForm">
		<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&mem=1">回主頁</a>
		<div class="title">
			<label for="reviewId">評論編號:</label>
			<input id ="reviewId" name="reviewId" type="text" value="${param.reviewId}" readonly />
		</div>
		<div class="title">
			<label for="mem">會員編號:</label>
			<input id ="mem" name="mem" type="text" value="${param.mem}" readonly />
		</div>
		<div class="title">
			<label for="movie">電影編號:</label>
			<input id ="movie" name="movie" type="text" value="${param.movie}" readonly />
		</div>
		<div class="title">
			<label for="reviewDate">評論日期:</label>
			<input id ="reviewDate" name="reviewDate" type="text" value="${param.reviewDate}" readonly />
		</div>
        <div class="title">
			<label for="reviewStatus" class="statusLabel">評論狀態:</label>
			<select id="reviewStatus" name="reviewStatus">
		        <option value="顯示" ${"顯示" == param.reviewStatus ? 'selected' : ''}>顯示</option>
		        <option value="隱藏" ${"隱藏" == param.reviewStatus ? 'selected' : ''}>隱藏</option>
		    </select>
			<span  id ="reviewStatus.errors" class="error">${errorMsgs.reviewStatus}</span>
		</div>
		<div class="title">
			<label for="reviewDetails">評論內容:</label>
			<textarea id ="reviewDetails" name="reviewDetails" readonly>${param.reviewDetails}</textarea>
			<span  id ="reviewDetails.errors" class="error">${errorMsgs.reviewDetails}</span>
		</div>
		<div class="form-actions">
			<input  type="hidden" name="action" value="update">
			<input type="hidden" name="reviewDate" value="${param.reviewDate}" id="newTime">
			<button type="submit" id="submit"> 送出修改 </button>
		</div>
	</form>
</div>

<!-- ========================以上區域可放置其他內容======================== -->
	<%@ include file="../index/indexFooter.jsp" %>
	<!-- 主要js -->
	<script src="<%= request.getContextPath() %>/js/index.js"></script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
	        var reviewDateInput = document.getElementById("reviewDate");
	        var reviewDateValue = reviewDateInput.value;
	        
	        if (reviewDateValue) {
	            var date = new Date(reviewDateValue);
	            var formattedDate = date.toISOString().slice(0, 19).replace('T', ' ');
	            reviewDateInput.value = formattedDate;
	        }
	    });
	</script>
</body>
</html>