<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*"%>
<%@page import="com.service.FoodService"%>
<%@page import="com.entity.Food"%>
<%  
    FoodService foodSvc = new FoodService();
    List<Food> list = foodSvc.getAll(); 
    if(request.getAttribute("foodListData")==null) pageContext.setAttribute("foodListData",list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>所有餐點資料</title>

<%@ include file="included-fragment.file" %>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>                                    <!-- ●●js  for jquery datatables 用 -->
<script	src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>              <!-- ●●js  for jquery datatables 用 -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.jqueryui.min.css" /> <!-- ●●css for jquery datatables 用 -->


<!-- ●● jquery datatables 設定 -->
<script>
	$(document).ready(function() {
		$('#example').DataTable({
			"lengthMenu": [3 ,5, 10, 20, 50, 100],
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
		 <div align="center"> <h2>所有餐點資料</h2>
		 <h3><a class="navbar-brand" href="<%=request.getContextPath()%>/back_end/food/select_page.jsp"><img src="<%=request.getContextPath()%>/images/back1.gif">回查詢頁${success}</a></h3></div>
</nav>

<a>商品狀態:</a>
<select id="statusFilter">
    <option value="all">全部</option>
    <option value="上架">上架</option>
    <option value="下架">下架</option>
</select>

<table id="example" class="display" style="width: 100%">
  <thead >
	<tr style="background-color:#CCCCFF">
	    <th>計數</th>
		<th>食物編號</th>
		<th>食物名稱</th>
		<th>食物描述</th>
		<th>食物圖片</th>
		<th>價格</th>
		<th>上/下架</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
  </thead>

 <tbody>
	<c:forEach var="Food" items="${foodListData}" varStatus="s">
		<tr class="foodStatusRow">
            <td>${s.count}</td>
			<td>${Food.foodId}</td>
			<td>${Food.foodName}</td>
			<td>${Food.foodDetails}</td>
			<td><img src="<%=request.getContextPath()%>/food/DBGifReader?foodId=${Food.foodId}" width="100px"></td> 
			<td>${Food.foodPrice}</td>
			<td>${Food.foodStatus}</td> 
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/food/food.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="foodId" value="${Food.foodId}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/food/food.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除" disabled> 備註:控管刪除是否可點選依據?
			     <input type="hidden" name="foodId" value="${Food.foodId}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
  </tbody>
</table>
</div>
</body>
<script src="<%=request.getContextPath()%>/back_end/food/food.js"></script>
</html>