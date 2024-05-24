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

        .message_head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .message_head a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .message_head a:hover {
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
		
    </style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
    <div class="main" id="main">
    	<h1>個人通知</h1>
        <div class="message_head">
        	<a href="<%= request.getContextPath() %>/front_end/review/reviewFront.jsp">回會員中心</a>	<!-- 路徑要改 -->
            <a href="<%= request.getContextPath() %>/front/message.do?action=getMem&mem=240001">所有通知</a>
        </div>
		
		<div class="message_container">
	        <table>
	            <thead>
	                <tr>
	                    <th>通知編號</th>
	                    <th>通知日期</th>
	                    <th>狀態</th>
	                    <th>通知標題</th>
	                </tr>
	            </thead>
	            <tbody id="messageBody">
	            	<c:forEach var="message" items="${messageList}">
						<tr>
							<td>${message.msgId}</td>
							<td class="timeItem">${message.msgTime}</td>
							<td>${message.msgStatus}</td>
							<td><a href="<%= request.getContextPath() %>/front/message.do?action=getMessage&msgId=${message.msgId}">${message.msgTitle}</a></td>
						</tr>               
					</c:forEach>
	            </tbody>
	        </table>
	        <c:if test="${currentPage > 1}">
				<a href="<%= request.getContextPath() %>/front/message.do?action=getMem&page=1" style="color: blue;">至第一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage - 1 != 0}">
				<a href="<%= request.getContextPath() %>/front/message.do?action=getMem&page=${currentPage - 1}" style="color: blue;">上一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage + 1 <= messagePageQty}">
				<a href="<%= request.getContextPath() %>/front/message.do?action=getMem&page=${currentPage + 1}" style="color: blue;">下一頁</a>&nbsp;
			</c:if>
			<c:if test="${currentPage != messagePageQty}">
				<a href="<%= request.getContextPath() %>/front/message.do?action=getMem&page=${messagePageQty}" style="color: blue;">至最後一頁</a>&nbsp;
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
	        const messageBody = document.getElementById('messageBody');
	        const rows = Array.from(messageBody.getElementsByTagName('tr'));
	
	        rows.forEach(row => {
	            const dateCell = row.querySelector('.timeItem');
	            const date = new Date(dateCell.textContent.trim());
	            dateCell.textContent = date.toISOString().slice(0, 19).replace('T', ' '); 
	            row.msgTimeValue = date.getTime(); 
	        });
	
	        rows.sort((a, b) => b.msgTimeValue - a.msgTimeValue); 
	
	        rows.forEach(row => messageBody.appendChild(row));
	    });
    </script>
</body>
</html>