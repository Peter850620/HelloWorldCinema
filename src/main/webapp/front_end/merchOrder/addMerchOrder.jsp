<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%MerchOrder merchOrder = (MerchOrder)request.getAttribute("merchOrder");%>

<%MerchItem merchItem = (MerchItem)request.getAttribute("merchItem");%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 主要css -->
    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/movie/css/movieInfo.css" />
</head>
<body>

<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />    
<!-- ========================以下區域可放置其他內容======================== -->

<div class="container">
    <h1>新增票種</h1>
    <h4><a href="<%=request.getContextPath()%>/back_end/ticket/select_page.jsp">回到票種管理</a></h4>
    
    <%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	    
    
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/merchOrder/merchOrder.do" name="form1">
        <table>
            
            <tr>
                <td>取貨方式:</td>
                <td><select name="pickupOption" required>
                        <option value="現場取貨">現場取貨</option>
                        <option value="宅配">宅配</option>
                    </select>
                </td>
            </tr>
             <tr>
                <td>付款方式:</td>
                <td><select name="paymentType" required>
                        <option value="線上付款">線上付款</option>
                        <option value="匯款">匯款</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>收貨人:</td>
                <td><input type="TEXT" name="recipient" value="<%= (merchOrder==null)? "" : merchOrder.getRecipient()%>" size="35"/></td>
            </tr>
            <tr>
                <td>收貨人地址:</td>
                <td><input type="TEXT" name="receiptAddr" value="<%= (merchOrder==null)? "" : merchOrder.getReceiptAddr()%>" size="45"/></td>
            </tr>
            <tr>
                <td>收貨人電話:</td>
                <td><input type="TEXT" name="receiptMobile" value="<%= (merchOrder==null)? "" : merchOrder.getReceiptMobile()%>" size="35"/></td>
            </tr>
            
        
        
        </table>
        <br>
        <input type="hidden" name="action" value="insert">
        <input type="submit" value="結帳"></FORM>
  </div>




<!-- ========================以上區域可放置其他內容======================== -->

<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />  


    
   
    
    <!-- 主要js -->
    <script src="<%=request.getContextPath()%>/front_end/movie/js/singleMovie.js"></script>
    
</body>
</html>