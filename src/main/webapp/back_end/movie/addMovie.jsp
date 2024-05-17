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
<meta charset="BIG5">
<title>新增一部電影</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/back_end/movie/addMovie.css"/>
</head>


<body>

<jsp:include page="../management.jsp" />
	
	<form action="<%= request.getContextPath() %>/MovieController"  method="post"  enctype="multipart/form-data">
        
	<%
	Movie movie = (Movie)request.getAttribute("movie");

	Object errorMsgsObj = request.getAttribute("errorMsgs");
	Map<String,String> errorMsgs = null;
	if (errorMsgsObj instanceof Map<?, ?>) {
	    errorMsgs = (Map<String,String>) errorMsgsObj;
	}
	
	MovieService movieSvc=new MovieService();

	%>

        
        電影編號 <input type="text" class="movieId" id="movieId" name="movieId" value="<%=movieSvc.findNewId() %>" readonly>
		電影名字 <% if (errorMsgs != null && errorMsgs.containsKey("movieName")) { %> 
		<span style="color: red;"><%= errorMsgs.get("movieName") %></span> <% } %>
		<input type="text" name="movieName" >
   
  
		
		<br> 輸入電影時長(分):  <% if (errorMsgs != null && errorMsgs.containsKey("runtime")) { %> 
		<span  style="color: red;"><%= errorMsgs.get("runtime") %>" </span>    
    <% } %>
		<input type="text" name="runtime" maxlength="3" />
   
        
   
		電影類型<br> <select name="genre">

			<option value="喜劇片" selected>喜劇片</option>
			<option value="愛情片">愛情片</option>
			<option value="動作片">動作片</option>
			<option value="科幻片">科幻片</option>
			<option value="恐怖片">恐怖片</option>
			<option value="驚悚片">驚悚片</option>
			<option value="劇情片">劇情片</option>
			<option value="動畫片">動畫片</option>
			<option value="紀錄片">紀錄片</option>

		</select><br> 
		上映日期<% if (errorMsgs != null && errorMsgs.containsKey("releaseDate")) { %>
		<span style="color: red;"><%=  errorMsgs.get("releaseDate") %></span>  <% } %>
		<input type="date" name="releaseDate">
   
    
  <br>
    
		下檔日期<% if (errorMsgs != null && errorMsgs.containsKey("offDate")) { %>
		<span style="color: red;"><%=  errorMsgs.get("offDate") %></span>  <% } %>
		<label for="offDate">
		<input type="date" id="offDate" name="offDate">
		
	</label>
		<br><br>
	    電影分級<select name="rating">
		<option value="普遍級" selected>普遍級</option>
		<option value="保護級" >保護級</option>
		<option value="輔導級" >輔導級</option>
		<option value="限制級" >限制級</option>
		
		</select><br>
		
		語言<br> <select name="language">

			<option value="英文" selected>英文</option>
			<option value="中文">中文</option>
			<option value="粵語">粵語</option>
			<option value="日文">日文</option>
			<option value="韓文">韓文</option>
			<option value="泰語">泰語</option>
			<option value="西文">西文</option>
			<option value="法文">法文</option>
			<option value="德文">德文</option>


		</select><br> 
		電影簡介<% if (errorMsgs != null && errorMsgs.containsKey("movieInfo")) { %>
		<span style="color:red;"><%=errorMsgs.get("movieInfo")%></span><%} %>
		<input type="text" name="movieInfo" maxlength="250" >
		
		<br> 
			
    
		上映狀態<select name="movieStatus">
	    <option value="即將上映" ${movie.movieStatus eq '即將上映' ? 'selected' : ''}>即將上映</option>
	    <option value="熱映中" ${movie.movieStatus eq '熱映中' ? 'selected' : ''}>熱映中</option>
	    <option value="已下檔" ${movie.movieStatus eq '已下檔' ? 'selected' : ''}>已下檔</option>
        </select><br> <br> 
		選擇海報<% if (errorMsgs != null && errorMsgs.containsKey("poster")) { %> 
		<span style="color:red;"><%=errorMsgs.get("poster") %></span><%} %>
		<input type="file" name="poster"><br> <br>
		
		預告片連結<%if(errorMsgs!=null && errorMsgs.containsKey("trailer")){ %>
		<span style="color:red;"><%=errorMsgs.get("trailer") %></span><%} %>
		<input type="text" name="trailer"><br> 
		 
		<input type="submit" value="新增電影">
        <input type="button" id="listAll" value="瀏覽電影" onclick="redirectToMovies()">
        <input type="hidden" name="action" value="insert">
	</form>
	
	
	<script type="text/javascript">
	
	document.getElementById('offDate').addEventListener('click', function() {
	    this.type = 'date';
	});
	
	
	function redirectToMovies() {
        // 在這裡插入你想要導向的 URL
        window.location.href = "./listAllMovie.jsp";
    }
	</script>

</body>
</html>