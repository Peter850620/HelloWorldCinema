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
pageContext.setAttribute("list", list);
%>

<%Merch merch = (Merch) request.getAttribute("merch"); %>
<%Cart cart = (Cart) request.getAttribute("cart"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <title>周邊商城</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/front_end/merch/css/merchStore.css" />
</head>
<body>

<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />

<div>
    <h2>周邊商城</h2>
<!--     <div class="shopping"> -->
<!--                 <i class='bx bx-cart' id='cart-button' class="trigger cart-button-style" name="action" value="getById"></i> -->
<!-- <!--                 <span class="quantity">0</span> --> -->
<!--             </div> -->

    <div id="shop" class="horizontal-products">
        <c:forEach var="merch" items="${list}">
            <div class="products">
                <a href="<%= request.getContextPath() %>/merch/merch.do?action=getOneMerch&merchId=${merch.merchId}">
                    <img class="product-image" src="<%= request.getContextPath() %>/merch/MerchGifReader?merchId=${merch.merchId}" alt="Image">
                    <p class="product-name"><span>${merch.merchName}</span></p>
                    <p class="product-price">售價:$<span>${merch.merchPrice}</span></p>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" />

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
                        <td id="merchtotal"></td>
                    </tr>
                    <tr id="promo-checkout">
                        <td><button id="checkout">結帳</button></td>
                        <td><button id="ks" class="keep-shopping">繼續購物</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
$(document).ready(function () {
    var memberId = '<%= session.getAttribute("memId") %>';

    $('#cart-button').click(function (e) {
        e.preventDefault();
        $('#cart-wrapper').toggleClass('close');
        fetchCartItems();
    });

    $('.add-to-cart').click(function () {
        var productId = $(this).data('id');
        var productName = $(this).data('name');
        var productPrice = $(this).data('price');
        var quantity = 1; // Change this to get the desired quantity

        addToCart(memberId, productId, productName, productPrice, quantity);
    });

    function addToCart(memberId, productId, productName, productPrice, quantity) {
        fetch('/merch/cart/insert', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                memId: memberId,
                merchId: productId,
                merchName: productName,
                merchPrice: productPrice,
                merchQty: quantity
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            console.log('Response from server:', data);
            fetchCartItems();
        })
        .catch(error => {
            console.error('Error adding to cart:', error);
        });
    }

    function removeFromCart(productId) {
        fetch("/merch/cart/removeCart?memId=" + memberId + "&merchId=" + productId, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            console.log('商品已從購物車中移除', data);
            fetchCartItems();
        })
        .catch(error => console.error('Error removing item from cart:', error));
    }

    function updateCartItemQty(memId, merchId, quantity) {
        fetch("/merch/cart/updateQty?memId=" + memId + "&merchId=" + merchId + "&newQty=" + quantity, {
            method: 'POST'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            console.log('Response from server:', data);
            fetchCartItems();
        })
        .catch(error => console.error('Error updating cart item quantity:', error));
    }

    function setupCartItemQuantityListeners() {
        $(document).on('input', '.cart-item-qty-input', function () {
            var merchId = $(this).data('merch-id');
            var quantity = parseInt($(this).val());
            updateCartItemQty(memberId, merchId, quantity);
        });
    }

    setupCartItemQuantityListeners();

    function fetchCartItems() {
        fetch("/merch/cart/cartItems?memId=" + memberId, {
            method: 'GET'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            console.log('Cart items:', data);
            updateCartTable(data);
        })
        .catch(error => {
            console.error('Error fetching cart items:', error);
        });
    }

    function updateCartTable(cartItems) {
        var cartTableBody = $('#cart-table-body');
        cartTableBody.empty();
        var total = 0;

        cartItems.forEach(function (item) {
            var row = $('<tr>');
            row.append($('<td>').text(item.merchName));

            var qtyInput = $('<input type="number" min="1" class="cart-item-qty-input" value="' + item.merchQty + '" data-merch-id="' + item.merchId + '">');
            row.append($('<td>').css('width', '5px').append(qtyInput));

            row.append($('<td>').text(item.merchPrice));

            var subtotal = item.merchQty * item.merchPrice;
            total += subtotal;

            row.append($('<td>').text(subtotal));

            row.append($('<td>').append($('<button>').text('移除').click(function () {
                removeFromCart(item.merchId);
            })));

            cartTableBody.append(row);
        });

        $('#merchtotal').text(total);
    }
});
</script>
</body>
</html>
