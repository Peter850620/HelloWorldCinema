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
<h1 class="first">票種管理</h1>
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
  <li><a href="<%=request.getContextPath()%>/back_end/ticket/listAllTicket.jsp">顯示全部資料</a></li>
  <br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket/ticket.do" >
        <b>輸入票種編號:</b>
        <input type="text" name="tkId">
        <input type="hidden" name="action" value="getById">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="ticketSvc" scope="page" class="com.service.TicketServiceYuan" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket/ticket.do" >
       <b>選擇票種編號:</b>
       <select size="1" name="tkId">
         <c:forEach var="ticket" items="${ticketSvc.all}" > 
          <option value="${ticket.tkId}">${ticket.tkId}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getById">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket/ticket.do" >
        <b>輸入票種名稱:</b>
        <input type="text" name="tkName">
        <input type="hidden" name="action" value="getByName">
        <input type="submit" value="送出">
    </FORM>
  </li>

   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket/ticket.do" >
       <b>選擇票種名稱:</b>
       <select size="1" name="tkName">
         <c:forEach var="ticket" items="${ticketSvc.all}" > 
          <option value="${ticket.tkName}">${ticket.tkName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getByName">
       <input type="submit" value="送出">
    </FORM>
  </li>
  

</ul>

	<br>


	<ul>
	  <li><a href='<%=request.getContextPath()%>/back_end/ticket/addTicket.jsp'>Add</a>新增票種</li>
	</ul>
	
	</div>


</body>
</html>