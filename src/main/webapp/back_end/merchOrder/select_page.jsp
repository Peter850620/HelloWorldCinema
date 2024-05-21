<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>世界影城</title>
    
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back_end/ticket/ticket.css">
    

	<style>
		
		.container{
			margin-left: 500px;
		}
		
		.first{
			margin-right: 900px;
		}
	</style>

</head>
<body>


<jsp:include page="/back_end/management.jsp" flush="true" />



<div class="container">
<h1 class="first">周邊商品訂單管理</h1>

<br>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


<ul>
  <li><a href="<%=request.getContextPath()%>/back_end/merchOrder/listAllMerchOrder.jsp">顯示全部資料</a></li>
  <br>

  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/merchOrder/merchOrder.do" >
        <b>輸入訂單編號:</b>
        <input type="text" name="merchNo">
        <input type="hidden" name="action" value="getByNo">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="merchOrderSvc" scope="page" class="com.service.MerchOrderService" />

  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/merchOrder/merchOrder.do" >
       <b>選擇訂單編號:</b>
       <select size="1" name="merchNo">
         <c:forEach var="merchOrder" items="${merchOrderSvc.all}" > 
          <option value="${merchOrder.merchNo}">${merchOrder.merchNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getByNo">
       <input type="submit" value="送出">
    </FORM>
  </li>

  <br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/merchOrder/merchOrder.do" >
        <b>輸入會員編號:</b>
        <input type="text" name="memId">
        <input type="hidden" name="action" value="getById">
        <input type="submit" value="送出">
    </FORM>
  </li>
 

 
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/merchOrder/merchOrder.do" >
       <b>選擇會員編號:</b>
       <select size="1" name="memId">
         <c:forEach var="merchOrder" items="${merchOrderSvc.all}" > 
          <option value="${merchOrder.mem.memId}">${merchOrder.mem.memId}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getById">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/merchOrder/merchOrder.do" >
        <b>輸入收貨人電話:</b>
        <input type="text" name="receiptMobile">
        <input type="hidden" name="action" value="getByMobile">
        <input type="submit" value="送出">
    </FORM>
  </li>

</ul>






</div>


</body>
</html>