<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
        .xxx{
        	display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 100%;
        }
        
        .compositequery {
            margin: 20px auto;
            width: 100%;
            border-radius: 25px;
            justify-content: center;
            padding: 50px 100px;
            background-color: rgb(0 0 0/ 60%);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            left: 150px;
            border: 2px solid white;
            margin-left: 0px;
            font-size: 25px;
            color:white;
            display: flex; 
		    align-items: center; 
		    justify-content: space-between; 
        }
        
        .compositequery input[type="text"] {
            font-size: 20px;
            padding: 10px; 
            width: 200px; 
            margin-right: 10px
        }
        
        .compositequery select {
            font-size: 20px;
            padding: 10px; 
            width: 100px; 
            margin-right: 10px
        }

        button {
		    background-color: rgba(255, 240, 240, 0.5); 
		    border-radius: 15px;
		    font-size: 30px;
		    width: 150px;
		    cursor: pointer;
		    transition-duration: 0.5s;
		    color: white;
		}
		
		button:hover {
		    background-color: rgba(255, 240, 240, 0.8); 
		}

        input[type="submit"] {
	        border-radius: 15px;
	        background-color: red;
	        font-size: 30px;
	        width: 150px;
	        cursor:pointer;
	        transition-duration: 0.5s;
	        color: white;
        }

        input[type="submit"]:hover {
            background-color: darkred;
        }
        
        .search {
        	margin-top: 20px;
        }

        .mainIndex{
        	margin: 20px auto;
            width: 100%;
            border-radius: 25px;
            justify-content: center;
            padding: 50px 100px;
            background-color: rgb(0 0 0/ 60%);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            left: 150px;
            border: 2px solid white;
            margin-left: 0px;
            font-size: 25px;
            color:white; 
        }
        
        .review_head {
        	margin-bottom: 10px;
        }
       
        .review_head a {
        	background-color: rgb(135, 189, 250);
        	border: solid white;
        	color: white;
        }
        
        .pageChange{
			margin-top: 10px;
        }
        
        .pageChange a{
        	color: white;
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
<%@ include file="../management.jsp" %>
	<div id="xxx">
		<div class="compositequery">
			<form method="post" action="<%= request.getContextPath() %>/back/review.do" class="formSearch">
				<input type="text" name="reviewId" id="reviewIdInput" placeholder="評論編號" value="${reviewId}">
				
				<input type="text" name="mem" id="memIdInput" placeholder="會員編號" value="${mem.memId}">
	
				<input type="text" name="movie" id="movieIdInput" placeholder="電影編號" value="${movie.movieId}">
				
				<select name="reviewStatus" id="reviewStatusSelect">
					<option value="顯示">顯示</option>
					<option value="隱藏">隱藏</option>
				</select>
				<br>
				<div class="search">
					<input type="hidden" name="action" value="compositeQuery">
					<input type="submit" value="查詢">
					<button onclick="clearSearch(event)" class="clear">清空</button>
				</div>
			</form>
		</div>
		<div class="mainIndex" id="mainIndex">
			<div class="review_head">
				<a href="<%= request.getContextPath() %>/back_end/management.jsp">回主頁</a>
				<a href="<%= request.getContextPath() %>/back/review.do?action=getAll">所有評論</a>
				<a href="<%= request.getContextPath() %>/back/report.do?action=getAll">檢舉審核</a>
			</div>
			<div class="container">
		        <table>
		            <thead>
		                <tr>
		                    <th>評論編號</th>
		                    <th>會員編號</th>
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
								<td>${review.mem.memId}</td>
								<td>${review.movie.movieId}</td>
								<td class="timeItem">${review.reviewDate}</td>
								<td>${review.reviewStatus}</td>
								<td>
								  <form method="post" action="<%= request.getContextPath() %>/back/review.do" class="formPost">
								     <input type="submit" value="修改">
								     <input type="hidden" name="reviewId" value="${review.reviewId}">
								     <input type="hidden" name="action"	value="getUpdate">
							     </form>
								</td>
							</tr>
						</c:forEach>
		            </tbody>
		        </table>
		        <div class="pageChange">
		        	<c:if test="${currentPage > 1}">
						<a href="<%= request.getContextPath() %>/back/review.do?action=${action}&page=1&reviewId=${convertedMap.reviewId}&mem=${convertedMap.mem}&movieId=${convertedMap.movieId}&reviewStatus=${convertedMap.reviewStatus}">至第一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage - 1 != 0}">
						<a href="<%= request.getContextPath() %>/back/review.do?action=${action}&page=${currentPage - 1}&reviewId=${convertedMap.reviewId}&mem=${convertedMap.mem}&movieId=${convertedMap.movieId}&reviewStatus=${convertedMap.reviewStatus}">上一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage + 1 <= reviewPageQty}">
						<a href="<%= request.getContextPath() %>/back/review.do?action=${action}&page=${currentPage + 1}&reviewId=${convertedMap.reviewId}&mem=${convertedMap.mem}&movieId=${convertedMap.movieId}&reviewStatus=${convertedMap.reviewStatus}">下一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage != reviewPageQty}">
						<a href="<%= request.getContextPath() %>/back/review.do?action=${action}&page=${reviewPageQty}&reviewId=${convertedMap.reviewId}&mem=${convertedMap.mem}&movieId=${convertedMap.movieId}&reviewStatus=${convertedMap.reviewStatus}">至最後一頁</a>&nbsp;
					</c:if>
		        </div>
	    	</div>
		</div>
	</div>
<script>
	function clearSearch(event) {
		event.preventDefault();
		
		document.getElementById('reviewIdInput').value = '';
		document.getElementById('memIdInput').value = '';
	    document.getElementById('movieIdInput').value = '';
	    document.getElementById('reviewStatusSelect').value = '顯示';
	}
	
	document.addEventListener('DOMContentLoaded', () => {
	    const reviewBody = document.getElementById('reviewBody');
	    const rows = Array.from(reviewBody.getElementsByTagName('tr'));
	
	    rows.forEach(row => {
	        const dateCell = row.querySelector('.timeItem');
	        const date = new Date(dateCell.textContent.trim());
	        dateCell.textContent = date.toISOString().slice(0, 19).replace('T', ' '); 
	        row.reviewDateValue = date.getTime(); 
	    });
	    rows.sort((a, b) => b.reviewDateValue - a.reviewDateValue); 
	    rows.forEach(row => reviewBody.appendChild(row));
	    
	    getAllRequest();
	});

	function getAllRequest() {
		 $.ajax({
	            url: "<%= request.getContextPath() %>/back/review.do",
	            method: "POST",
	            data: { 
	                action: "getAll"
	            },
	            success: function(response) {
	                console.log("Request sent successfully");
	            },
	            error: function(xhr, error) {
	                console.error("An error occurred: " + error);
	            }
	        });
    }

</script>

</body>


</html>