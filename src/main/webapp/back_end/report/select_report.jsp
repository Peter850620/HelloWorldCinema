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
        
		.compositequery{
			margin: 20px auto;
            width: 110%;
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
        
        .compositequery select {
            font-size: 20px;
            padding: 10px; 
            width: 150px; 
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
            width: 110%;
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
        
        .report_head {
        	margin-bottom: 10px;
        }
       
        .report_head a {
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
		    padding: 3px;
		    text-align: left; 
		    font-size: 20px;
		}
	
	</style>
</head>



<body>
<%@ include file="../management.jsp" %>

	<div class="xxx" id="xxx">
		<div class="compositequery">
			<form method="post" action="<%= request.getContextPath() %>/back/report.do" class="formSearch">
				<input type="text" name="rptId" id="rptIdInput" placeholder="檢舉編號" value="${rptId}">
				
				<input type="text" name="mem" id="memIdInput" placeholder="會員編號" value="${mem}">
	
				<input type="text" name="review" id="reviewIdInput" placeholder="評論編號" value="${review}">
				
				<select name="rptStatus" id="rptStatusSelect">
					<option value="未審核">未審核</option>
					<option value="通過">通過</option>
					<option value="未通過">未通過</option>
				</select>
				<div class="search">
					<input type="hidden" name="action" value="compositeQuery">
					<input type="submit" value="查詢">
					<button onclick="clearSearch(event)" class="clear">清空</button>
				</div>
			</form>
		</div>
		<div class="mainIndex" id="mainIndex">
			<div class="report_head">
				<a href="<%= request.getContextPath() %>/back_end/management.jsp">回主頁</a>
				<a href="<%= request.getContextPath() %>/back/review.do?action=getAll">討論區管理</a>
				<a href="<%= request.getContextPath() %>/back/report.do?action=getAll">所有檢舉</a>
			</div>
			<div class="container">
		        <table>
		            <thead>
		                <tr>
		                    <th>檢舉編號</th>
		                    <th>會員編號</th>
		                    <th>評論編號</th>
		                    <th>檢舉類型</th>
		                    <th>檢舉日期</th>
		                    <th>檢舉狀態</th>
		                    <th>檢舉內容</th>
		                </tr>
		            </thead>
		            <tbody id="reportBody">
		            	<c:forEach var="report" items="${reportList}">
							<tr>
								<td>${report.rptId}</td>
								<td>${report.mem.memId}</td>
								<td>${report.review.reviewId}</td>
								<td>${report.rptType}</td>
								<td class="timeItem">${report.rptDate}</td>
								<td>${report.rptStatus}</td>
								<td>
									<c:choose>
										<c:when test="${report.rptStatus.equals('未審核')}">
										<form method="post" action="<%= request.getContextPath() %>/back/report.do" class="formPost" style="margin-bottom: 0px;">
										     <input type="submit" value="審核">
										     <input type="hidden" name="rptId" value="${report.rptId}">
										     <input type="hidden" name="action"	value="getUpdate">
									     </form>
										</c:when>
										<c:otherwise>
											<form method="post" action="<%= request.getContextPath() %>/back/report.do" class="formPost" style="margin-bottom: 0px;">
											     <input type="submit" value="查看">
											     <input type="hidden" name="rptId" value="${report.rptId}">
											     <input type="hidden" name="action"	value="getUpdate">
										     </form>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
		            </tbody>
		        </table>
		        <div class="pageChange">
		        	<c:if test="${currentPage > 1}">
						<a href="<%= request.getContextPath() %>/back/report.do?action=getAll&page=1">至第一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage - 1 != 0}">
						<a href="<%= request.getContextPath() %>/back/report.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage + 1 <= reportPageQty}">
						<a href="<%= request.getContextPath() %>/back/report.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage != reportPageQty}">
						<a href="<%= request.getContextPath() %>/back/report.do?action=getAll&page=${reportPageQty}">至最後一頁</a>&nbsp;
					</c:if>
		        </div>
	    	</div>
		</div>
	</div>

<script>
	function clearSearch(event) {
		event.preventDefault();
		
		document.getElementById('rptIdInput').value = '';
		document.getElementById('memIdInput').value = '';
	    document.getElementById('reviewIdInput').value = '';
	    document.getElementById('rptStatusSelect').value = '未審核';
	}
	
	document.addEventListener('DOMContentLoaded', () => {
	    const reportBody = document.getElementById('reportBody');
	    const rows = Array.from(reportBody.getElementsByTagName('tr'));
	
	    rows.forEach(row => {
	        const dateCell = row.querySelector('.timeItem');
	        const date = new Date(dateCell.textContent.trim());
	        dateCell.textContent = date.toISOString().slice(0, 19).replace('T', ' '); 
	        row.rptDateValue = date.getTime(); 
	    });
	
	    rows.sort((a, b) => b.rptDateValue - a.rptDateValue); 
	
	    rows.forEach(row => reportBody.appendChild(row));
	});


</script>

</body>


</html>