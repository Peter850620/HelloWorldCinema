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
            padding: 20px;
            width: 100%;
            border-radius: 25px;
            justify-content: center;
            padding: 100px;
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

        button {
            background-color: grey;
            border-radius: 15px;
            background-color: rgba(162, 161, 167, 0.5);
            font-size: 30px;
            width: 150px;
            
            cursor:pointer;
            transition-duration: 0.5s;
            color: white;
        }

        button:hover {
        	background-color: rgba(87, 87, 89, 0.8);
        }


        input[type="submit"] {
	        background-color: grey;
	        border-radius: 15px;
	        background-color: rgba(162, 161, 167, 0.5);
	        font-size: 30px;
	        width: 150px;
	        
	        cursor:pointer;
	        transition-duration: 0.5s;
	        color: white;
        }

        input[type="submit"]:hover {
            background-color: rgba(87, 87, 89, 0.8);
        }

        .mainIndex{
        	margin: 20px auto;
            padding: 20px;
            width: 100%;
            border-radius: 25px;
            justify-content: center;
            padding: 100px;
            background-color: rgb(0 0 0/ 60%);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            left: 150px;
            border: 2px solid white;
            margin-left: 0px;
            font-size: 25px;
            color:white; 
        }
        
        .mainIndex a{
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
				
				<input type="hidden" name="action" value="compositeQuery">
				
				<input type="submit" value="查詢">
				<button onclick="clearSearch(event)" class="clear">清空</button>
			</form>
			
		</div>
		
		<div class="mainIndex" id="mainIndex">
			<a href="<%= request.getContextPath() %>/back_end/management.jsp">回主頁</a>
			<a href="<%= request.getContextPath() %>/back/review.do?action=getAll">所有評論</a>
			<a href="<%= request.getContextPath() %>/back/report.do?action=getAll">檢舉審核</a>
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
			            <tbody>
			            	<c:forEach var="review" items="${reviewList}">
								<tr>
									<td>${review.reviewId}</td>
									<td>${review.mem.memId}</td>
									<td>${review.movie.movieId}</td>
									<td>${review.reviewDate}</td>
									<td>${review.reviewStatus}</td>
									<!-- <td><button class="btn_check" onclick="showDetail(${review.reviewId})" type="button">查看</button></td> -->
									<!-- <td>${review.movie.movieId}-[${review.movie.movieName}]</td> -->
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
			        <c:if test="${currentPage > 1}">
						<a href="<%= request.getContextPath() %>/back/review.do?action=getAll&page=1">至第一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage - 1 != 0}">
						<a href="<%= request.getContextPath() %>/back/review.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage + 1 <= reviewPageQty}">
						<a href="<%= request.getContextPath() %>/back/review.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage != reviewPageQty}">
						<a href="<%= request.getContextPath() %>/back/review.do?action=getAll&page=${reviewPageQty}">至最後一頁</a>&nbsp;
					</c:if>
		    	</div>
			</div>

	</div>
    
<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
 
	

<script>
function clearSearch(event) {
	event.preventDefault();
	
	document.getElementById('reviewIdInput').value = '';
	document.getElementById('memIdInput').value = '';
    document.getElementById('movieIdInput').value = '';
    document.getElementById('reviewStatusSelect').value = '顯示';
}


</script>

</body>


</html>