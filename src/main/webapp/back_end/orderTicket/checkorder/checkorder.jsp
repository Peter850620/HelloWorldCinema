<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.dao.*"%>
<%@page import="com.entity.*"%>
<%@page import="com.service.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>世界影城 HelloWorld Cinema</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen1/screen1.css">
<style>
</style>
</head>

<jsp:include page="/back_end/orderTicket/index/indexHeader.jsp" flush="true" />

<body>
    <div class="theatre">
        <div class="screen-side">
            <div class="screen"></div>
            <h3 class="select-text">購物清單</h3>
            <div id="shoppingList"></div>
        </div>

        <div style="text-align: center;">
            <button id="lastButton">上一步</button>
            <button type="button" id="nextButton">下一步</button>
        </div>
    </div>

    <script>
        // 初始化 sessionStorage 數據
        sessionStorage.setItem('cart', JSON.stringify({
            "items": [
                {"id": "104", "name": "雞米花", "price": 50, "quantity": 1, "totalPrice": 50},
                {"id": "103", "name": "炸雞", "price": 60, "quantity": 1, "totalPrice": 60}
            ],
            "subtotal": 0
        }));

        sessionStorage.setItem('ticketcart', JSON.stringify({
            "items": [
                {"id": "1", "name": "全票", "price": 300, "quantity": 1, "totalPrice": 300},
                {"id": "2", "name": "優待票", "price": 250, "quantity": 1, "totalPrice": 250}
            ],
            "subtotal": 0
        }));
        console.log('Cart from sessionStorage:', sessionStorage.getItem('cart'));
        console.log('TicketCart from sessionStorage:', sessionStorage.getItem('ticketcart'));

        document.addEventListener('DOMContentLoaded', function(event) {
            

            let cart, ticketCart;
            try {
                cart = JSON.parse(sessionStorage.getItem('cart'));
                ticketCart = JSON.parse(sessionStorage.getItem('ticketcart'));
            } catch (error) {
                console.error('Error parsing JSON from sessionStorage:', error);
            }

            console.log('Cart:', cart);
            console.log('Ticket Cart:', ticketCart);

            let shoppingList = document.getElementById('shoppingList');

            if (ticketCart && ticketCart.items && ticketCart.items.length > 0) {
                let ticketItems = '<h4>票券購物車</h4><ul>';
                
                ticketCart.forEach((item,index) => {
                	const name=item.name;
                	const price=item.price;
                	const quantity=item.quantity;
                    ticketItems += `<li>${name} - ${price} x ${quantity} </li>`;
                });
                ticketItems += '</ul>';
                shoppingList.innerHTML += ticketItems;
            } else {
                shoppingList.innerHTML += '<h4>票券購物車</h4><p>購物車內沒有票券</p>';
            }

            if (cart && cart.items && cart.items.length > 0) {
                let cartItems = '<h4>食物購物車</h4><ul>';
                cart.items.forEach(item => {
                    cartItems += `<li>${item.name} - ${item.price} x ${item.quantity} = ${item.totalPrice}</li>`;
                });
                cartItems += '</ul>';
                shoppingList.innerHTML += cartItems;
            } else {
                shoppingList.innerHTML += '<h4>食物購物車</h4><p>購物車內沒有食物</p>';
            }
        });

        const nextButton = document.getElementById('nextButton');
        nextButton.addEventListener('click', function(event) {
            event.preventDefault();  // 阻止默認提交行為
            console.log('Default form submission prevented.');

            const contextPath = '<%=request.getContextPath()%>';
            console.log('Context path:', contextPath);

            window.location.href = contextPath + '/back_end/orderTicket/checkorder/checkorder.jsp';
        });
    </script>

</body>
<jsp:include page="/back_end/orderTicket/index/indexFooter.jsp" flush="true" />
</html>
