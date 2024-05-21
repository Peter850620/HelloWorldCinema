// Cart Toggle
let cartToggle = document.getElementById('cart-button');
let cartToggleCount = 0;
let cartWrapper = document.getElementById('cart-wrapper');
let cartElement = document.getElementById('cart');
let subtotal = document.getElementById('subtotal');
let applyPromoButton = document.querySelector('#apply-promo');
let addToCartButton = document.querySelectorAll('.add-to-cart');



let cartProductQuantity = "<input name='quantity' id='quantity-value' type='number' value='1'>";

let productRemove = "<button class='remove' onclick='removeFromCart(this)'>X</button>";

let updatedPrice;
let added = [], itemClass = {};

 // Capture HTML cart body
var cartTableBody = document.getElementById('cart-table-body');

// Cart object model
let cart = {
    'items': [],
    "subtotal": 0,
	
};

for (let button of addToCartButton) {
    button.addEventListener('click', addToCart);
}


$('.trigger, .keep-shopping').click(function() {
  $('.slider').toggleClass('close');
});

// Adding products to the shopping cart
function addToCart(event) {
    
    if (added.includes(event.target.parentElement.id)) {
        duplicateId = '#' + event.target.parentElement.id;
        
        cartTableBody.querySelector(duplicateId).querySelector('#quantity-value').value++;
        return;
    }
    
    // Capture product
    let product = event.target.parentNode;
    let productId = product.id;
    added.unshift(productId);
    let productName = product.querySelector('.product-name').innerHTML;
    let productPrice = product.querySelector('.product-price').innerHTML.replace(/[^\d.-]/g, '');
    productPrice = Number(productPrice);
    let productUpdatedPrice = productPrice;
    
    thisClass = product.classList.value.split(' ');
/*
    thisClass = thisClass.replace('products ', '');
*/
    
    itemClass[productId] = thisClass;
    
    // Add item to cart javascript model
    cart.items.push({
		'product': productId,
		'productName': productName,
		'productPrice': productPrice,
		'productUpdatedPrice': productUpdatedPrice,
	});
    
    
    // Add a new row for each product
    let productRow = document.createElement('tr');
    productRow.setAttribute('id', productId);
    cartTableBody.appendChild(productRow);
    
    // Add five columns to product row
    for (let num = 0; num <= 6; num++) {
        let newColumn = document.createElement('td');
        productRow.appendChild(newColumn);
    }
            
    // Build HTML cart
    productRow.childNodes[0].innerHTML = productName;
    productRow.childNodes[1].innerHTML = cartProductQuantity;
    productRow.childNodes[1].setAttribute('id', 'quantity');
    productRow.childNodes[2].innerHTML = productPrice;
    productRow.childNodes[2].setAttribute('id', 'product-price');
    productRow.childNodes[2].setAttribute('class', 'cart-product-price');
    productRow.childNodes[3].innerHTML = productPrice;
    productRow.childNodes[3].setAttribute('id', 'updated-product-price');
    productRow.childNodes[3].setAttribute('class', 'cart-updated-product-price');
    productRow.childNodes[4].innerHTML = productRemove;
    
    
    
    updateSubtotal();
    
    
    $('.slider').toggleClass('close');
    
}


// 移除商品
function removeFromCart(event) {
    let parentRow = event.parentNode.parentNode;
    let parentBody = parentRow.parentNode;
    let parentRowId = parentRow.id;

    // 獲取要移除的產品的更新後價格
    let updatedPrice = parseFloat(parentRow.querySelector('#updated-product-price').innerHTML);

    // 從總價中減去被移除產品的價格
    cart.subtotal -= updatedPrice;

    // 更新 HTML 中的總價顯示
    subtotal.innerHTML = cart.subtotal.toFixed(2);

    // 從購物車項目中移除被移除的產品
    for (let i = 0; i < cart.items.length; i++) {
        if (cart.items[i].product === parentRowId) {
            cart.items.splice(i, 1);
            break;
        }
    }

    // 從已加入的產品列表中移除被移除的產品 ID
    let index = added.indexOf(parentRowId);
    if (index !== -1) {
        added.splice(index, 1);
    }

    // 移除 HTML 中對應的行
    parentBody.removeChild(parentRow);
}


// 小計金額隨商品數量增減
function updateQuantity(event) {
    let parentRow = event.parentNode.parentNode;
    let parentRowId = parentRow.id;
    var inputQuantity, productPrice, updatedPrice, totalPrice;

    for (let node of parentRow.childNodes) {
        switch (node.id) {
            case 'quantity':
                inputQuantity = node.firstChild;
                break;

            case 'product-price':
                productPrice = Number(node.innerHTML);
                break;

            case 'updated-product-price':
                updatedPrice = node;
                totalPrice = Number(node.innerHTML);
        }
    }

    let inputQuantityValue = Number(inputQuantity.value);

    if (inputQuantityValue <= 0) removeFromCart(event);

    totalPrice = inputQuantityValue * productPrice;
    updatedPrice.innerHTML = Math.round(totalPrice);

    for (let item of cart.items) {
        if (item.product === parentRowId) item.productUpdatedPrice = totalPrice;
    }

    updateSubtotal();
    
    console.log(cart);
}

// 監聽數量輸入框的變化
document.addEventListener('input', function (event) {
    if (event.target && event.target.id === 'quantity-value') {
        updateQuantity(event.target);
    }
});




// 總計價格顯示
function updateSubtotal() {
    cart.subtotal = 0;
    
    for (let item of cart.items) {
        cart.subtotal += item.productUpdatedPrice;
    }
    
    subtotal.innerHTML = cart.subtotal.toFixed(2);
}





