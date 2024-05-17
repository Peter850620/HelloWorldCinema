<%@page import="com.service.BookingService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>

<%@ page import="java.util.List" %>
<%@ page import="com.service.*" %>

<%@ page import="java.util.Map" %>


<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>更新電影訊息</title>


<style>


form {
	margin: 20px auto;
	padding: 20px;
	width: 55%;
	border-radius: 25px;
	justify-content: center;
	padding: 100px;
	background-color: rgb(0 0 0/ 60%);
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	left: 150px;
	border: 2px solid white;
	margin-left:455px;
	font-size: 25px;
	color:white;
}

input[type="text"], select {
	width: calc(100% - 20px);
	margin-bottom: 10px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: white;
}

input[type="submit"], input[type="button"] {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}

input[type="submit"]:hover, input[type="button"]:hover {
	background-color: #0056b3;
}



input[type="text"], input[type="date"], select {
	width: calc(100% - 15px);
	margin-bottom: 10px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	color: black;
}

</style>
</head>



<body>
<jsp:include page="../management.jsp"/>

        
<%
    Movie movie = (Movie)request.getAttribute("movie");
   
	Object errorMsgsObj = request.getAttribute("errorMsgs");
	Map<String,String> errorMsgs = null;
	if (errorMsgsObj instanceof Map<?, ?>) {
	    errorMsgs = (Map<String,String>) errorMsgsObj;
	}
	
	MovieService movieSvc=new MovieService();

	%>




	<form action="<%=request.getContextPath()%>/MovieController" method="post"  enctype="multipart/form-data">

	<label for="movieId">電影編號：</label><br> 
	 <input type="text" disabled id="movieId" name="movieId" value="<%=movie.getMovieId()%>"><br>
	 <label for="movieName">電影：</label><br> 
	 <input type="text" id="movieName" name="movieName" value="<%=movie.getMovieName()%>"><br>

		<label for="runtime">電影時長(分)：</label><br> <input type="text" id="runtime" name="runtime" value="<%=movie.getRuntime()%>"><br>
		<label for="genre">電影類型：</label><br>
		 <select id="genre" name="genre">

			<option value="喜劇片"
				<%=movie.getGenre().equals("喜劇片") ? "selected" : ""%>>喜劇片</option>
			<option value="愛情片"
				<%=movie.getGenre().equals("愛情片") ? "selected" : ""%>>愛情片</option>
			<option value="動作片"
				<%=movie.getGenre().equals("動作片") ? "selected" : ""%>>動作片</option>
			<option value="科幻片"
				<%=movie.getGenre().equals("科幻片") ? "selected" : ""%>>科幻片</option>
			<option value="恐怖片"
				<%=movie.getGenre().equals("恐怖片") ? "selected" : ""%>>恐怖片</option>
			<option value="驚悚片"
				<%=movie.getGenre().equals("驚悚片") ? "selected" : ""%>>驚悚片</option>
			<option value="劇情片"
				<%=movie.getGenre().equals("劇情片") ? "selected" : ""%>>劇情片</option>
			<option value="動畫片"
				<%=movie.getGenre().equals("動畫片") ? "selected" : ""%>>動畫片</option>
			<option value="紀錄片"
				<%=movie.getGenre().equals("紀錄片") ? "selected" : ""%>>紀錄片</option>

		</select> 
		
		<label for="releaseDate">上映日期</label><br> 
		<input type="date" id="releaseDate" name="releaseDate" value="<%=movie.getReleaseDate()%>"><br> 
		
		<label for="offDate">下檔日期：</label><br> 
		<input type="date" id="offeDate" name="offDate" value="<%=movie.getOffDate()%>"><br> 
		
		<label for="language">語言：</label><br> 
		<select name="language">
		    <option value="英文" ${movie.language eq '英文' ? 'selected' : ''}>英文</option>
		    <option value="中文" ${movie.language eq '中文' ? 'selected' : ''}>中文</option>
		    <option value="粵語" ${movie.language eq '粵語' ? 'selected' : ''}>粵語</option>
		    <option value="日文" ${movie.language eq '日文' ? 'selected' : ''}>日文</option>
		    <option value="韓文" ${movie.language eq '韓文' ? 'selected' : ''}>韓文</option>
		    <option value="泰語" ${movie.language eq '泰語' ? 'selected' : ''}>泰語</option>
		    <option value="西文" ${movie.language eq '西文' ? 'selected' : ''}>西文</option>
		    <option value="法文" ${movie.language eq '法文' ? 'selected' : ''}>法文</option>
		    <option value="德文" ${movie.language eq '德文' ? 'selected' : ''}>德文</option>
		</select>
		
		 電影分級<select name="rating">
			    <option value="普遍級" ${movie.rating eq '普遍級' ? 'selected' : ''}>普遍級</option>
			    <option value="保護級" ${movie.rating eq '保護級' ? 'selected' : ''}>保護級</option>
			    <option value="輔導級" ${movie.rating eq '輔導級' ? 'selected' : ''}>輔導級</option>
			    <option value="限制級" ${movie.rating eq '限制級' ? 'selected' : ''}>限制級</option>
			    </select>
		
		電影簡介<% if (errorMsgs != null && errorMsgs.containsKey("movieInfo")) { %>
		<span style="color:red;"><%=errorMsgs.get("movieInfo")%></span><%} %>
		<input type="text" name="movieInfo" maxlength="250" value="${movie.movieInfo} " >
		<br>
		
		上映狀態<select name="movieStatus">
			    <option value="即將上映" ${movie.movieStatus eq '即將上映' ? 'selected' : ''}>即將上映</option>
			    <option value="熱映中" ${movie.movieStatus eq '熱映中' ? 'selected' : ''}>熱映中</option>
			    <option value="已下檔" ${movie.movieStatus eq '已下檔' ? 'selected' : ''}>已下檔</option>
			  
			    </select>
		
	    <input type="file" id="pic" name="poster" value="<%=movie.getPoster()%>"><br>
		<br>	 
	     <img src="data:image/jpeg;base64,${movie.picBase64}"	style="width: 100px; height: auto;">
	
					
		<br>預告片連結<%if(errorMsgs!=null && errorMsgs.containsKey("trailer")){ %>
		<span style="color:red;"><%=errorMsgs.get("trailer") %></span><%} %>
		<input type="text" name="trailer" value="${movie.trailer}"><br> 
		
	
		<input type="hidden" id="action" name="action" value="">
		<input type="hidden" id="movieId" name="movieId" value="<%=movie.getMovieId()%>"><br> 
		<input type="submit"  class="update" value="更新" data-chinese="update"> 
		<input type="submit" class="cancel" value="取消" data-chinese="cancel">
		
	</form>
			
		<script>
		    
		    let cancel = document.getElementsByClassName("cancel")[0];
	        let update =document.getElementsByClassName("update")[0];
	        let action=document.getElementById("action");
		    cancel.addEventListener("click", function() {
		       
		    	 action.value = cancel.getAttribute("data-chinese");
		    });
		    
		    
		    update.addEventListener("click", function(){
		    	
		    	 action.value = update.getAttribute("data-chinese");
		    });
		</script>

</body>
</html>