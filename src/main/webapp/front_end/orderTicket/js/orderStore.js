document.addEventListener('DOMContentLoaded', function() {
	const cartWrapper = document.getElementById('cart-wrapper');
	const subtotalElement = document.getElementById('subtotal');
	const cartToggle = document.getElementById('cart-button');
	const cartTableBody = document.getElementById('cart-table-body');
	const ticketTableBody = document.getElementById('ticket-table-body');
	const checkoutButton = document.getElementById('checkout');
	let cart = { items: [], subtotal: 0 };
	let ticketcart = { items: [], subtotal: 0 };

	if (!ticketTableBody) {
		console.error('ticketTableBody element not found!');
		return;
	}

	$('.trigger, .keep-shopping, #cart-button').click(function() {
		$('.slider').toggleClass('close');
		$('#cart-wrapper').toggleClass('open');
	});

	document.body.addEventListener('click', function(event) {
		if (event.target.classList.contains('add-to-cart')) {
			const item = event.target.closest('.products, .ticket');
			if (item) {
				addToCart(item);
				alert("已加入購物車");
			} else {
				console.error('未找到產品或票務元素！');
			}
		}
		if (event.target.classList.contains('remove')) {
			removeFromCart(event.target);
		}
	});

	document.body.addEventListener('change', function(event) {
		if (event.target.classList.contains('quantity-select')) {
			const id = event.target.dataset.id;
			const newQuantity = parseInt(event.target.value);
			updateItemQuantity(id, newQuantity);
		}
	});

	function addToCart(item) {
		let isTicket = item.classList.contains('ticket');
		let itemArray = isTicket ? ticketcart.items : cart.items;
		let nameElement = item.querySelector('.product-name, .ticket-name');
		let priceElement = item.querySelector('.product-price, .ticket-price');
		let id = item.id;
		let name = nameElement.textContent;
		let price = parseFloat(priceElement.textContent.replace(/[^\d.-]/g, ''));

		let existingItem = itemArray.find(i => i.id === id);
		if (existingItem) {
			existingItem.quantity++;
			existingItem.totalPrice += price;
		} else {
			itemArray.push({ id: id, name: name, price: price, quantity: 1, totalPrice: price });
		}
		updateCart();
	}

	function removeFromCart(button) {
		let row = button.closest('tr');
		if (!row.id) {
			console.error('No ID found on the row, cannot remove item.');
			return;
		}
		let isTicket = row.parentNode === ticketTableBody;
		let itemArray = isTicket ? ticketcart.items : cart.items;
		itemArray = itemArray.filter(item => item.id !== row.id);
		if (isTicket) {
			ticketcart.items = itemArray;
		} else {
			cart.items = itemArray;
		}
		row.remove();
		updateCart();
	}

	function updateCart() {
		let total = ticketcart.items.concat(cart.items).reduce((acc, item) => acc + item.totalPrice, 0);
		subtotalElement.textContent = total.toFixed(2);
		updateTable(ticketcart.items, ticketTableBody);
		updateTable(cart.items, cartTableBody);
	}

	function updateTable(items, tableBody) {
		tableBody.innerHTML = '';
		items.forEach(item => {
			let row = tableBody.insertRow();
			row.id = item.id;
			row.innerHTML = `<td>${item.name}</td>
                             <td>
                                 <select class='quantity-select' data-id='${item.id}'>
                                     ${Array.from({ length: 10 }, (_, i) => `<option value='${i + 1}' ${item.quantity === i + 1 ? "selected" : ""}>${i + 1}</option>`).join('')}
                                 </select>
                             </td>
                             <td>${item.price.toFixed(2)}</td>
                             <td class='total-price'>${item.totalPrice.toFixed(2)}</td>
                             <td><button class='remove'>移除</button></td>`;
		});
	}

	function updateItemQuantity(id, newQuantity) {
		let foundItem = [...cart.items, ...ticketcart.items].find(item => item.id === id);
		if (foundItem) {
			foundItem.quantity = newQuantity;
			foundItem.totalPrice = foundItem.price * newQuantity;
			updateCart();
		}
	}

	checkoutButton.addEventListener('click', function(event) {
		event.preventDefault();  // 阻止默認提交行為
		console.log('Default form submission prevented.');
		updateCart();
		if (ticketcart.items.length === 0) {
			alert('至少選一張票');
		} else {
			sessionStorage.setItem('cart', JSON.stringify(cart));
			sessionStorage.setItem('ticketcart', JSON.stringify(ticketcart));
			sessionStorage.setItem('subtotal', subtotalElement.textContent);
			document.getElementById('showtimeForm').submit();  // 手動提交表單
		}
	});

});