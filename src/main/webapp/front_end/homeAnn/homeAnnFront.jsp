<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
		.xxx{
			background-color: white;
		}
		h1{
			margin-left: 100px;
		}
		.compositequery{
			margin-left: 100px;
		}
		.container{
			margin: 0px, 100px, 0px, 100px;
		}
		
		.content_article{
			font-size: 24px;
		}
		
		.page{
			color: white;
		}
		
	</style>
</head>
<body>

<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
 	<div class="xxx" id="xxx">
 		<h1>影城公告</h1>
 		<div class="compositequery">
			<form method="post" action="<%= request.getContextPath() %>/front/review.do" class="formSearch">
				<input type="text" name="annTitle" id="annTitleInput" placeholder="公告標題" value="${annTitle}">
				<input type="hidden" name="action" value="compositeQuery">
				<input type="submit" value="查詢">
				<button onclick="clearSearch(event)" class="clear">清空</button>
			</form>
			<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getAll">所有公告</a>
		</div>
		<div class="container">
			<ul class="container-list">
	 			<c:forEach var="homeAnn" items="${homeAnnList}">
	 				<li>
 						<article class="content_article">
	 						<time>${homeAnn.annTime}</time>
							<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getHomeAnn&annId=${homeAnn.annId}">${homeAnn.annTitle}</a>
	 						<hr>
 						</article>
	 				</li>
	 			</c:forEach>
 			</ul>
 			<div class="page">
 				<c:if test="${currentPage > 1}">
					<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getAll&page=1">至第一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage - 1 != 0}">
					<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage + 1 <= homeAnnPageQty}">
					<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage != homeAnnPageQty}">
					<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getAll&page=${homeAnnPageQty}">至最後一頁</a>&nbsp;
				</c:if>
 			</div>
		</div>
 		
	</div>
<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    
</body>
</html>