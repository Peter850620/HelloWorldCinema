<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>

</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
		<div class="main" id="main">
			<div align="center">		
				<a href="<%= request.getContextPath() %>/front/message.do?action=getMem&mem=240001">回主頁</a>
				<h3><b>所有欄位皆為必填欄位</b></h3>
				<div class="title">
				<label for="msgId">通知編號:</label>
				<input id ="msgId" name="msgId" type="text" value="${param.msgId}" style="border:0px ; font-weight: bold;" readonly />
				</div>

				<!-- 用js將timestamp型態轉換 -->
				<div class="title">
				<label for="msgTime">通知日期:</label>
				<input id ="msgTime" class="timeItem" name="msgTime" type="text" value="${param.msgTime}" style="border:0px ; font-weight: bold;" readonly />
				</div>
				
	            <div class="title">
				<label for="msgStatus" class="statusLabel">通知狀態:</label>
				<input id ="msgStatus" name="msgStatus" type="text" value="${param.msgStatus}" style="border:0px ; font-weight: bold;" readonly />
				<span  id ="msgStatus.errors" class="error">${errorMsgs.msgStatus}</span>
				</div>
				
				<div class="title">
				<label for="msgTitle">通知標題:</label>
				<textarea id ="msgTitle" name="msgTitle" style="border:0px ; font-weight: bold; width: 300px; height: 100px; resize: vertical;" readonly>${param.msgTitle}</textarea>
				<span  id ="msgTitle.errors" class="error">${errorMsgs.msgTitle}</span>
				</div>
				
				<div class="title">
				<label for="msgDetail">通知內容:</label>
				<textarea id ="msgDetail" name="msgDetail" style="border:0px ; font-weight: bold; width: 300px; height: 100px; resize: vertical;" readonly>${param.msgDetail}</textarea>
				<span  id ="msgDetail.errors" class="error">${errorMsgs.msgDetail}</span>
				</div>
				
			</div>
		</div>
	</div>





<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>

    <!-- 主要js -->
    <script src="./js/index.js"></script>
    <script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
    
</body>
</html>