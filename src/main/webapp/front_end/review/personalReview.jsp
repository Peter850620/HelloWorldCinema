<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
        .main{
            height: 800px;
            background-color: aliceblue;
            margin-left: 101.852px;
            margin-right: 101.863px;
        }
        .review_container{
            background-color: aliceblue;
        }

        .review_head{
            margin-left: 101.853px;
            color: blueviolet;
        }

        table {
		    border-collapse: collapse;
		    width: 100%; 
		    border: 2px solid white;
		}
		
		th, td {
		    border: 1px solid white;
		    padding: 8px;
		    text-align: left; 
		}
    </style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
    <div class="main" id="main">
        <div class="review_head">
            <a href="<%= request.getContextPath() %>/front-end/review/reviewFront.jsp">回會員中心</a>
            <a href="<%= request.getContextPath() %>/front/review.do?action=getMem&mem=240001">所有評論</a>
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
	            <tbody>
	            	<c:forEach var="review" items="${reviewList}">
						<tr>
							<td>${review.reviewId}</td>
							<td>${review.movie.movieId}</td>
							<td>${review.reviewDate}</td>
							<td>${review.reviewStatus}</td>
							<td>
							  <form method="post" action="<%= request.getContextPath() %>/front/review.do" class="formPost" style="margin-bottom: 0px;">
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
				<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&page=1" style="color: blue;">至第一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage - 1 != 0}">
				<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&page=${currentPage - 1}" style="color: blue;">上一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage + 1 <= reviewPageQty}">
				<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&page=${currentPage + 1}" style="color: blue;">下一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage != reviewPageQty}">
				<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&page=${reviewPageQty}" style="color: blue;">至最後一頁</a>&nbsp;
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