let openShopping = document.querySelector('.shopping');
let payforcart = document.querySelector('.payforcart');
let list = document.querySelector('.list');
let listCard = document.querySelector('.listCard');
let body = document.querySelector('body');
let total = document.querySelector('.total');
let quantity = document.querySelector('.quantity');
let storageQty=sessionStorage.getItem("quantity");
let tickets=parseInt(storageQty);

let storedTotal = sessionStorage.getItem("total");
let totalPrice = parseFloat(storedTotal);
let seatTotal = totalPrice;
openShopping.addEventListener('click', () => {
	body.classList.toggle('active');
})


// closeShopping.addEventListener('click', ()=>{
//     body.classList.remove('active');
// })



let products = [];

// 發送GET请求到BookingController的/foods路径
fetch('/HelloWorldCinema/BookingController?action=addFood')  //屆時路徑要改
	.then(response => response.json()) // 解析响应的JSON数据


	.then(allOfFood => {

		// 将接收到的食物数据转换为与products数组相同的格式
		allOfFood.forEach(item => {
			let product = {
				foodId: item.foodId,
				foodName: item.foodName,
				foodPic: item.foodPic,
				foodPrice: item.foodPrice,
				foodDetails: item.foodDetails
			};
			// 将转换后的食物对象添加到products数组中
			products.push(product);
		});
		// 在这里可以对products数组进行任何处理，例如渲染到页面上
		initApp();

	})
	.catch(error => {
		console.error('Error fetching foods:', error);
	});



let listCards = [];

function initApp() {
	products.forEach((value, key) => {
		let newDiv = document.createElement('div');
		newDiv.classList.add('item');
		newDiv.innerHTML = `
            <img src="data:image/jpeg;base64,${value.foodPic}"style="width: 150px; height: 150px;">
            <div class="title">${value.foodName}</div>
            <div class="price">${value.foodPrice.toLocaleString()}</div>
            <input type="hidden" name="foodId" value="${value.foodId}">
            <button onclick="addToCard(${ key})">加入購物車</button>`;
		list.appendChild(newDiv);

	if(storedTotal){
		let totalPrice = parseFloat(storedTotal);

		total.innerHTML = totalPrice;
		}else{
			total.innerHTML=0;
		}
	})
}


//加入上面紅色數字同時 也要執行 右邊側邊欄reloadCart刷新
function addToCard(key) {
	if (listCards[key] == null) {
		// copy product form list to list card
		listCards[key] = JSON.parse(JSON.stringify(products[key]));
		listCards[key].quantity = 1;
	}



	reloadCard();
}
function reloadCard() {

	let count = 0;
	let storedTotal = sessionStorage.getItem("total");
	let totalPrice = parseFloat(storedTotal);
	let seats = sessionStorage.getItem("selectedSeats")
	
	let foodAndQuantity = [];
	if (seats) {
		total.innerHTML = totalPrice;
		seats = JSON.parse(seats);//轉回陣列
		let modifiedSeats = seats.map(seat => seat.slice(0, -1));// A01N 最後字母去掉 map針對每個元素 從索引0開始  到  倒數-1 不包含
        var foodTotal = totalPrice - seatTotal;
		// 合并座位数组为一个字符串
		let combinedSeats = modifiedSeats.join(' ');

		listCard.innerHTML = '';
	
			let newDiv = document.createElement('li');
			newDiv.innerHTML = `
                <div><img src="../../images/seat.jpg" style="width: 60px; height:60px;"/></div>
                <div>${combinedSeats}</div>
                <div>${totalPrice.toLocaleString()}</div>
                 <div>${tickets}張</div>
                `;
			newDiv.style.marginBottom = '20px';
			listCard.appendChild(newDiv);
		
	} else {
		totalPrice = 0;
			listCard.innerHTML = '';  //每次 reload都要把原本列表清單先清空再開始創建裡面的清單否則會重複加入
			total.innerHTML = totalPrice;
			 
	}

	listCards.forEach((value, key) => {
		totalPrice = totalPrice + value.foodPrice;
		count = count + value.quantity;
		if (value != null) {
			let newDiv = document.createElement('li');
			newDiv.innerHTML = `
                <div><img src="data:image/jpeg;base64,${value.foodPic}" style="width: 60px; height:60px;"/></div>
                <div>${value.foodName}</div>
                <div>${value.foodPrice.toLocaleString()}</div>
                <div>
                    <button onclick="changeQuantity(${key}, ${value.quantity - 1})">-</button>
                    <div class="count">${value.quantity}</div>
                    <button onclick="changeQuantity(${key}, ${value.quantity + 1})">+</button>
                </div>`;
			newDiv.style.marginBottom = '20px';
			listCard.appendChild(newDiv);

			foodAndQuantity.push({
				foodId: value.foodId,
				foodName: value.foodName,
				quantity: value.quantity
			});

		}
	})

	sessionStorage.setItem("foodAndQuantity", JSON.stringify(foodAndQuantity));
	
	let food=0;
	if(seatTotal){
   food=totalPrice-seatTotal;
   }else{
	food=totalPrice;
	
   }
	sessionStorage.setItem("foodTotal", food);

	total.innerText = totalPrice.toLocaleString();
	quantity.innerText = count;


}
function changeQuantity(key, quantity) {
	if (quantity == 0) {
		delete listCards[key];
	} else {
		listCards[key].quantity = quantity;
		listCards[key].foodPrice = quantity * products[key].foodPrice;
	}
	reloadCard();
}



document.addEventListener("DOMContentLoaded", function() {
    sessionStorage.removeItem("foodTotal");
	sessionStorage.removeItem("foodAndQuantity");
	// 获取存储在 sessionStorage 中的 total 值
	let storedTotal = sessionStorage.getItem("total");

	// 将 storedTotal 转换为数字
	let totalPrice = parseFloat(storedTotal);


	// 检查 totalPrice 是否是一个有效的数字
	if (!isNaN(totalPrice)) {
		var movieTotal = document.getElementsByClassName("total")[0];
		movieTotal.innerHTML = totalPrice;
		let seats = sessionStorage.getItem("selectedSeats")
		seats = JSON.parse(seats);//轉回陣列
		let modifiedSeats = seats.map(seat => seat.slice(0, -1));// A01N 最後字母去掉 map針對每個元素

		// 合并座位数组为一个字符串
		let combinedSeats = modifiedSeats.join(' ');


		let newDiv = document.createElement('li');
		newDiv.innerHTML = `
                <div><img src="../../images/seat.jpg" style="width: 60px; height:60px;"/></div>
                <div>${combinedSeats}</div>
                <div>${totalPrice.toLocaleString()}</div>
                 <div>${tickets}張</div>
                `;
		newDiv.style.marginBottom = '20px';
		listCard.appendChild(newDiv);

	} 


});