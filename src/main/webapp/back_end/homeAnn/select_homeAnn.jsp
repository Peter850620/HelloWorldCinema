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
		<form method="post" action="<%= request.getContextPath() %>/back/homeAnn.do" class="formSearch">
			<input type="text" name="annId" id="annIdInput" placeholder="公告編號" value="${annId}">
			
			<input type="text" name="annTitle" id="annTitleInput" placeholder="公告標題" value="${annTitle}">

			
			<input type="hidden" name="action" value="compositeQuery">
			
			<input type="submit" value="查詢">
			<button onclick="clearSearch(event)" class="clear">清空</button>
		</form>
		
	</div>
	
	<div class="main" id="main">
		<a href="<%= request.getContextPath() %>/back_end/management.jsp" style="color: white;">回主頁</a>
		<a href="<%= request.getContextPath() %>/back_end/homeAnn/addHomeAnn.jsp" style="color: white;">新增公告</a>
		<div class="container">
		        <table>
		            <thead>
		                <tr>
		                    <th>公告編號</th>
		                    <th>發布時間</th>
		                    <th>公告標題</th>
		                    <th>公告內容</th>
		                </tr>
		            </thead>
		            <tbody>
		            	<c:forEach var="homeAnn" items="${homeAnnList}">
							<tr>
								<td>${homeAnn.annId}</td>
								<td>${homeAnn.annTime}</td>
								<td>${homeAnn.annTitle}</td>
								<td>
								  <form method="post" action="<%= request.getContextPath() %>/back/homeAnn.do" class="formPost" style="margin-bottom: 0px;">
								     <input type="submit" value="查看">
								     <input type="hidden" name="annId" value="${homeAnn.annId}">
								     <input type="hidden" name="action"	value="getUpdate">
							     </form>
								</td>
							</tr>
						</c:forEach>
		            </tbody>
		        </table>
		        <c:if test="${currentPage > 1}">
					<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll&page=1" style="color: white;">至第一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage - 1 != 0}">
					<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll&page=${currentPage - 1}" style="color: white;">上一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage + 1 <= homeAnnPageQty}">
					<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll&page=${currentPage + 1}" style="color: white;">下一頁</a>&nbsp;
				</c:if>
				<c:if test="${currentPage != homeAnnPageQty}">
					<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll&page=${homeAnnPageQty}" style="color: white;">至最後一頁</a>&nbsp;
				</c:if>
		       
	    	</div>
	
		</div>
		
		
	
	
	</div>
    
<script src="<%= request.getContextPath() %>/back_end/management.js"></script>
<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
 
	

<script>



</script>

</body>


</html>