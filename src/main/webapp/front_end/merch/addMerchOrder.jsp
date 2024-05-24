<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%Mem mem = (Mem)request.getAttribute("mem");%>

<%MerchOrder merchOrder = (MerchOrder)request.getAttribute("merchOrder");%>

<%MerchItem merchItem = (MerchItem)request.getAttribute("merchItem");%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 主要css -->
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/merch/css/ticket.css">
</head>
<body>

<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />    
<!-- ========================以下區域可放置其他內容======================== -->

<div class="container">

	<h1>購物車明細</h1>
	<br>
    <h4><a href="<%=request.getContextPath()%>/front_end/merch/merchStore.jsp">回到上一頁</a></h4>
    
    <%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<br>    
    <div id="cartItems"></div>
    <br>
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
                <td><input type="TEXT" name="recipient" value="<%= (mem==null)? "" : mem.getMemName()%>" size="35"/></td>
            </tr>
            <tr>
                <td>收貨人地址:</td>
                <td><input type="TEXT" name="receiptAddr" value="<%= (mem==null)? "" : mem.getMemAddr()%>" size="45"/></td>
            </tr>
            <tr>
                <td>收貨人電話:</td>
                <td><input type="TEXT" name="receiptMobile" value="<%= (mem==null)? "" : mem.getMemMobile()%>" size="35"/></td>
            </tr>
            
        
        
        </table>
        <br>
        <input type="hidden" name="action" value="insert">
        <input type="submit" value="結帳"></FORM>
  </div>




<!-- ========================以上區域可放置其他內容======================== -->

<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />  

	<script>
        document.addEventListener("DOMContentLoaded", function() {
            var cartItems = localStorage.getItem("cartItems");
            if (cartItems) {
                var parsedCartItems = JSON.parse(cartItems);
                var cartItemsDiv = document.getElementById("cartItems");

                parsedCartItems.forEach(function(item, index) {
                    var itemElement = document.createElement("div");
                    console.log("cartItems");
                    itemElement.innerHTML = `
                        <p>商品名稱：${item.merchName}</p>
                        <p>商品數量：${item.merchQty}</p>
                        <p>商品價格：${item.merchPrice}</p>
                    `;
                    cartItemsDiv.appendChild(itemElement);
                });
            }
        });
    </script>
    
</body>
</html>