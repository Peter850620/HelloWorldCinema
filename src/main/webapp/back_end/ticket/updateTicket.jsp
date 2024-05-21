<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%Ticket ticket = (Ticket)request.getAttribute("ticket");%>

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
    <h1>修改票種</h1>
    <h4><a href="<%=request.getContextPath()%>/back_end/ticket/listAllTicket.jsp">回到票種管理</a></h4>
    
    <%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
    
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket/ticket.do" name="form1">
        <table>
            
            <tr>
                <td>票種名稱:</td>
                <td><input type="TEXT" name="tkName" value="<%= (ticket==null)? "" : ticket.getTkName()%>" size="35"/></td>
            </tr>
            <tr>
                <td>票種介紹:</td>
                <td><input type="TEXT" name="tkInfo" value="<%= (ticket==null)? "" : ticket.getTkInfo()%>" size="60"/></td>
            </tr>
            <tr>
                <td>票種價格:</td>
                <td><input type="NUMBER" name="tkPrice" value="<%= (ticket==null)? "" : ticket.getTkPrice()%>" size="45"/></td>
            </tr>
            <tr>
                <td>票種狀態:</td>
                <td><select name="tkStatus" required>
                        <option value="下架">下架</option>
                        <option value="上架">上架</option>
                    </select>
                </td>
            </tr>
        
        
        </table>
        <br>
        <input type="hidden" name="tkId"  value="${ticket.tkId}">
        <input type="hidden" name="action" value="update">
        <input type="submit" value="送出修改"></FORM>
  </div>
  
 
</body>
</html>


    