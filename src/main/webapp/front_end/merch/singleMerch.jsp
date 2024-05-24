<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="com.controller.*"%>
<%@ page import="com.service.*"%>

<%Merch merch = (Merch)request.getAttribute("merch");%>
<%Cart cart = (Cart)request.getAttribute("cart");%>



<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    
    <!-- 主要css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/merch/css/singleMerch.css" />
</head>
<body>
<jsp:include page="/front_end/index/indexHeader.jsp" flush="true" />  
<!-- ========================以下區域可放置其他內容======================== -->

<button id='cart-button' class="trigger cart-button-style">查看購物車</button>
<div class="card-wrapper">
    <div class="card">
        <!-- card left -->
        <div class="product-imgs">
            <div class="img-display">
                <img src="<%=request.getContextPath()%>/merch/MerchGifReader?merchId=${merch.merchId}" alt="Image">
            </div>
        </div>
        <!-- card right -->
        <div class="products" id="${merch.merchId}">
            <h2 class="product-title">${merch.merchName}</h2>
            <div class="product-detail">
                <h2>商品介紹: </h2>
                <p><span>${merch.merchInfo}</span></p>
                <ul>
                    <li>宅配配送區域: <span>台澎金馬</span></li>
                    <li>宅配運費: <span>視距離而定，貨到付款</span></li>
                </ul>
            </div>
            <div class="product-price">
                <p class="price">Price: <span id="merchPrice">${merch.merchPrice}</span></p>
            </div>
            <!-- 加入購物車按鈕 -->
			<div class="page-wrapper">
			    <input id="quantityInput" type="number" min="1" value="1">
			    <input id="memId" type="hidden" value="240001">
			    <input id="productId" type="hidden" name="action" value="getById">
			   	<button id='add-to-cart' class="add-to-cart">加入購物車</button>
	
			</div>
        </div>
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
                    <tr id='subtotal-wrapper'>
                        <td id="subtotal-label">合計:</td>
                        <td id="subtotal">${cartTotal}</td>
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
	<script>
	$(document).ready(function () {
		
		var memId = $('#memId').val();
        var productId = "${merch.merchId}";
        var productName = "${merch.merchName}";
        var productPrice = parseInt($('#merchPrice').text());
		
	    $('#cart-button').click(function (e) {
	        e.preventDefault(); // 防止預設行為
	        $('#cart-wrapper').toggleClass('close');

	        // 在點擊購物車按鈕時，重新載入購物車內容
	        fetchCartItems(); // 假設這是一個獲取購物車內容的函數

	    });

// 	    加入商品至購物車
	    $('.add-to-cart').click(function () {
	        
	        var quantity = parseInt($('#quantityInput').val());
	       
	        addToCart(memId, productId, productName, productPrice, quantity);
	    });



	    function addToCart(memId, productId, productName, productPrice, quantity) {
	        fetch('cart/insert',{
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({
	                memId: memId,
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
	            return response.text(); // Assuming the response is a plain text
	        })
	        .then(data => {
	            console.log('Response from server:', data);
	            // Handle success or error response here
	            // 在點擊購物車按鈕時，重新載入購物車內容
	        	fetchCartItems(); // 假設這是一個獲取購物車內容的函數
	        })
	        .catch(error => {
	            console.error('Error adding to cart:', error);
	            // Handle error here
	        });

	        
	    }

	
	    
	    

	 // 從購物車移除商品
	    function removeFromCart(productId) {
	    	
	        fetch("cart/removeCart?memId=240001&merchId=" + productId, {
	            method: 'Post'
	        })
	        .then(response => response.json())
	        .then(data => {
	            console.log('商品已從購物車中移除', data);
	            fetchCartItems(); // 重新獲取購物車內容
	        })
	        .catch(error => console.error('Error removing item from cart:', error));
	    }

	   

	    
	    
	    
	 // 設置購物車項目數量變動的監聽器
	    setupCartItemQuantityListeners();  
	 

	    
			 // 更新購物車項目的數量
			    function updateCartItemQty(memId, merchId, merchQty) {
		    fetch(`cart/updateQty?memId=${memId}&merchId=${merchId}&merchQty=${merchQty}`, {
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


			 // 設置購物車項目數量變動的監聽器
			    function setupCartItemQuantityListeners() {
			        $(document).on('input', '.cart-item-qty-input', function () {
			            var merchId = $(this).data('merch-id'); // 使用商品ID
			            var newQty = parseInt($(this).val());
			            updateCartItemQty(memId, merchId, merchQty); // 更新購物車項目數量
			        });
			    }


	    
	    
	    
	    
	    
	    
	    

// 	    查看購物車
	    function fetchCartItems() {
		    fetch('cart/cartItems?memId=240001', {
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



// 		更新購物車
	    function updateCartTable(cartItems) {
	        var cartTableBody = $('#cart-table-body');
	        cartTableBody.empty();

	        cartItems.forEach(function (item) {
	            var row = $('<tr>');
	            row.append($('<td>').text(item.merchName));
	            var qtyInput = $('<input type="number" min="1" value="' + item.merchQty + '">');
	            qtyInput.on('input', function () {
	                updateCartItemQty(item.merchId, parseInt($(this).val()));
	            });
	            row.append($('<td>').append(qtyInput));
	            row.append($('<td>').text(item.merchPrice));
	            row.append($('<td>').text(item.merchQty * item.merchPrice));
	            row.append($('<td>').append($('<button>').text('移除').click(function () {
	                removeFromCart(item.merchId);
	            })));

	            cartTableBody.append(row);
	        });

	        var subtotal = cartItems.reduce(function (total, item) {
	            return total + (item.merchQty * item.merchPrice);
	        }, 0);

	        $('#subtotal').text(subtotal.toFixed(2));
	    }
	    
	    
	   
	    
	    

	    $('#checkout').click(function () {
	        // 獲取購物車資訊
	        fetch('cart/cartItems?memId=240001', {
	            method: 'GET'
	        })
	        .then(response => {
	            if (!response.ok) {
	                throw new Error('Network response was not ok');
	            }
	            return response.json();
	        })
	        .then(cartItems => {
	            console.log('Cart items:', cartItems);
	            // 將購物車資訊轉為JSON字符串
	            var cartInfo = JSON.stringify(cartItems);
	            // 使用localStorage將購物車資訊存儲，以便在跳轉頁面時使用
	            localStorage.setItem('cartInfo', cartInfo);
	            // 跳轉到結帳頁面
	            window.location.href = '<%=request.getContextPath()%>/front_end/merch/addMerchOrder.jsp'; // 修改為實際的結帳頁面URL
	        })
	        .catch(error => {
	            console.error('Error fetching cart items:', error);
	        });
	    });


	    $('#ks').click(function () {
	        $('.slider').toggleClass('close');
	    });
	});

	
	
	
	   
	</script>
	<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" /> 
</body>
</html>