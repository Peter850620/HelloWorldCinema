<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%
    Integer merchNo = Integer.valueOf(request.getParameter("merchNo"));
    MerchItemService merchItemSvc = new MerchItemService();
    List<MerchItem> list = merchItemSvc.showByNo(merchNo);
    pageContext.setAttribute("list", list);
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 主要css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/merchOrder/css/ticket.css">
</head>
<body>

<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />    
<!-- ========================以下區域可放置其他內容======================== -->

<div class="container">
        <h1>周邊商品訂單明細</h1>
        <h4><a href="<%=request.getContextPath()%>/merchOrder/merchOrder.do?action=showById&memId=${memId}">回到周邊商品訂單</a></h4>


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

<!-- ========================以上區域可放置其他內容======================== -->

<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />  


</body>
</html>
