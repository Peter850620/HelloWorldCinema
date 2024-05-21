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
        .message_container{
            background-color: aliceblue;
        }

        .message_head{
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
        <div class="message_head">
            <a href="<%= request.getContextPath() %>/front/message.do?action=getMem&mem=240001">所有評論</a>
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
	            <tbody>
	            	<c:forEach var="message" items="${messageList}">
						<tr>
							<td>${message.msgId}</td>
							<td>${message.msgTime}</td>
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
    
</body>
</html>