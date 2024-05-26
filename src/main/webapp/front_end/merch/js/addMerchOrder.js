document.addEventListener("DOMContentLoaded", function() {
    var cartInfo = JSON.parse(localStorage.getItem('cartInfo'));

    var merchTotalInput = document.getElementById("merchTotalInput");
	var htmlInput = document.getElementById("Input");
    var cartItemsContainer = document.getElementById('cart-items-container');
    var totalElement = document.getElementById('merchTotal');


    if (cartInfo && cartInfo.cartItems && cartInfo.cartItems.length > 0) {
        var total = 0;
		let htmlToAdd ='';
        
        cartInfo.cartItems.forEach(function (item) {
            var itemElement = document.createElement('div');
             itemElement.innerHTML = '商品名稱: ' + item.merchName + '<br>數量: ' + item.merchQty + '<br>價格: ' + item.merchPrice + '<br>小計: ' + (item.merchQty * item.merchPrice) + '元<br><br>';
            cartItemsContainer.appendChild(itemElement);

//            var itemInfo = {
//                merchName: item.merchName,
//                merchQty: item.merchQty,
//                merchPrice: item.merchPrice,
//                subTotal: item.merchQty * item.merchPrice
//            };
//            merchDetails.push(itemInfo);

            total += item.merchQty * item.merchPrice;


			htmlToAdd +=
			`
			<input type="hidden" id="merchId" name="merchId" value="${item.merchId}">      
	 		<input type="hidden" id="merchQty" name="merchQty" value="${item.merchQty}">
	 		<input type="hidden" id="merchSubTotal" name="merchSubTotal" value="${item.merchQty * item.merchPrice}">
		
			`;
			

        });
        			htmlInput.insertAdjacentHTML("afterbegin", htmlToAdd);
        
       
        // 將商品明細信息和總價格設置到隱藏字段中
        merchTotalInput.value = total;
        totalElement.value = total;
console.log(cartInfo.cartItems);


        totalElement.textContent = '總價格: ' + cartInfo.total + '元';
    }








    var pickupOption = document.getElementById("pickupOption");
    var recipientRow = document.getElementById("recipientRow");
    var receiptAddrRow = document.getElementById("receiptAddrRow");
    var receiptMobileRow = document.getElementById("receiptMobileRow");

    pickupOption.addEventListener("change", function() {
        if (pickupOption.value === "宅配") {
            recipientRow.style.display = "";
            receiptAddrRow.style.display = "";
            receiptMobileRow.style.display = "";
        } else {
            recipientRow.style.display = "none";
            receiptAddrRow.style.display = "none";
            receiptMobileRow.style.display = "none";
        }
    });

    if (pickupOption.value !== "宅配") {
        recipientRow.style.display = "none";
        receiptAddrRow.style.display = "none";
        receiptMobileRow.style.display = "none";
    }
    
    
//    訂單生成後清除localStorage
    var submitButton = document.querySelector('input[type="submit"][value="結帳"]');
    submitButton.addEventListener("click", function() {
        // Clear localStorage
        localStorage.clear();
    });
});
