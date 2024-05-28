<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%MerchOrder merchOrder = (MerchOrder)request.getAttribute("merchOrder");%>

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
    <h4><a href="<%=request.getContextPath()%>/back_end/merchOrder/listAllMerchOrder.jsp">回到周邊商品訂單管理</a></h4>
    
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
                <td><select id="pickupOption" name="pickupOption" required>
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
                <td>出貨狀態:</td>
                <td><select name="receiptStatus" required>
                        <option value="未出貨">未出貨</option>
                        <option value="已出貨">已出貨</option>
                        <option value="已取消">已取消</option>
                    </select>
                </td>
            </tr>
            
            <tr>
                <td>收貨人:</td>
                <td><input type="TEXT" id="recipientRow" name="recipient" value="<%= (merchOrder==null)? "" : merchOrder.getRecipient()%>" size="35"/></td>
            </tr>
            <tr>
                <td>收貨地址:</td>
                <td><input type="TEXT" id="receiptAddrRow" name="receiptAddr" value="<%= (merchOrder==null)? "" : merchOrder.getReceiptAddr()%>" size="60"/></td>
            </tr>
            <tr>
                <td>收貨人電話:</td>
                <td><input type="TEXT" id="receiptMobileRow" name="receiptMobile" value="<%= (merchOrder==null)? "" : merchOrder.getReceiptMobile()%>" size="35"/></td>
            </tr>

        
        
        </table>
        <br>
        <input type="hidden" name="merchNo"  value="${merchOrder.merchNo}">
        <input type="hidden" name="action" value="update">
        <input type="submit" value="送出修改"></FORM>
  </div>
<script type="text/javascript">
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

if (pickupOption.value !== "宅配") {
    recipientRow.style.display = "none";
    receiptAddrRow.style.display = "none";
    receiptMobileRow.style.display = "none";
}
</script>  

</body>
</html>


    