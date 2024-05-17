<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%
    // Use merchNo to fetch merchItem data
    Integer merchNo = Integer.valueOf(request.getParameter("merchNo"));
    MerchItemService merchItemSvc = new MerchItemService();
    List<MerchItem> list = merchItemSvc.getByNo(merchNo);
    pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>世界影城</title>
   
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back_end/ticket/ticket.css">
 
</head>



<body>

<jsp:include page="/back_end/management.jsp" flush="true" />


	   <div class="container">
        <h1>周邊商品訂單明細</h1>
        <h4><a href="<%=request.getContextPath()%>/back_end/merchOrder/select_page.jsp">回到周邊商品訂單管理</a></h4>


        <br>
        <table>
          <tr>
        <th>周邊訂單編號</th>
        <th>商品編號</th>
        <th>商品名稱</th>
        <th>商品價格</th>
        <th>商品數量</th>
        <th>小計</th>
      </tr>
          <c:forEach var="merchItem" items="${list}">
	          <tr>
	            <td>${merchItem.merchOrder.merchNo}</td>
	            <td>${merchItem.merch.merchId}</td>
	            <td>${merchItem.merch.merchName}</td>
	            <td>${merchItem.merch.merchPrice}</td>
	            <td>${merchItem.merchQty}</td>
	            <td>${merchItem.merchSubTotal}</td>
         	</tr>
         </c:forEach>
    </table>
    
	    

      </div>



</body>

</html>