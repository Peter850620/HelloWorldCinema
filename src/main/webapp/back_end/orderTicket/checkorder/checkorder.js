document.addEventListener('DOMContentLoaded', function() {
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

	// 處理座位資料
	let selectedSeats = JSON.parse(sessionStorage.getItem('selectedSeats'));
	if (selectedSeats) {
		let seatNos = selectedSeats.join(',');
		let seatInput = document.createElement('input');
		seatInput.type = 'hidden';
		seatInput.id = 'seatNo';
		seatInput.name = 'seatNo';
		seatInput.value = seatNos;
		shoppingList.appendChild(seatInput);
	}

	// 處理票券購物車
	if (ticketCart && ticketCart.items && ticketCart.items.length > 0) {
		let items = ticketCart.items;
		console.log(items);

		let ticketItems = '<h4>選購票券</h4><ul>';

		items.forEach(item => {
			const ticketId = item.id;
			const ticketName = item.name;
			const ticketPrice = item.price;
			const ticketQuantity = item.quantity;
			const ticketTotalPrice = item.totalPrice;
			ticketItems += `<div>
                                ${ticketName} - ${ticketPrice} 元 x ${ticketQuantity} 張 = ${ticketTotalPrice} 元
                                <input type="hidden" id="tkId${ticketId}" name="tkId${ticketId}" value="${ticketQuantity}">
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
                            ${foodName} - ${foodPrice} 元 x ${foodQuantity} 份 = ${foodTotalPrice} 元
                        </li>`;
		});
		cartItems += '</ul>';
		shoppingList.innerHTML += cartItems;
	} else {
		shoppingList.innerHTML += '<p>沒有選購食物</p>';
	}

	// 設定影廳
	var screenId = sessionStorage.getItem("screenId");
	if (screenId) {
		let screenIdField = document.getElementById("screenIdField");
		if (screenIdField) {
			screenIdField.value = screenId;
		} else {
			let screenIdInput = document.createElement('input');
			screenIdInput.type = 'hidden';
			screenIdInput.id = 'screenIdField';
			screenIdInput.name = 'screenId';
			screenIdInput.value = screenId;
			shoppingList.appendChild(screenIdInput);
		}
	}

	// 設定場次
	var showId = sessionStorage.getItem("showId");
	if (showId) {
		let showIdField = document.getElementById("showIdField");
		if (showIdField) {
			showIdField.value = showId;
		} else {
			let showIdInput = document.createElement('input');
			showIdInput.type = 'hidden';
			showIdInput.id = 'showIdField';
			showIdInput.name = 'showId';
			showIdInput.value = showId;
			shoppingList.appendChild(showIdInput);
		}
	}

	var seatSelection = sessionStorage.getItem('seatSelection');
	console.log(seatSelection)
	document.querySelector('input[name="seatSelection"]').value = seatSelection;

	// 讀取 sessionStorage 的 subtotal 值
	var subtotal = sessionStorage.getItem('subtotal');

	// 如果 sessionStorage 中沒有 subtotal，設置為 0
	if (!subtotal) {
		subtotal = 0;
	} else {
		subtotal = parseFloat(subtotal); // 確保 subtotal 是數字
	}

	// 更新 sessionStorage 中的 subtotal 值
	sessionStorage.setItem('subtotal', subtotal);

	// 顯示 subtotal 值
	let subtotalDisplay = document.getElementById("subtotalDisplay");
	if (subtotalDisplay) {
		subtotalDisplay.textContent = subtotal + ' 元';
	}

	// 同時更新隱藏的 input 元素
	let subtotalHidden = document.getElementById("subtotalHidden");
	if (subtotalHidden) {
		subtotalHidden.value = subtotal;
	}

	// 設定票種名稱
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
});

document.getElementById('lastButton').addEventListener('click', function() {
	window.history.back();
});

document.addEventListener('DOMContentLoaded', function() {
	var nextButton = document.getElementById('nextButton');
	if (nextButton) {
		nextButton.addEventListener('click', function(event) {
			event.preventDefault();  // 阻止默認提交行為
			console.log('Default form submission prevented.');
			//sessionStorage.clear();
			// 手動提交表單
			document.getElementById('checkout-form').submit();
		});
	}
});