<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>


<%
MerchServiceYuan merchSvc = new MerchServiceYuan();
	List<Merch> list = merchSvc.getByStatus("上架");
    pageContext.setAttribute("list",list);
%>

<%Merch merch = (Merch)request.getAttribute("merch");%>
<%Cart cart = (Cart)request.getAttribute("cart");%>


<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 主要css -->
    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/merch/css/merchStore.css" />
</head>
<body>

<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />    
<!-- ========================以下區域可放置其他內容======================== -->

	<div>
        <h2>周邊商城</h2>

        <button id='cart-button' class="trigger cart-button-style" name="action" value="getById">查看購物車</button>


        <div id="shop" class="horizontal-products">
            <c:forEach var="merch" items="${list}">
                <div class="products">
                    <a href="<%=request.getContextPath()%>/merch/merch.do?action=getOneMerch&merchId=${merch.merchId}">
                        <img class="product-image" src="<%=request.getContextPath()%>/merch/MerchGifReader?merchId=${merch.merchId}" alt="Image">
                        <p class="product-name"><span>${merch.merchName}</span></p>
                        <p class="product-price">售價:$<span>${merch.merchPrice}</span></p>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>


<!-- 查看購物車 -->
<div id='cart-wrapper' class="slider close">
    <div id='cart'>
        <div id="cart-products-wrapper">
            <table id="cart-table">
                <thead id="cart-table-header">
                    <tr>
                        <th class="name-col">商品名稱</th>
                        <th class="quantity-col">數量</th>
                        <th class="price-col">價格</th>
                        <th class="updated-price-col">小計</th>
                        <th class="remove-col">移除</th>
                    </tr>
                </thead>
                <tbody id="cart-table-body"></tbody>

            </table>
        </div>
    </div>
    <div id='amount-controls'>
        <div id="cart-amount-wrapper">
            <table>
                <tbody>
                    <tr id='merchtotal-wrapper'>
                        <td id="merchtotal-label">合計:</td>
                        <td id="merchtotal">${cartTotal}</td>
                    </tr>
                    <tr id="promo-checkout">
                        <td><button id="checkout">結帳</button></td>
                        <td><button id="ks" class="keep-shopping">繼續購物</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>



<!-- ========================以上區域可放置其他內容======================== -->
     

  
    <!-- 主要js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- 添加jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<!-- 商品資料加到購物車 -->
	<script src="<%=request.getContextPath()%>/front_end/merch/js/cart.js"></script>
	
	<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" /> 
</body>
</html>