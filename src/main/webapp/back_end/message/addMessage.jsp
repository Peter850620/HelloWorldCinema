<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
	
	<style>
		form {
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
		  border-radius: 25px;
		  background-color: rgba(162, 161, 167, 0.5);
		  font-size: 20px;
		  width: 90px;
		
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
		
		.title{
			text-align: left;
			position: relative;
			display: flex; 
		    align-items: center; 
		    margin-bottom: 15px;
		    border:0px ; 
		    font-weight: bold;
		}
		
		.title label {
		    margin-right: 10px;
    		min-width: 150px;  
		}
		
		.title textarea{
			width: 500px; 
			height: 200px; 
			resize: vertical;
			font-size: 16px;
		}
		
		.title input[type="text"] {
		    width: 300px; 
		    height: 30px; 
		    font-size: 16px;
		}
		
		a{
			color: white;
		}
	</style>
</head>
<%@ include file="../management.jsp" %>


<body>
	<div id="xxx">
		<div class="comment_body">
	       <form action="<%= request.getContextPath() %>/back/message.do" method="post">
	       	<a href="<%= request.getContextPath() %>/back/message.do?action=getAll">回主頁</a>
				<div>
					<label for="mem">會員編號:</label>
					<input id ="mem" name="mem" type="text" value="${param.mem}" onclick="hideContent('mem.errors');" />
					<span  id ="mem.errors" class="error">${errorMsgs.mem}<br/></span>
				</div>
				
				<div>
					<label for="msgTitle">通知標題:</label>
					<input id ="msgTitle" name="msgTitle" type="text" value="${param.msgTitle}" onclick="hideContent('msgTitle.errors');" />
					<span  id ="msgTitle.errors" class="error">${errorMsgs.msgTitle}</span>
				</div>
				
				<div>
					<label for="msgDetail">通知內容:</label>
					<textarea id ="msgDetail" name="msgDetail">${param.msgDetail}</textarea>
					<span  id ="msgDetail.errors" class="error">${errorMsgs.msgDetail}</span>
				</div>

				<div>

					<input  type="hidden" name="action" value="insert">
					<input type="hidden" id ="newTime" name="msgTime" value="${param.msgTime}"/>
					<input  type="hidden" name="msgStatus" value="未讀">
					<button type="submit" id="submit"> 送出新增 </button>

				</div>
			</form>
		</div>
	</div>
    

<script src="<%= request.getContextPath() %>/back_end/management.js"></script>
 <script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
	

<script>
function hideContent(d) {
    document.getElementById(d).style.display = "none";
}
</script>

</body>
</html>