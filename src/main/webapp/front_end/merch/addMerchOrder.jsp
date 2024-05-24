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
    <h4><a href="<%=request.getContextPath()%>/front_end/merch/merchStore.jsp">回到上一頁</a></h4>
    <br>
    <h1>你的訂單</h1>
    <br>
    <div id="cartItems"></div>
    <div id="subtotal"></div>
    <br>
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
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/merchOrder/merchOrder.do" name="form1">
        <table>
        	
            <tr>
                <td>取貨方式:</td>
                <td>
                    <select id="pickupOption" name="pickupOption" required>
                        <option value="現場取貨">現場取貨</option>
                        <option value="宅配">宅配</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>付款方式:</td>
                <td>
                    <select name="paymentType" required>
                        <option value="線上付款">線上付款</option>
                        <option value="匯款">匯款</option>
                    </select>
                </td>
            </tr>
            <tr id="recipientRow">
                <td>收貨人:</td>
                <td><input type="TEXT" name="recipient" value="<%= (mem==null)? "" : mem.getMemName()%>" size="35"/></td>
            </tr>
            <tr id="receiptAddrRow">
                <td>收貨人地址:</td>
                <td><input type="TEXT" name="receiptAddr" value="<%= (mem==null)? "" : mem.getMemAddr()%>" size="45"/></td>
            </tr>
            <tr id="receiptMobileRow">
                <td>收貨人電話:</td>
                <td><input type="TEXT" name="receiptMobile" value="<%= (mem==null)? "" : mem.getMemMobile()%>" size="35"/></td>
            </tr>
        </table>
        <br>
        <input type="hidden" id="merchTotal" name="merchTotal" value="">
        <input type="hidden" name="action" value="insert">
        <input type="submit" value="結帳">
    </FORM>
</div>

<!-- ========================以上區域可放置其他內容======================== -->

<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />  

<script>
document.addEventListener("DOMContentLoaded", function() {
    var cartInfoString = localStorage.getItem("cartInfo");
    var cartInfo = JSON.parse(cartInfoString);

    if (cartInfo && cartInfo.length > 0) {
        var cartItemsDiv = document.getElementById("cartItems");
        var subtotalDiv = document.getElementById("subtotal");
        var total = 0;

        cartInfo.forEach(function(item, index) {
//             console.log("Cart Info:", cartInfo);
//             console.log(item.merchPrice);
            var itemElement = document.createElement("div");
            itemElement.innerHTML = '商品名稱：' + item.merchName + '<br>' +
            '商品數量：' + item.merchQty + '<br>' +
            '商品價格：' + item.merchPrice + ' 元<br><br>';
            cartItemsDiv.appendChild(itemElement);

            // 计算总价格
            total += item.merchQty * item.merchPrice;
        });

        // 显示总价格
        subtotalDiv.textContent = "合計價格：" + total + " 元";
        document.getElementById("merchTotal").value = total;
    }

    // 取貨方式選擇事件監聽
    var pickupOption = document.getElementById("pickupOption");
    var recipientRow = document.getElementById("recipientRow");
    var receiptAddrRow = document.getElementById("receiptAddrRow");
    var receiptMobileRow = document.getElementById("receiptMobileRow");

    pickupOption.addEventListener("change", function() {
        if (pickupOption.value === "宅配") {
            recipientRow.style.display = "";
            receiptAddrRow.style.display = "";
            receiptMobileRow.style.display = "";
        } else {
            recipientRow.style.display = "none";
            receiptAddrRow.style.display = "none";
            receiptMobileRow.style.display = "none";
        }
    });

    // 初始化頁面
    if (pickupOption.value !== "宅配") {
        recipientRow.style.display = "none";
        receiptAddrRow.style.display = "none";
        receiptMobileRow.style.display = "none";
    }
});
</script>
</body>
</html>
