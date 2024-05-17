<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>


<%
String tkName = request.getParameter("tkName");

    // Use tkName to fetch merchOrder data
    TicketService_13 ticketSvc = new TicketService_13();
    List<Ticket> list = ticketSvc.getByName(tkName);
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
        <h1>所有票種</h1>
        <h4><a href="<%=request.getContextPath()%>/back_end/ticket/select_page.jsp">回到票種管理</a></h4>

        <br>
        <table>
          <tr>
            <th>票種編號</th>
            <th>票種名稱</th>
            <th>票種介紹</th>
            <th>票種價格</th>
            <th>票種狀態</th>
            <th>修改</th>
          </tr>
          <c:forEach var="ticket" items="${list}">
	          <tr>
	            <td>${ticket.tkId}</td>
	            <td>${ticket.tkName}</td>
	            <td>${ticket.tkInfo}</td>
	            <td>${ticket.tkPrice}</td>
	            <td>${ticket.tkStatus}</td>
	            <td>
                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket/ticket.do" style="margin-bottom: 0px;">
                    <input type="submit" value="修改">
                    <input type="hidden" name="tkId"  value="${ticket.tkId}">
			    	<input type="hidden" name="action"	value="getOne_For_Update">
                </FORM>
            	</td>	
         	</tr>
         </c:forEach>
    </table>
    
	    

      </div>


</body>

</html>