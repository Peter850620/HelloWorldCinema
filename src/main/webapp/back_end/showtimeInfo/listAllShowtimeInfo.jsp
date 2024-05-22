<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*"%>
<%@page import="com.service.ShowtimeInfoServicePeter"%>
<%@page import="com.entity.ShowtimeInfo"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	ShowtimeInfoServicePeter showtimeInfoSvc = new ShowtimeInfoServicePeter();
    List<ShowtimeInfo> list = showtimeInfoSvc.getAll(); 
    if(request.getAttribute("showtimeInfoListDataPart")==null) pageContext.setAttribute("showtimeInfoListData",list);
    
    Date currentDate = new java.sql.Date(System.currentTimeMillis());
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDateString = sdf.format(currentDate);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>所有餐點資料</title>
		
			<script src="https://code.jquery.com/jquery-3.5.1.js"></script>                                    <!-- ●●js  for jquery datatables 用 -->
			<script	src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>              <!-- ●●js  for jquery datatables 用 -->
			<link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.jqueryui.min.css" /> <!-- ●●css for jquery datatables 用 -->
			
		
			<!-- ●● jquery datatables 設定 -->
			<script>
				$(document).ready(function() {
					$('#example').DataTable({
						"lengthMenu": [5, 10, 20, 50, 100],
						"searching": true,  //搜尋功能, 預設是開啟
					    "paging": true,     //分頁功能, 預設是開啟
					    "ordering": true,   //排序功能, 預設是開啟
					    "language": {
					        "processing": "處理中...",
					        "loadingRecords": "載入中...",
					        "lengthMenu": "顯示 _MENU_ 筆結果",
					        "zeroRecords": "沒有符合的結果",
					        "info": "顯示第 _START_ 至 _END_ 筆結果，共<font color=red> _TOTAL_ </font>筆",
					        "infoFoodty": "顯示第 0 至 0 筆結果，共 0 筆",
					        "infoFiltered": "(從 _MAX_ 筆結果中過濾)",
					        "infoPostFix": "",
					        "search": "搜尋:",
					        "paginate": {
					            "first": "第一頁",
					            "previous": "上一頁",
					            "next": "下一頁",
					            "last": "最後一頁"
					        },
					        "aria": {
					            "sortAscending":  ": 升冪排列",
					            "sortDescending": ": 降冪排列"
					        }
					    }
					});
				});
			</script>
		
			<style type="text/css">
				.main{
					body {
						margin: 1rem 12rem 2rem 12rem;
					}
				}
			</style>
		</head>
	<body>
	<%@ include file="../management.jsp" %>
	
	<div class="main">
		<nav class="navbar navbar-expand-md navbar-dark bg-success fixed-top justify-content-center">
				 <div align="center"> <h2>查詢場次資料</h2>
		</nav>
		
		<jsp:useBean id="MovieSvc" scope="page" class="com.service.MovieService" />
		<jsp:useBean id="ScreenSvc" scope="page" class="com.service.ScreenServicePeter" />
        
        
		<form method="post" action="<%=request.getContextPath()%>/showtimeInfo/showtimeInfoPeter.do">
			<a>播放日期:</a>
			<input type="date" value=<%=formattedDateString%> name="playdate">
			<a>影廳:</a>
			<select size="1" name=screenId>
			    		<option value="NULL">全部</option>
			    <c:forEach var="Screen"  items="${ScreenSvc.screenId}">
			    		<option value="${Screen.getScreenId()}">${Screen.getScreenId()}</option>
				</c:forEach>    
			</select>
			
			<a>電影名稱:</a>
			<select size="1" name="movieId">
			    		<option value="NULL">==全部==</option>
			    <c:forEach var="Movie"  items="${MovieSvc.findAllmovies()}">
			    		<option value="${Movie.getMovieId()}">${Movie.getMovieId()}: ${Movie.getMovieName()}</option>
				</c:forEach>    
			</select>

            <input type="hidden" name="action" value="getDate_For_Display">
			<input type="submit" value="送出" >
		</form>
        
		<table id="example" class="display" style="width: 100%">
		
		
		  <thead >
			<tr style="background-color:#CCCCFF">
				<th>計數</th>
				<th>電影名稱</th>
				<th>影廳</th>
				<th>播放日期</th>
				<th>開始撥放</th>
				<th>結束播放</th>
				<th>場次狀態</th>
				<th>修改</th>
				<th>刪除</th>
			</tr>
		  </thead>
		
		 <tbody>
			<c:forEach var="ShowtimeInfo" items="${showtimeInfoListData}" varStatus="s">
				<tr class="showtimeInfoStatusRow">
		            <td>${s.count}</td>
					<td>${ShowtimeInfo.movie.getMovieName()}</td>
					<td>${ShowtimeInfo.playdate}</td>
					<td>${ShowtimeInfo.screen.getScreenId()}</td>
					<td>${ShowtimeInfo.showtime}</td>
					<td>${ShowtimeInfo.endtime}</td>
					<td>${ShowtimeInfo.showtimeStatus}</td> 
					<td>
					  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/showtimeInfo/showtimeInfoPeter.do" style="margin-bottom: 0px;">
					     <input type="submit" value="修改">
					     <input type="hidden" name="showtimeId" value="${ShowtimeInfo.showtimeId}">
					     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
					</td>
					<td>
					  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/showtimeInfo/showtimeInfoPeter.do" style="margin-bottom: 0px;">
					     <input type="submit" value="刪除" disabled>
					     <input type="hidden" name="showtimeId" value="${ShowtimeInfo.showtimeId}">
					     <input type="hidden" name="action" value="delete"></FORM>
					</td>
				</tr>
			</c:forEach>
			
			<!-- 複合查詢 -->
			<c:forEach var="ShowtimeInfo" items="${showtimeInfoListDataPart}" varStatus="s">
				<tr class="showtimeInfoStatusRow">
		            <td>${s.count}</td>
					<td>${ShowtimeInfo.movie.getMovieName()}</td>
					<td>${ShowtimeInfo.playdate}</td>
					<td>${ShowtimeInfo.screen.getScreenId()}</td>
					<td>${ShowtimeInfo.showtime}</td>
					<td>${ShowtimeInfo.endtime}</td>
					<td>${ShowtimeInfo.showtimeStatus}</td> 
					<td>
					  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/showtimeInfo/showtimeInfoPeter.do" style="margin-bottom: 0px;">
					     <input type="submit" value="修改">
					     <input type="hidden" name="showtimeId" value="${ShowtimeInfo.showtimeId}">
					     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
					</td>
					<td>
					  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/showtimeInfo/showtimeInfoPeter.do" style="margin-bottom: 0px;">
					     <input type="submit" value="刪除" disabled>
					     <input type="hidden" name="showtimeId" value="${ShowtimeInfo.showtimeId}">
					     <input type="hidden" name="action" value="delete"></FORM>
					</td>
				</tr>
			</c:forEach>
		  </tbody>
		</table>
	</div>
	</body>
</html>