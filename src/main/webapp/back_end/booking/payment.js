let storeMovieTotal=sessionStorage.getItem("total");
let movieTotal=document.getElementById("movieTotal");
if(storeMovieTotal){
	movieTotal.value=storeMovieTotal;
	
}else{
	movieTotal.value=0;
}


let storetkId1=sessionStorage.getItem("全票");
let storetkId2=sessionStorage.getItem("優待票");
let storetkId3=sessionStorage.getItem("愛心票");
let storetkId4=sessionStorage.getItem("敬老票");

let tkId1=document.getElementById("tkId1");
let tkId2=document.getElementById("tkId2");
let tkId3=document.getElementById("tkId3");
let tkId4=document.getElementById("tkId4");


if(storetkId1){
	tkId1.value=storetkId1;
	
}else{
	tkId1.value=0;
}

if(storetkId2){
	tkId2.value=storetkId2;
	
}else{
	tkId2.value=0;
}

if(storetkId3){
	tkId3.value=storetkId3;
	
}else{
	tkId3.value=0;
}

if(storetkId4){
	tkId4.value=storetkId4;
	
}else{
	tkId4.value=0;
}




/**==========================檢查食物區============================ */

// 從 sessionStorage 中取得 foodAndQuantity 陣列
const foodAndQuantity = JSON.parse(sessionStorage.getItem("foodAndQuantity"));


const targetLabel = document.querySelector('label[for="foodTotal"]');
// 確認 foodAndQuantity 不是空的並且是陣列
if (foodAndQuantity && Array.isArray(foodAndQuantity)) {
    // 創建一個空的 HTML 字符串，保存動態生成的 input 欄位
    let html = '';

    // foodAndQuantity 陣列 跑迴圈
    foodAndQuantity.forEach((item, index) => {
        // 取得食物編號、食物名稱和數量
        const foodId = item.foodId;
        const foodName = item.foodName;
        const quantity = item.quantity;

        // 將每個食物的資訊添加到 HTML 字符串中
        html += `
            <input type="hidden" name="foodId${index}" value="${foodId}">
            <label for="food-name${index}">食物名稱:</label>
            <input type="text" id="food-name${index}" readonly name="foodName${index}" value="${foodName}">
            <label for="foodAmount${index}">數量:</label>
            <input type="number" id="foodAmount${index}" readonly name="foodAmount${index}" value="${quantity}">
        `;
    });

    // 將動態生成的 input 欄位添加到表單中
    targetLabel.insertAdjacentHTML('beforebegin', html);
}






//取得食物總金額處裡

let storeFoodTotal=sessionStorage.getItem("foodTotal");
let foodTotal=document.getElementById("foodTotal");

if(storeFoodTotal){
	
	foodTotal.value=parseInt(storeFoodTotal);
}else{
	
	foodTotal.value=0;
	
}



let total=document.getElementById("total");
total.value=  parseInt(foodTotal.value)+parseInt(movieTotal.value);




let storeSeats = sessionStorage.getItem("selectedSeats")
let seatNo=document.getElementById("seatNo");	

	if (storeSeats) {
		
		storeSeats = JSON.parse(storeSeats);//轉回陣列
		let modifiedSeats = storeSeats.map(storeSeats => storeSeats.slice(0, -1));// A01N 最後字母去掉 map針對每個元素
        
		// 合并座位数组为一个字符串
		let combinedSeats = modifiedSeats.join(' ');

        seatNo.value=combinedSeats;

     }else{
		
		seatNo.value="無預訂座位";
		
	 }
	 
	 
	 
//取得適何種付款方式

var paymentType = document.getElementById("paymentType");

// 獲取所有 type 為 submit 的 input 元素
var submitButtons = document.querySelectorAll("input[type='submit']");

// 遍歷所有 submit 按鈕元素
submitButtons.forEach(function(button) {
    // 將處理函數設置為按鈕的 onclick 事件處理函數
    button.onclick = function() {
        paymentType.value = button.value;
    };
});

