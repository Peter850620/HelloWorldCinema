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

        .main {
            max-width: 800px;
            background-color: white;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .title {
            margin-bottom: 20px;
        }

        .title label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .title input, .title textarea {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            background-color: #f4f4f4;
        }

        .title input[readonly], .title textarea[readonly] {
            background-color: #e9ecef;
        }

        .title textarea {
            height: 150px;
            resize: none; /* 禁止 textarea 调整大小 */
        }

        .title .error {
            color: red;
            font-size: 12px;
        }

        .form-actions {
            text-align: center;
        }

        .form-actions a {
            text-decoration: none;
            color: #007bff;
            margin-right: 20px;
            font-weight: bold;
        }

        .form-actions a:hover {
            text-decoration: underline;
        }
	</style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
		<div class="main" id="main">
			<a href="<%= request.getContextPath() %>/front/message.do?action=getMem&mem=240001">回主頁</a>
			<div class="title">
				<label for="msgId">通知編號:</label>
				<input id ="msgId" name="msgId" type="text" value="${param.msgId}" readonly />
			</div>
			<div class="title">
				<label for="msgTime">通知日期:</label>
				<input id ="msgTime" name="msgTime" type="text" value="${param.msgTime}" readonly />
			</div>
            <div class="title">
				<label for="msgStatus" class="statusLabel">通知狀態:</label>
				<input id ="msgStatus" name="msgStatus" type="text" value="${param.msgStatus}" readonly />
				<span  id ="msgStatus.errors" class="error">${errorMsgs.msgStatus}</span>
			</div>
			<div class="title">
				<label for="msgTitle">通知標題:</label>
				<textarea id ="msgTitle" name="msgTitle" readonly>${param.msgTitle}</textarea>
				<span  id ="msgTitle.errors" class="error">${errorMsgs.msgTitle}</span>
			</div>
			<div class="title">
				<label for="msgDetail">通知內容:</label>
				<textarea id ="msgDetail" name="msgDetail" readonly>${param.msgDetail}</textarea>
				<span  id ="msgDetail.errors" class="error">${errorMsgs.msgDetail}</span>
			</div>
		</div>
	</div>
<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>

    <!-- 主要js -->
    <script src="./js/index.js"></script>
    <script>
	    document.addEventListener("DOMContentLoaded", function() {
	        var msgTimeInput = document.getElementById("msgTime");
	        var msgTimeValue = msgTimeInput.value;
	        
	        if (msgTimeValue) {
	            var date = new Date(msgTimeValue);
	            var formattedDate = date.toISOString().slice(0, 19).replace('T', ' ');
	            msgTimeInput.value = formattedDate;
	        }
	    });
    </script>
</body>
</html>