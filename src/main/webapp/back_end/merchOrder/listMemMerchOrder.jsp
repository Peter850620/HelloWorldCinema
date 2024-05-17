<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>


<%
    // Get memId from the request
    String strMemId = request.getParameter("memId");
    int memId = Integer.parseInt(strMemId); // Parse to integer

    // Use memId to fetch merchOrder data
    MerchOrderService merchOrderSvc = new MerchOrderService();
    List<MerchOrder> list = merchOrderSvc.getById(memId);
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
        <h1>個別會員周邊商品訂單</h1>
        <h4><a href="<%=request.getContextPath()%>/back_end/merchOrder/select_page.jsp">回到周邊商品訂單管理</a></h4>

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
	        <th>修改</th>
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
	           <td><a href="<%=request.getContextPath()%>/merchItem/merchItem.do?action=getAll_For_Item&merchNo=${merchOrder.merchNo}">查看詳情</a></td>
	            <td>
                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/merchOrder/merchOrder.do" style="margin-bottom: 0px;">
				    <input type="submit" value="修改">
				    <input type="hidden" name="merchNo"  value="${merchOrder.merchNo}">
				    <input type="hidden" name="action"	value="getOne_For_Update">
			    </FORM>
            	</td>	
         	</tr>
         </c:forEach>
    </table>
    
	    

      </div>



</body>

</html>