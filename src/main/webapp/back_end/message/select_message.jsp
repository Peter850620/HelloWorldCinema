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
        
        .message_head {
        	margin-bottom: 10px;
        }
       
        .message_head a {
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
		    font-size: 20px; 
		}
			
	</style>
</head>
<body>
<%@ include file="../management.jsp" %>
	<div id="xxx">
		<div class="compositequery">
			<form method="post" action="<%= request.getContextPath() %>/back/message.do" class="formSearch">
				<input type="text" name="msgId" id="msgIdInput" placeholder="通知編號">
	
				<input type="text" name="mem" id="memIdInput" placeholder="會員編號">
				
				<input type="text" name="msgTitle" id="msgTitleInput" placeholder="通知標題">
	
				<select name="msgStatus" id="msgStatusSelect">
					<option value="未讀">未讀</option>
					<option value="已讀">已讀</option>
				</select>
				<div class="search">
					<input type="hidden" name="action" value="compositeQuery">
					<input type="submit" value="查詢">
					<button onclick="clearSearch(event)" class="clear">清空</button>
				</div>
			</form>
		</div>
		<div class="mainIndex" id="mainIndex">
			<div class="message_head">
				<a href="<%= request.getContextPath() %>/back_end/management.jsp">回首頁</a>
				<a href="<%= request.getContextPath() %>/back/message.do?action=getAll">所有通知</a>
				<a href="<%= request.getContextPath() %>/back_end/message/addMessage.jsp">新增通知</a>
			</div>
			<div class="container">
		        <table>
		            <thead>
		                <tr>
		                    <th>通知編號</th>
		                    <th>會員編號</th>
		                    <th>通知日期</th>
		                    <th>通知狀態</th>
		                    <th>通知標題</th>
		                    <th>通知內容</th>
		                </tr>
		            </thead>
		            <tbody id="messageBody">
		            	<c:forEach var="message" items="${messageList}">
							<tr>
								<td>${message.msgId}</td>
								<td>${message.mem.memId}</td>
								<td class="timeItem">${message.msgTime}</td>
								<td>${message.msgStatus}</td>
								<td>${message.msgTitle}</td>
								<td>
								  <form method="post" action="<%= request.getContextPath() %>/back/message.do" class="formPost">
								     <input type="submit" value="查看">
								     <input type="hidden" name="msgId" value="${message.msgId}">
								     <input type="hidden" name="action"	value="getOne">
							     </form>
								</td>
							</tr>
						</c:forEach>
		            </tbody>
		        </table>
		        <div class="pageChange">
		        	<c:if test="${currentPage > 1}">
						<a href="<%= request.getContextPath() %>/back/message.do?action=${action}&page=1&msgId=${convertedMap.msgId}&mem=${convertedMap.mem}&msgTitle=${convertedMap.msgTitle}&msgStatus=${convertedMap.msgStatus}">至第一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage - 1 != 0}">
						<a href="<%= request.getContextPath() %>/back/message.do?action=${action}&page=${currentPage - 1}&msgId=${convertedMap.msgId}&mem=${convertedMap.mem}&msgTitle=${convertedMap.msgTitle}&msgStatus=${convertedMap.msgStatus}">上一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage + 1 <= messagePageQty}">
						<a href="<%= request.getContextPath() %>/back/message.do?action=${action}&page=${currentPage + 1}&msgId=${convertedMap.msgId}&mem=${convertedMap.mem}&msgTitle=${convertedMap.msgTitle}&msgStatus=${convertedMap.msgStatus}">下一頁</a>&nbsp;
					</c:if>
					<c:if test="${currentPage != messagePageQty}">
						<a href="<%= request.getContextPath() %>/back/message.do?action=${action}&page=${messagePageQty}&msgId=${convertedMap.msgId}&mem=${convertedMap.mem}&msgTitle=${convertedMap.msgTitle}&msgStatus=${convertedMap.msgStatus}">至最後一頁</a>&nbsp;
					</c:if>
		        </div>
	    	</div>	
		</div>
	</div>
<script>
	function clearSearch(event) {
		event.preventDefault();
		
		document.getElementById('msgIdInput').value = '';
		document.getElementById('memIdInput').value = '';
	    document.getElementById('msgTitleInput').value = '';
	    document.getElementById('msgStatusSelect').value = '未讀';
	}
	
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