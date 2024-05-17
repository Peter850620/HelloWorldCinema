<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>世界影城</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/management.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
        
        .formSearch {
            margin: 20px auto;
            padding: 20px;
            width: 110%;
            border-radius: 25px;
            justify-content: center;
            padding: 100px;
            background-color: rgb(0 0 0/ 60%);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            left: 150px;
            border: 2px solid white;
            margin-left: 80px;
            font-size: 25px;
            color:white;
            
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

        .main{
        	margin: 20px auto;
            padding: 20px;
            width: 110%;
            border-radius: 25px;
            justify-content: center;
            padding: 100px;
            background-color: rgb(0 0 0/ 60%);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            left: 150px;
            border: 2px solid white;
            margin-left: 80px;
            font-size: 25px;
            color:white; 
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


	<!-- ====================這是main==================== -->
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
	
	<div class="main" id="main">
		<a href="<%= request.getContextPath() %>/back_end/management.jsp" style="color: white;">回主頁</a>
		<a href="<%= request.getContextPath() %>/back_end/review/addReview.jsp" style="color: white;">新增討論區</a>
		<a href="<%= request.getContextPath() %>/back/review.do?action=getAll" style="color: white;">所有評論</a>
		<a href="<%= request.getContextPath() %>/back/report.do?action=getAll" style="color: white;">檢舉審核</a>
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
								  <form method="post" action="<%= request.getContextPath() %>/back/review.do" class="formPost" style="margin-bottom: 0px;">
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
					<a href="<%= request.getContextPath() %>/back/review.do?action=getAll&page=1" style="color: white;">至第一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage - 1 != 0}">
					<a href="<%= request.getContextPath() %>/back/review.do?action=getAll&page=${currentPage - 1}" style="color: white;">上一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage + 1 <= reviewPageQty}">
					<a href="<%= request.getContextPath() %>/back/review.do?action=getAll&page=${currentPage + 1}" style="color: white;">下一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage != reviewPageQty}">
					<a href="<%= request.getContextPath() %>/back/review.do?action=getAll&page=${reviewPageQty}" style="color: white;">至最後一頁</a>&nbsp;
				</c:if>
	    	</div>
	
		</div>
		
		
	
	
	</div>
    
<script src="<%= request.getContextPath() %>/js/management.js"></script>
<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
 
	

<script>
function clearSearch(event) {
	event.preventDefault();
	
	document.getElementById('reviewIdInput').value = '';
	document.getElementById('memIdInput').value = '';
    document.getElementById('movieIdInput').value = '';
    document.getElementById('reviewStatusSelect').value = '顯示';
    
    
    document.querySelector('form').submit();
}


</script>

</body>


</html>