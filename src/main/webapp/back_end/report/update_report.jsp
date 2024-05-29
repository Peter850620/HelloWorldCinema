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
			resize: vertical;
			font-size: 16px;
		}
		
		.title input[type="text"] {
		    width: 300px; 
		    height: 30px; 
		    font-size: 16px;
		}
		
		.title select{
			width: 80px;
			height: 35px;
			font-size: 16px;
		}
		
		a{
			color: white;
		}

	</style>
</head>



<body>
<%@ include file="../management.jsp" %>
	<div id="xxx">
		<div class="mainIndex" id="mainIndex">		
			<form action="<%= request.getContextPath() %>/back/report.do" method="post" id="myForm">
				<div class="form_head">
					<a href="<%= request.getContextPath() %>/back/report.do?action=getAll">回主頁</a>
					<h3><b>檢舉詳細資料</b></h3>
				</div>
				<div class="title">
					<label for="rptId">檢舉編號:</label>
					<input id ="rptId" name="rptId" type="text" value="${param.rptId}" readonly />
				</div>
				<div class="title">
					<label for="mem">會員編號:</label>
					<input id ="mem" name="mem" type="text" value="${param.mem}" readonly />
				</div>
				<div class="title">
					<label for="review">評論編號:</label>
					<input id ="review" name="review" type="text" value="${param.review}" readonly />
				</div>
				<div class="title">
					<label for="rptDate">檢舉日期:</label>
					<input id ="rptDate" class="timeItem" name="rptDate" type="text" value="${param.rptDate}" readonly />
				</div>
				<div class="title">
					<label for="rptType">檢舉類型:</label>
					<input id ="rptType" name="rptType" type="text" value="${param.rptType}" readonly />
				</div>
				<div class="title">
					<label for="rptDetail">檢舉內容:</label>
					<textarea id ="rptDetail" name="rptDetail" readonly>${param.rptDetail}</textarea>
				</div>
	            <div class="title">
					<label for="rptStatus" class="statusLabel">檢舉狀態:</label>
					<select id="rptStatus" name="rptStatus" onclick="hideContent('rptStatus.errors');">
				        <option value="未審核" ${"未審核" == param.rptStatus ? 'selected' : ''}>未審核</option>
				        <option value="通過" ${"通過" == param.rptStatus ? 'selected' : ''}>通過</option>
				        <option value="未通過" ${"未通過" == param.rptStatus ? 'selected' : ''}>未通過</option>
				    </select>
				    <span  id ="rptStatus.errors" class="error">${errorMsgs.rptStatus}</span>
				</div>
				<div>
					<input  type="hidden" name="action" value="update">
					<button type="submit" id="submit"> 送出修改 </button>
				</div>
			</form>
		</div>
	</div>

<script>
	function hideContent(d) {
	    document.getElementById(d).style.display = "none";
	}
		
	document.addEventListener("DOMContentLoaded", function() {
	    var rptDateInput = document.getElementById("rptDate");
	    var rptDateValue = rptDateInput.value;
	    
	    if (rptDateValue) {
	        var date = new Date(rptDateValue);
	        const options = {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: false
            };
            var formattedDate = date.toLocaleString('zh-TW', options)
	        rptDateInput.value = formattedDate;
	    }
	});	
</script>

</body>
</html>