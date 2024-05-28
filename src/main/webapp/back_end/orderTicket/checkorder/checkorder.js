// 初始化 sessionStorage 數據



document.addEventListener('DOMContentLoaded', function(event) {
	let cart, ticketCart;
	try {
		let cartData = sessionStorage.getItem('cart');
		let ticketCartData = sessionStorage.getItem('ticketcart');

		console.log('Raw cart data from sessionStorage:', cartData);
		console.log('Raw ticket cart data from sessionStorage:', ticketCartData);

		cart = JSON.parse(cartData);
		ticketCart = JSON.parse(ticketCartData);
	} catch (error) {
		console.error('Error parsing JSON from sessionStorage:', error);
	}

	console.log('Parsed Cart:', cart);
	console.log('Parsed Ticket Cart:', ticketCart);

	let shoppingList = document.getElementById('shoppingList');
	if (!shoppingList) {
		console.error('shoppingList element not found');
		return;
	}

	// 處理票券購物車
	if (ticketCart && ticketCart.items && ticketCart.items.length > 0) {
		let items = ticketCart.items;  // 抽離 items 外層
		console.log(items);

		let ticketItems = '<h4>選購票券</h4><ul><input type="hidde" id="${screenId}">';
		
		items.forEach(item => {
			const ticketId = item.id;
			const ticketName = item.name;
			const ticketPrice = item.price;
			const ticketQuantity = item.quantity;
			const ticketTotalPrice = item.totalPrice;
			ticketItems += `<div>
                			
                			<span data-id="${ticketId}" style="display: none;" id="tkId${ticketId}" name="tkId${ticketId}">${ticketId}</span>
                            ${ticketName} - ${ticketPrice} 元 x ${ticketQuantity} 張 = ${ticketTotalPrice} 元
                			<input type="hidden" id="tkId${ticketId}" name="tkId${ticketId}">
                			<input type="hidden" id="tkId${ticketId}" name="">
                			
                			
                			<input type="hidden" id="merchId" name="merchId" value="${item.merchId}">      
	 						<input type="hidden" id="merchQty" name="merchQty" value="${item.merchQty}">
	 						<input type="hidden" id="merchSubTotal" name="merchSubTotal" value="${item.merchQty * item.merchPrice}">
                			
                        </div>`;
		});
		ticketItems += '<br></ul>';
		console.log(ticketItems);
		shoppingList.innerHTML += ticketItems;
	} else {
		shoppingList.innerHTML += '<h4>票券購物車</h4><p>購物車內沒有票券</p>';
	}

	// 處理食物購物車
	if (cart && cart.items && cart.items.length > 0) {
		let cartItems = '<h4>選購食物</h4><ul>';
		cart.items.forEach(item => {
			const foodId = item.id;
			const foodName = item.name;
			const foodPrice = item.price;
			const foodQuantity = item.quantity;
			const foodTotalPrice = item.totalPrice;
			cartItems += `<li>
                            <span data-id="${foodId}" style="display: none;">${foodId}</span>
                            ${foodName} - ${foodPrice} 元 x ${foodQuantity} 份 = ${foodTotalPrice} 元
                        </li>`;
		});
		cartItems += '</ul>';
		shoppingList.innerHTML += cartItems;
	} else {
		shoppingList.innerHTML += '<p>沒有選購食物</p>';
	}




});
document.getElementById('lastButton').addEventListener('click', function() {
	window.history.back();
});


// 讀取 sessionStorage 的 subtotal 值
var subtotal = sessionStorage.getItem('subtotal');
let total=document.getElementById("subtotal");
total.textContent = subtotal;

// 如果 subtotal 不為 null，將其顯示在頁面上
if (subtotal !== null) {
	document.querySelector('.screen-side span').textContent = subtotal + ' 元';
}


var paymentType = document.getElementById("paymentType");


// 獲取所有 type 為 submit 的 input 元素
var submitButtons = document.querySelectorAll("button[type='submit']");

// 遍歷所有 submit 按鈕元素
submitButtons.forEach(function(button) {
	// 將處理函數設置為按鈕的 onclick 事件處理函數
	button.onclick = function() {
		paymentType.value = button.value;
	};
});

// ============== 設定票種名稱 ==============



let storetkId1 = sessionStorage.getItem("全票");
let storetkId2 = sessionStorage.getItem("優待票");
let storetkId3 = sessionStorage.getItem("愛心票");
let storetkId4 = sessionStorage.getItem("敬老票");

let tkId1 = document.getElementById("tkId1");
let tkId2 = document.getElementById("tkId2");
let tkId3 = document.getElementById("tkId3");
let tkId4 = document.getElementById("tkId4");


if (storetkId1) {
	tkId1.value = storetkId1;

} else {
	tkId1.value = 0;
}

if (storetkId2) {
	tkId2.value = storetkId2;

} else {
	tkId2.value = 0;
}

if (storetkId3) {
	tkId3.value = storetkId3;

} else {
	tkId3.value = 0;
}

if (storetkId4) {
	tkId4.value = storetkId4;

} else {
	tkId4.value = 0;
}

// ============== 座位名稱 ==============

let storeSeats = sessionStorage.getItem("selectedSeats")
let seatNo = document.getElementById("seatNo");

if (storeSeats) {

}


