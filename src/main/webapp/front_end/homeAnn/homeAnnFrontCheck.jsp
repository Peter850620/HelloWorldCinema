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
 	<div class="xxx" id="xxx">
 		<div class="main">
 			<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getAll">回首頁</a>
	 		<div class="time"><time>${param.annTime}</time></div>
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
    
</body>
</html>