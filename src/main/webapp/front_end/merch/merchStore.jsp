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
<jsp:include page="/front_end/index/indexFooter.jsp" flush="true" /> 	

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
	<script>
	$(document).ready(function () {
		// 從 session 中獲取 memId

		var memberId = "${memId}";
        var productId = "${merch.merchId}";
        var productName = "${merch.merchName}";
        var productPrice = parseInt($('#merchPrice').text());
        
// 		展開購物車
	    $('#cart-button').click(function (e) {
	        e.preventDefault(); // 防止預設行為
	        $('#cart-wrapper').toggleClass('close');

	        // 在點擊購物車按鈕時，重新載入購物車內容
	        fetchCartItems();

	    });

// 	    加入商品至購物車
	    $('.add-to-cart').click(function () {
	        
	    	var quantity = parseInt($('#quantityInput').val());
	       
	        addToCart(memberId, productId, productName, productPrice, quantity);
	    });



	    function addToCart(memberId, productId, productName, productPrice, quantity) {
	        fetch('/merch/cart/insert',{
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
	    	
	        fetch("/merch/cart/removeCart?memId=" + memberId + "&merchId=" + productId, {
	            method: 'Post'
	        })
	        .then(response => response.json())
	        .then(data => {
	            console.log('商品已從購物車中移除', data);
	            fetchCartItems(); // 重新獲取購物車內容
	        })
	        .catch(error => console.error('Error removing item from cart:', error));
	    }

	   

	    
	    
	    

	 

	    

			// 更新購物車商品項目的數量
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



			 // 設置購物車項目數量變動的監聽器
			    function setupCartItemQuantityListeners() {
			        $(document).on('input', '.cart-item-qty-input', function () {
			    		var memId = '<%= session.getAttribute("memId") %>';
			            var merchId = $(this).data('merch-id'); // 使用商品ID
			            var quantity = parseInt($(this).val());
			            console.log(quantity);
			            updateCartItemQty(memId, merchId, quantity); // 更新購物車項目數量
			        });
			    }

			    setupCartItemQuantityListeners();
	    
	    
	    
	    
	    
	    
	    

// 	    查看購物車，將資料庫內容炫染至購物車畫面上
	    function fetchCartItems() {
	console.log(memberId)
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



// 		更新購物車
	    function updateCartTable(cartItems) {
	        var cartTableBody = $('#cart-table-body');
	        cartTableBody.empty();

	        var total = 0;
	        var subtotals = {};
	        
	        cartItems.forEach(function (item) {
	            var row = $('<tr>');
	            row.append($('<td>').text(item.merchName));
	            
	            var qtyInput = $('<input type="number" min="1" class="cart-item-qty-input" value="' + item.merchQty + '" data-merch-id="' + item.merchId + '">');
	            
	            row.append($('<td>').css('width', '5px').append(qtyInput));
	            
	            row.append($('<td>').text(item.merchPrice));
	            
	            var subtotal = item.merchQty * item.merchPrice;
	            total += subtotal
	            subtotals[item.merchId] = subtotal;
	            
	            row.append($('<td>').text(subtotal));
	            
	            row.append($('<td>').append($('<button>').text('移除').click(function () {
	            	
	                removeFromCart(item.merchId);
	            })));

	            cartTableBody.append(row);
	        });

	        

	        $('#merchtotal').text(total);
	        
	        
	        
	        var cartInfo = {
			        cartItems: cartItems,
			        subtotals: subtotals,
			        total: total
			    };
			    localStorage.setItem('cartInfo', JSON.stringify(cartInfo));
	    }
	    
	    
	   
	    
	    
// 		結帳
	    $('#checkout').click(function () {
	        // 獲取購物車資訊
	        fetch('/merch/cart/cartItems?memId=' + memberId, {
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
	            

	            // 跳轉到結帳頁面
	            window.location.href = '<%=request.getContextPath()%>/front_end/merch/addMerchOrder.jsp'; // 修改為實際的結帳頁面URL
	        })
	        .catch(error => {
	            console.error('Error fetching cart items:', error);
	        });
	    });


// 		繼續購物
	    $('#ks').click(function () {
	        $('.slider').toggleClass('close');
	    });
	});

	
	</script>
	

</body>

</html>