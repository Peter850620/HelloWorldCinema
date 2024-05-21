<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<style>
        
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
		
		a{
			color: white;
		}
			
	
	</style>
</head>



<body>
<%@ include file="../management.jsp" %>

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
		
		<div class="mainIndex" id="mainIndex">
			<a href="<%= request.getContextPath() %>/back_end/management.jsp">回主頁</a>
			<a href="<%= request.getContextPath() %>/back_end/homeAnn/addHomeAnn.jsp">新增公告</a>
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
									  <form method="post" action="<%= request.getContextPath() %>/back/homeAnn.do" class="formPost">
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
						<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll&page=1">至第一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage - 1 != 0}">
						<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage + 1 <= homeAnnPageQty}">
						<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage != homeAnnPageQty}">
						<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll&page=${homeAnnPageQty}">至最後一頁</a>&nbsp;
					</c:if>
		    	</div>
			</div>

	</div>

<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
 
	

<script>
function clearSearch(event) {
	event.preventDefault();
	
	document.getElementById('annIdInput').value = '';
	document.getElementById('annTitleInput').value = '';

}


</script>

</body>


</html>