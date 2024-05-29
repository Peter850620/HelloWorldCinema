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
            max-width: 1000px;
            background-color: white;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            height: 550px;
        }

        .review_head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .review_head a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .review_head a:hover {
            text-decoration: underline;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            border: 1px solid #ccc;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: left;
            vertical-align: middle;
        }

        th {
            background-color: #f4f4f4;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            text-decoration: none;
            color: #007bff;
            margin: 0 5px;
        }

        .pagination a:hover {
            text-decoration: underline;
        }

        .formPost {
            margin: 0;
        }

        .formPost input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 4px;
        }

        .formPost input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
    <div class="main" id="main">
    	<h1>個人評論</h1>
    	<br>
        <div class="review_head">
            <a href="<%= request.getContextPath() %>/front/review.do?action=loadMovie">回主頁</a>
            <a href="<%= request.getContextPath() %>/front/review.do?action=getMem">所有評論</a>
        </div>
		
		<div class="review_container">
	        <table>
	            <thead>
	                <tr>
	                    <th>評論編號</th>
	                    <th>電影編號</th>
	                    <th>評論日期</th>
	                    <th>狀態</th>
	                    <th>評論內容</th>
	                </tr>
	            </thead>
	            <tbody id="reviewBody">
	            	<c:forEach var="review" items="${reviewList}">
						<tr>
							<td>${review.reviewId}</td>
							<td>${review.movie.movieName}</td>
							<td class="timeItem">${review.reviewDate}</td>
							<td>${review.reviewStatus}</td>
							<td>
							  <form method="post" action="<%= request.getContextPath() %>/front/review.do" class="formPost">
							     <input type="submit" value="查看">
							     <input type="hidden" name="reviewId" value="${review.reviewId}">
							     <input type="hidden" name="action"	value="getUpdate">
						     </form>
							</td>
						</tr>               
					</c:forEach>
	            </tbody>
	        </table>
	        <c:if test="${currentPage > 1}">
				<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&page=1">至第一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage - 1 != 0}">
				<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&page=${currentPage - 1}">上一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage + 1 <= reviewPageQty}">
				<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&page=${currentPage + 1}">下一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage != reviewPageQty}">
				<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&page=${reviewPageQty}">至最後一頁</a>&nbsp;
			</c:if>
	       
    	</div>

	</div>
</div>

<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    <script>
	    document.addEventListener('DOMContentLoaded', () => {
	        const reviewBody = document.getElementById('reviewBody');
	        const rows = Array.from(reviewBody.getElementsByTagName('tr'));

	        rows.forEach(row => {
	            const dateCell = row.querySelector('.timeItem');
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
	
	        rows.sort((a, b) => b.reviewDateValue - a.reviewDateValue); 

	        rows.forEach(row => reviewBody.appendChild(row));
	    });
    </script>
</body>
</html>