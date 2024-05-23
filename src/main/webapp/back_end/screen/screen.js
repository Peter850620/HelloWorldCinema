




//當載入時,查看有幾個checkbox 被點擊過 然後更新P標籤內容
document.addEventListener('DOMContentLoaded', function() {
    // Call updateSelectedCount function when any checkbox is clicked
    document.querySelectorAll('.seats input[type="checkbox"]').forEach(checkbox => {
        checkbox.addEventListener('click', function() {
      
            updateSelectedCount();
            let totalPrice = parseFloat(document.getElementById("totalprice").textContent);
            sessionStorage.setItem("total", totalPrice);

          
        });
    });
    
    
      let storequantity = sessionStorage.getItem("quantity");
            if (storequantity) {
                let quantity = parseInt(storequantity);
                document.getElementById("selectedCount").textContent = quantity;
            } else {
                let quantity = 0;
                document.getElementById("selectedCount").textContent = quantity;
            
            }
});





//票種遞增遞減
const buttons = document.querySelectorAll("button");
const minValue = 0;
const maxValue = 10;

buttons.forEach((button) => {
	button.addEventListener("click", (event) => {
		// 1. Get the clicked element
		const element = event.currentTarget;
		// 2. Get the parent
		const parent = element.parentNode;
		// 3. Get the number (within the parent)
		const numberContainer = parent.querySelector(".number");
		const number = parseFloat(numberContainer.textContent);




		// 4. Get the minus and plus buttons
		const increment = parent.querySelector(".plus");
		const decrement = parent.querySelector(".minus");
		// 5. Change the number based on click (either plus or minus)
		const newNumber = element.classList.contains("plus")
			? number + 1
			: number - 1;
		numberContainer.textContent = newNumber;
		updateSelectedCountAndCheckTicketCount();
		// console.log(newNumber);
		// 6. Disable and enable buttons based on number value (and undim number)
		if (newNumber === minValue) {
			decrement.disabled = true;
			numberContainer.classList.add("dim");
			// Make sure the button won't get stuck in active state (Safari)
			element.blur();
		} else if (newNumber > minValue && newNumber < maxValue) {
			decrement.disabled = false;
			increment.disabled = false;
			numberContainer.classList.remove("dim");
		} else if (newNumber === maxValue) {
			increment.disabled = true;
			numberContainer.textContent = `${newNumber}+`;
			element.blur();
		}


	});
});





// 更新選定数量並检查票数是否超過選定座位数
function updateSelectedCountAndCheckTicketCount() {
	//找出
	let numberContainera = document.querySelector(".dim_a");
	let numbera = parseFloat(numberContainera.textContent);
    sessionStorage.setItem("全票",numbera);
    
	let numberContainerb = document.querySelector(".dim_b");
	let numberb = parseFloat(numberContainerb.textContent);
	sessionStorage.setItem("優待票",numberb);

	let numberContainerc = document.querySelector(".dim_c");
	let numberc = parseFloat(numberContainerc.textContent);
	sessionStorage.setItem("愛心票",numberc);

	let numberContainerd = document.querySelector(".dim_d");
	let numberd = parseFloat(numberContainerd.textContent);
	sessionStorage.setItem("敬老票",numberd);

	const total = numbera + numberb + numberc + numberd;

	// 更新選定数量
	const totalselect = parseFloat(document.getElementById('selectedCount').textContent);

	//找出隱藏票價
	let priceA = parseFloat(document.getElementsByName("pricea")[0].textContent);
	let priceB = parseFloat(document.getElementsByName("priceb")[0].textContent);
	let priceC = parseFloat(document.getElementsByName("pricec")[0].textContent);
	let priceD = parseFloat(document.getElementsByName("priced")[0].textContent);

	// Calculate the total price
	let totalPrice = (numbera * priceA) + (numberb * priceB) + (numberc * priceC) + (numberd * priceD);

	// Update the total price in the HTML
	document.getElementById("totalprice").textContent = '$' + totalPrice;
	sessionStorage.setItem("total", totalPrice);

	if (total > totalselect) {
		alert('錯誤：總票數數不能超過選定座位数');
		// 重置票数以防止超出选定座位数
		numberContainera.textContent = 0;
		numberContainerb.textContent = 0;
		numberContainerc.textContent = 0;
		numberContainerd.textContent = 0;
		document.getElementById("totalprice").textContent = '$0';
		sessionStorage.setItem("total", 0);

	}

}



var selectedSeatsString = sessionStorage.getItem("selectedSeats");
if (selectedSeatsString) {
	var selectedSeats = JSON.parse(selectedSeatsString);
} else {

	var selectedSeats = []

}
var checkboxes = document.querySelectorAll('input[type="checkbox"]');


checkboxes.forEach(function(checkbox) {
	checkbox.addEventListener('change', function() {
		if (this.checked) {
			selectedSeats.push(this.value);
		} else {
			// 如果座位被取消從陣列移除
			var index = selectedSeats.indexOf(this.value);
			if (index !== -1) {
				selectedSeats.splice(index, 1);
			}
		}

		// 将更新后的选取的座位数组存储到 sessionStorage 中
		sessionStorage.setItem("selectedSeats", JSON.stringify(selectedSeats));

	});
});



//按下下一頁時要做的檢查
let nextStepLink = document.querySelector('a[href="./back_end/booking/foodOrder.jsp"]');
nextStepLink.addEventListener("click", function(event) {
    // 更新選定数量
    let numberContainera = document.querySelector(".dim_a");
    let numbera = parseFloat(numberContainera.textContent);

    let numberContainerb = document.querySelector(".dim_b");
    let numberb = parseFloat(numberContainerb.textContent);

    let numberContainerc = document.querySelector(".dim_c");
    let numberc = parseFloat(numberContainerc.textContent);

    let numberContainerd = document.querySelector(".dim_d");
    let numberd = parseFloat(numberContainerd.textContent);

    const total = numbera + numberb + numberc + numberd;

    // 更新選定数量
    const totalselect = parseFloat(document.getElementById('selectedCount').textContent);

    //找出隱藏票價
    let priceA = parseFloat(document.getElementsByName("pricea")[0].textContent);
    let priceB = parseFloat(document.getElementsByName("priceb")[0].textContent);
    let priceC = parseFloat(document.getElementsByName("pricec")[0].textContent);
    let priceD = parseFloat(document.getElementsByName("priced")[0].textContent);

    // Calculate the total price
    let totalPrice = (numbera * priceA) + (numberb * priceB) + (numberc * priceC) + (numberd * priceD);

    // Update the total price in the HTML
    document.getElementById("totalprice").textContent = '$' + totalPrice;
    sessionStorage.setItem("total", totalPrice);



    // 在点击事件中进行检查
    if (total !== totalselect) {
        // 如果条件不符合，阻止默认行为
        event.preventDefault();
        alert("請查看總票價");
    }
});








   //頁面重載時
   
    window.onload = function() {
        // 清除storage
        sessionStorage.clear();
    }

