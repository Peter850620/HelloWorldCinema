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
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            margin-left: 100px;
            color: #333;
        }

        .compositequery {
            margin: 20px 100px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .compositequery input[type="text"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 60%;
            margin-right: 10px;
        }

        .compositequery input[type="submit"],
        .compositequery .clear {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        .compositequery .clear {
            background-color: #6c757d;
        }

        .compositequery a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        
        .formSearch {
        	width: 70%;
        }

        .container {
            margin: 20px 100px;
        }

        .container-list {
            list-style-type: none;
            padding: 0;
        }

        .content_article {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .content_article time {
            font-size: 14px;
            color: #6c757d;
        }

        .content_article a {
            text-decoration: none;
            color: #007bff;
            font-size: 20px;
            font-weight: bold;
        }

        .content_article hr {
            border: 0;
            border-top: 1px solid #eee;
            margin: 20px 0;
        }

        .page {
            text-align: center;
            margin: 20px 0;
        }

        .page a {
            text-decoration: none;
            color: #007bff;
            margin: 0 5px;
        }
	</style>
</head>
<body>

<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
 	<div class="xxx" id="xxx">
 		<h1>影城公告</h1>
 		<div class="compositequery">
			<form method="post" action="<%= request.getContextPath() %>/front/homeAnn.do" class="formSearch">
				<input type="text" name="annTitle" id="annTitleInput" placeholder="公告標題" value="${annTitle}">
				<input type="hidden" name="action" value="compositeQuery">
				<input type="submit" value="查詢">
				<button onclick="clearSearch(event)" class="clear">清空</button>
			</form>
			<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getAll">所有公告</a>
		</div>
		<div class="container">
			<ul class="container-list" id="container-list">
	 			<c:forEach var="homeAnn" items="${homeAnnList}">
	 				<li>
 						<article class="content_article">
	 						<time class="timeItem">${homeAnn.annTime}</time>
							<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=getHomeAnn&annId=${homeAnn.annId}">${homeAnn.annTitle}</a>
	 						<hr>
 						</article>
	 				</li>
	 			</c:forEach>
 			</ul>
 			<div class="page">
 				<c:if test="${currentPage > 1}">
					<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=${action}&page=1&annId=${convertedMap.annId}&annTitle=${convertedMap.annTitle}">至第一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage - 1 != 0}">
					<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=${action}&page=${currentPage - 1}&annId=${convertedMap.annId}&annTitle=${convertedMap.annTitle}">上一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage + 1 <= homeAnnPageQty}">
					<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=${action}&page=${currentPage + 1}&annId=${convertedMap.annId}&annTitle=${convertedMap.annTitle}">下一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage != homeAnnPageQty}">
					<a href="<%= request.getContextPath() %>/front/homeAnn.do?action=${action}&page=${homeAnnPageQty}&annId=${convertedMap.annId}&annTitle=${convertedMap.annTitle}">至最後一頁</a>&nbsp;
				</c:if>
 			</div>
		</div>
 		
	</div>
<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    <script>
    function clearSearch(event) {
    	event.preventDefault();
    	
    	document.getElementById('annTitleInput').value = '';
    }
    
    document.addEventListener('DOMContentLoaded', () => {
        const homeAnnBody = document.getElementById('container-list');
        const items = Array.from(homeAnnBody.getElementsByTagName('li'));

        items.forEach(item => {
            const dateCell = item.querySelector('.timeItem');
            const date = new Date(dateCell.textContent.trim());
            const options = {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: false
            };
            dateCell.textContent = date.toLocaleString('zh-TW', options);
        });

        items.sort((a, b) => b.homeAnnTimeValue - a.homeAnnTimeValue); 

        items.forEach(item => homeAnnBody.appendChild(item));
    });
    </script>
</body>
</html>