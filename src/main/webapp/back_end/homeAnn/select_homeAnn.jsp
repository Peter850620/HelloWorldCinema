<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
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
        }
        
        .compositequery input[type="text"] {
            font-size: 20px;
            padding: 10px; 
            width: 200px; 
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
        
        .homeAnn_head {
        	margin-bottom: 10px;
        }
       
        .homeAnn_head a {
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
			<form method="post" action="<%= request.getContextPath() %>/back/homeAnn.do" class="formSearch">
				<input type="text" name="annId" id="annIdInput" placeholder="公告編號" value="${annId}">

				<input type="text" name="annTitle" id="annTitleInput" placeholder="公告標題" value="${annTitle}">
				
				<div class="search">
					<input type="hidden" name="action" value="compositeQuery">
					<input type="submit" value="查詢">
					<button onclick="clearSearch(event)" class="clear">清空</button>
				</div>
			</form>
		</div>
		<div class="mainIndex" id="mainIndex">
		<div class="homeAnn_head">
			<a href="<%= request.getContextPath() %>/back_end/management.jsp">回主頁</a>
			<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll">所有公告</a>
			<a href="<%= request.getContextPath() %>/back_end/homeAnn/addHomeAnn.jsp">新增公告</a>
		</div>
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
		            <tbody id="homeAnnBody">
		            	<c:forEach var="homeAnn" items="${homeAnnList}">
							<tr>
								<td>${homeAnn.annId}</td>
								<td class="timeItem">${homeAnn.annTime}</td>
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
		        <div class="pageChange">
		        	<c:if test="${currentPage > 1}">
						<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=${action}&page=1&annId=${convertedMap.annId}&annTitle=${convertedMap.annTitle}">至第一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage - 1 != 0}">
						<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=${action}&page=${currentPage - 1}&annId=${convertedMap.annId}&annTitle=${convertedMap.annTitle}">上一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage + 1 <= homeAnnPageQty}">
						<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=${action}&page=${currentPage + 1}&annId=${convertedMap.annId}&annTitle=${convertedMap.annTitle}">下一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage != homeAnnPageQty}">
						<a href="<%= request.getContextPath() %>/back/homeAnn.do?action=${action}&page=${homeAnnPageQty}&annId=${convertedMap.annId}&annTitle=${convertedMap.annTitle}">至最後一頁</a>&nbsp;
					</c:if>
		        </div>
	    	</div>
		</div>
	</div>
<script>
	function clearSearch(event) {
		event.preventDefault();
		
		document.getElementById('annIdInput').value = '';
		document.getElementById('annTitleInput').value = '';
	}
	
	document.addEventListener('DOMContentLoaded', () => {
	    const homeAnnBody = document.getElementById('homeAnnBody');
	    const rows = Array.from(homeAnnBody.getElementsByTagName('tr'));
	
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
	
	    rows.sort((a, b) => b.annTimeValue - a.annTimeValue); 
	
	    rows.forEach(row => homeAnnBody.appendChild(row));
	});
</script>

</body>


</html>