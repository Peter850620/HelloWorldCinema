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

		
		 form {
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
		}

	</style>
</head>



<body>
<%@ include file="../management.jsp" %>

	<!-- ====================這是main==================== -->
	<div id="xxx">
		<div class="main" id="main">
			<div align="center">		
				<form action="<%= request.getContextPath() %>/back/report.do" method="post" id="myForm">
					<a href="<%= request.getContextPath() %>/back_end/management.jsp">回主頁</a>
					<h3><b>所有欄位皆為必填欄位</b></h3>
					<div class="title">
					<label for="rptId">檢舉編號:</label>
					<input id ="rptId" name="rptId" type="text" value="${param.rptId}" style="border:0px ; font-weight: bold;" readonly />
					</div>
					
					<div class="title">
					<label for="mem">會員編號:</label>
					<input id ="mem" name="mem" type="text" value="${param.mem}"  style="border:0px ; font-weight: bold;" readonly />
					</div>
					
					<div class="title">
					<label for="review">評論編號:</label>
					<input id ="review" name="review" type="text" value="${param.review}" style="border:0px ; font-weight: bold;" readonly />
					</div>
		 			
		 			<!-- 用js將timestamp型態轉換 -->
					<div class="title">
					<label for="rptDate">檢舉日期:</label>
					<input id ="rptDate" class="timeItem" name="rptDate" type="text" value="${param.rptDate}" style="border:0px ; font-weight: bold;" readonly />
					</div>
					
					<div class="title">
					<label for="rptType">檢舉類型:</label>
					<input id ="rptType" name="rptType" type="text" value="${param.rptType}" style="border:0px ; font-weight: bold;" readonly />
					</div>
					
					<div class="title">
					<label for="rptDetail">檢舉內容:</label>
					<textarea id ="rptDetail" name="rptDetail" style="border:0px ; font-weight: bold; width: 300px; height: 100px; resize: vertical;" readonly>${param.rptDetail}</textarea>
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
						<div></div>
						<input  type="hidden" name="action" value="update">
						<input type="hidden" name="rptDate" value="${param.reviewDate}" id="newTime">
						<button type="submit" id="submit"> 送出修改 </button>
						<div></div>
					</div>
				</form>
				<div id="messageContent"></div>
			</div>
		</div>
	</div>
    

<script src="<%= request.getContextPath() %>/back_end/management.js"></script>
<script src="<%= request.getContextPath() %>/js/timestampFormat.js"></script>
 
	

<script>
function hideContent(d) {
    document.getElementById(d).style.display = "none";
}
	
$(document).ready(function() {
    $('#rptStatus').change(function() {
        checkStatus();
    });
});

function checkStatus() {
    var status = $('#rptStatus').val();
    if (status === "通過" || status === "未通過") {
        $.ajax({
            url: "<%= request.getContextPath() %>/back/report.do",
            method: "POST",
            data: { 
                rptStatus: status,
                action: "loadContent"
            },
            success: function(response) {
                $('#messageContent').html(response);
            },
            error: function(xhr, status, error) {
                console.error("An error occurred: " + error);
            }
        });
    }else if (status === "未審核") {
       $('#messageContent').empty();
    }
}
</script>

</body>
</html>