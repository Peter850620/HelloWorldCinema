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
		  border-radius: 25px;
		  background-color: red;
		  font-size: 20px;
		  width: 90px;
		  transition-duration: 0.5s;
		  color: white;
		}
		
		button:hover {
		  background-color: darkred;
		}
		
		.form_head{
            display: flex;
            align-items: center;
            color: white;
            text-align: center;
            position: relative;
		}
		
		.form_head a{
			color: white;
			text-align: left;
			margin-right: 150px;
			background-color: rgb(135, 189, 250);
        	border: solid white;
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
			resize: none;
			font-size: 16px;
		}
		
		.title input[type="text"] {
		    width: 300px; 
		    height: 30px; 
		    font-size: 16px;
		}

	</style>
</head>
<%@ include file="../management.jsp" %>
<body>
	<div id="xxx">
		<div class="comment_body">
	       <form action="<%= request.getContextPath() %>/back/message.do" method="post">
		       <div class="form_head">
		       		<a href="<%= request.getContextPath() %>/back/message.do?action=getAll">回主頁</a>
		       </div>
				<div class="title">
					<label for="mem">會員編號:</label>
					<input id ="mem" name="mem" type="text" value="${param.mem}" onclick="hideContent('mem.errors');" />
					<span  id ="mem.errors" class="error">${errorMsgs.mem}<br/></span>
				</div >
				<div class="title">
					<label for="msgTitle">通知標題:</label>
					<input id ="msgTitle" name="msgTitle" type="text" value="${param.msgTitle}" onclick="hideContent('msgTitle.errors');" />
					<span  id ="msgTitle.errors" class="error">${errorMsgs.msgTitle}</span>
				</div>
				<div class="title">
					<label for="msgDetail">通知內容:</label>
					<textarea id ="msgDetail" name="msgDetail" onclick="hideContent('msgDetail.errors');">${param.msgDetail}</textarea>
					<span  id ="msgDetail.errors" class="error">${errorMsgs.msgDetail}</span>
				</div>
				<div class="title">
					<input  type="hidden" name="action" value="insert">
					<input type="hidden" id ="newTime" name="msgTime" value="${param.msgTime}"/>
					<input  type="hidden" name="msgStatus" value="未讀">
					<button type="submit" id="submit"> 送出新增 </button>
				</div>
			</form>
		</div>
	</div>
<script>
function hideContent(d) {
    document.getElementById(d).style.display = "none";
}
</script>

</body>
</html>