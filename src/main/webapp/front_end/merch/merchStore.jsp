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

        <button id='cart-button' class="trigger cart-button-style">查看購物車</button>

        <div id="shop" class="horizontal-products">
            <c:forEach var="merch" items="${list}">
                <div class="products">
                    <a href="<c:url value='/merch/merchId/${merch.merchId}'/>">
                        <img class="product-image" src="${merch.merchImg}" alt="商品圖片">
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
                <tbody id="cart-table-body">

				</tbody>
            </table>
        </div>
    </div>
    <div id='amount-controls'>
        <div id="cart-amount-wrapper">
            <table>
                <tbody>
                    <tr id='subtotal-wrapper'>
                        <td id="subtotal-label">合計:</td>
                        <td id="subtotal">0</td>
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

<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />  


    
    <!-- 電影瀏覽 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.0/axios.min.js" integrity="sha512-DZqqY3PiOvTP9HkjIWgjO6ouCbq+dxqWoJZ/Q+zPYNHmlnI2dQnbJ5bxAHpAMw+LXRm4D72EIRXzvcHQtE8/VQ==" crossorigin="anonymous"></script>


    
</body>
</html>