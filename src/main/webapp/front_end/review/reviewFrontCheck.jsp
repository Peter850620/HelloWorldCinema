<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
		.xxx{
			background-color: white;
		}
	</style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
		<div class="main" id="main">
			<div align="center">		
				<form action="<%= request.getContextPath() %>/front/review.do" method="post" id="myForm">
					<a href="<%= request.getContextPath() %>/front/review.do?action=getMem">回主頁</a>
					<h3><b>所有欄位皆為必填欄位</b></h3>
					<div class="title">
					<label for="reviewId">評論編號:</label>
					<input id ="reviewId" name="reviewId" type="text" value="${param.reviewId}" style="border:0px ; font-weight: bold;" readonly />
					</div>
					
					<div class="title">
					<label for="mem">會員編號:</label>
					<input id ="mem" name="mem" type="text" value="${param.mem}"  style="border:0px ; font-weight: bold;" readonly />
					</div>
					
					<div class="title">
					<label for="movie">電影編號:</label>
					<input id ="movie" name="movie" type="text" value="${param.movie}" style="border:0px ; font-weight: bold;" readonly />
					</div>
		 
					
					<!-- 用js將timestamp型態轉換 -->
					<div class="title">
					<label for="reviewDate">評論日期:</label>
					<input id ="reviewDate" class="timeItem" name="reviewDate" type="text" value="${param.reviewDate}" style="border:0px ; font-weight: bold;" readonly />
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
					<textarea id ="reviewDetails" name="reviewDetails" style="border:0px ; font-weight: bold; width: 300px; height: 100px; resize: vertical;" readonly>${param.reviewDetails}</textarea>
					<span  id ="reviewDetails.errors" class="error">${errorMsgs.reviewDetails}</span>
					</div>
					
					<div class="title">
						<div></div>
						<input  type="hidden" name="action" value="update">
						<input type="hidden" name="reviewDate" value="${param.reviewDate}" id="newTime">
						<button type="submit" id="submit"> 送出修改 </button>
						<div></div>
					</div>
				</form>
			</div>
		</div>
	</div>





<!-- ========================以上區域可放置其他內容======================== -->
	<%@ include file="../index/indexFooter.jsp" %>
	<!-- 主要js -->
	<script src="<%= request.getContextPath() %>/js/index.js"></script>

    <script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
</body>
</html>