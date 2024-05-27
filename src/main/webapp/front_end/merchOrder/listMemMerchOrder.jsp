<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%
    // Get memId from the request
    String strMemId = request.getParameter("memId");
    Integer memId = Integer.parseInt(strMemId); // Parse to integer


    MerchOrderService merchOrderSvc = new MerchOrderService();
    List<MerchOrder> list = merchOrderSvc.showById(memId);
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
        <h1>周邊商品訂單</h1>
 

        <br>
        <table>
          <tr>
            <th>周邊訂單編號</th>
	        <th>會員編號</th>
	        <th>訂單日期</th>
	        <th>取貨方式</th>
	        <th>付款方式</th>
	        <th>出貨狀態</th>
	        <th>合計</th>
	        <th>收貨人</th>
	        <th>收貨地址</th>
	        <th>收貨人電話</th>
	        <th>查看詳情</th>

          </tr>
          <c:forEach var="merchOrder" items="${list}">
	          <tr>
	            <td>${merchOrder.merchNo}</td>
	            <td>${merchOrder.mem.memId}</td>
	            <td>${merchOrder.orderDate}</td>
	            <td>${merchOrder.pickupOption}</td>
	            <td>${merchOrder.paymentType}</td>
	            <td>${merchOrder.receiptStatus}</td>
	            <td>${merchOrder.merchTotal}</td>
	            <td>${merchOrder.recipient}</td>
	            <td>${merchOrder.receiptAddr}</td>
	            <td>${merchOrder.receiptMobile}</td>
	           <td><a href="<%=request.getContextPath()%>/merchItem/merchItem.do?action=listAll_For_Item&merchNo=${merchOrder.merchNo}">查看詳情</a></td>
	            
         	</tr>
         </c:forEach>
    </table>
    
	    

      </div>

<!-- ========================以上區域可放置其他內容======================== -->

<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />  


</body>
</html>
