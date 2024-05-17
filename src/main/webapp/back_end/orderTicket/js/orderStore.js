document.addEventListener('DOMContentLoaded', function() {
    const cartWrapper = document.getElementById('cart-wrapper');
    const subtotalElement = document.getElementById('subtotal');
    const cartToggle = document.getElementById('cart-button');
    const cartTableBody = document.getElementById('cart-table-body');
    const ticketTableBody = document.getElementById('ticket-table-body');
    const checkoutButton = document.getElementById('checkout');
    let cart = { items: [], subtotal: 0 };
    let ticketcart = { items: [], subtotal: 0 };

    // 確認 ticketTableBody 存在
    if (!ticketTableBody) {
        console.error('ticketTableBody element not found!');
        return;
    }

    // 使用 jQuery 處理點擊事件，切換 .slider 和 #cart-wrapper 的 class
    $('.trigger, .keep-shopping, #cart-button').click(function() {
        $('.slider').toggleClass('close');
        $('#cart-wrapper').toggleClass('open'); // 這裡添加了 'open' class 作為範例，請根據實際需求調整
    });

    // 事件委託來處理動態添加的元素的點擊事件
    document.body.addEventListener('click', function(event) {
        if (event.target.classList.contains('add-to-cart')) {
            const item = event.target.closest('.products, .ticket');
            if (item) {
                addToCart(item);
            } else {
                console.error('未找到產品或票務元素！');
            }
        }
        if (event.target.classList.contains('remove')) {
            removeFromCart(event.target);
        }
    });

    // 處理下拉菜單的變更事件，更新購物車項目數量
    document.body.addEventListener('change', function(event) {
        if (event.target.classList.contains('quantity-select')) {
            const id = event.target.dataset.id;
            const newQuantity = parseInt(event.target.value);
            updateItemQuantity(id, newQuantity);
        }
    });

    // 將商品加入購物車
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

    // 從購物車中移除商品
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
        row.remove(); // 刪除 HTML 表格中的行
        updateCart();
    }

    // 更新購物車，顯示最新的總金額
    function updateCart() {
        let total = ticketcart.items.concat(cart.items).reduce((acc, item) => acc + item.totalPrice, 0);
        subtotalElement.textContent = total.toFixed(2);
        updateTable(ticketcart.items, ticketTableBody);
        updateTable(cart.items, cartTableBody);
    }

    // 更新表格顯示，包括商品數量的下拉選單
    function updateTable(items, tableBody) {
        tableBody.innerHTML = '';  // 清空現有的表格內容
        items.forEach(item => {
            let row = tableBody.insertRow();  // 插入新行
            row.id = item.id;  // 設定行的 ID 為購物車項目的 ID
            row.innerHTML = `<td>${item.name}</td>
                             <td>
                                 <select class='quantity-select' data-id='${item.id}'>
                                     ${Array.from({length: 10}, (_, i) => `<option value='${i+1}' ${item.quantity === i+1 ? "selected" : ""}>${i+1}</option>`).join('')}
                                 </select>
                             </td>
                             <td>${item.price.toFixed(2)}</td>
                             <td class='total-price'>${item.totalPrice.toFixed(2)}</td>
                             <td><button class='remove'>移除</button></td>`;
        });
    }

    // 根據下拉選單變更更新項目數量和總價
    function updateItemQuantity(id, newQuantity) {
        let foundItem = [...cart.items, ...ticketcart.items].find(item => item.id === id);
        if (foundItem) {
            foundItem.quantity = newQuantity;
            foundItem.totalPrice = foundItem.price * newQuantity;
            updateCart();  // 更新購物車以反映新的總價
        }
    }

    // 處理下一步按鈕的點擊事件
    checkoutButton.addEventListener('click', function() {
    var screenUrl = '<%=request.getContextPath()%>/select_seats.jsp?screenId=<%=show.getScreen().getScreenId()%>';
        updateCart(); // 確保最新的購物車總計被計算和顯示
        if (ticketcart.items.length === 0) {
            alert('至少選一張票');
        } else {
            localStorage.setItem('cart', JSON.stringify(cart));
            localStorage.setItem('ticketcart', JSON.stringify(ticketcart));
            localStorage.setItem('subtotal', subtotalElement.textContent); // 將 subtotal 也存儲在 localStorage
            window.location.href = screenUrl;  // 替換為您的選座位頁面 URL
        }
    });
});
