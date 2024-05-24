// 切換座位狀態的函數
function toggleSeatStatus(checkbox) {
	let status = checkbox.dataset.status; // 獲取當前狀態
	if (status === 'Y') {
		checkbox.dataset.status = 'N'; // 如果是可預訂，改為已預訂
		checkbox.checked = true;
	} else if (status === 'N') {
		checkbox.dataset.status = 'Y'; // 如果是已預訂，改為可預訂
		checkbox.checked = false;
	} else if (status === 'F') {
		checkbox.disabled = true; // 維修中的座位不可選
	}
}

// 生成座位狀態字串的函數
function generateSeatString() {
	const seats = document.querySelectorAll('.seat input[type="checkbox"]');
	let seatString = '';
	seats.forEach(seat => {
		seatString += seat.id + seat.dataset.status; // 生成字串，如A01Y或A01N
	});
	return seatString;
}

// 將座位狀態存儲到 SessionStorage 的函數
function saveToSessionStorage() {
	const seatString = generateSeatString();
	sessionStorage.setItem('seatSelection', seatString); // 存儲到 SessionStorage
	console.log('Saved seats: ', seatString);
}

// 更新並顯示已選座位數量的函數
function updateSelectedCount() {
	let selectedCount = document.querySelectorAll('.seats input[type="checkbox"]:checked:not([disabled])').length;
	document.getElementById('selectedCount').textContent = selectedCount;
	return selectedCount;
}

// 從 LocalStorage 應用座位狀態的函數
function applySeatStatusFromLocalStorage() {
	const seatStatus = localStorage.getItem('seatStatus');
	if (!seatStatus) {
		console.log('No seat status found in LocalStorage.');
		return;
	}
	console.log(`Applying seat status from LocalStorage: ${seatStatus}`);
	const seatPattern = /(\w{3})(\w)/g;
	let match;
	while ((match = seatPattern.exec(seatStatus)) !== null) {
		const seatId = match[1];
		const status = match[2];
		const seatCheckbox = document.getElementById(seatId);
		if (seatCheckbox) {
			seatCheckbox.dataset.status = status;
			if (status === 'F') {
				seatCheckbox.disabled = true;
				seatCheckbox.checked = false;
			} else if (status === 'N') {
				seatCheckbox.disabled = true;
				seatCheckbox.checked = true;
			} else {
				seatCheckbox.disabled = false;
				seatCheckbox.checked = false;
			}
		}
	}
	updateSelectedCount(); // 更新已選座位數量
}

// 計算總票數並顯示在 HTML 中的函數
function calculateTotalCount() {
	const ticketCart = JSON.parse(sessionStorage.getItem('ticketcart')) || {};
	const ticketsData = ticketCart.items || [];
	const totalCount = ticketsData.reduce((acc, item) => acc + item.quantity, 0);
	document.getElementById('totalCount').textContent = totalCount;
	return totalCount;
}

document.addEventListener('DOMContentLoaded', function() {
	// 應用 LocalStorage 中的座位狀態
	applySeatStatusFromLocalStorage();

	// 計算總票數並顯示
	calculateTotalCount();

	// 禁用所有 data-status="N" 的座位
	document.querySelectorAll('.seats input[type="checkbox"]').forEach(checkbox => {
		if (checkbox.dataset.status === 'N') {
			checkbox.disabled = true;
		}
	});

	// 為每個座位添加點擊事件以切換狀態並更新已選座位數量
	document.querySelectorAll('.seats input[type="checkbox"]').forEach(checkbox => {
		checkbox.addEventListener('click', function() {
			if (this.dataset.status !== 'F') {
				toggleSeatStatus(this); // 切換座位狀態
				updateSelectedCount(); // 更新已選座位數量
			}
		});
	});

	// 為下一步按鈕添加點擊事件以檢查選擇的座位數量是否符合要求
	const nextButton = document.getElementById('nextButton');
	if (nextButton) {
		nextButton.addEventListener('click', function() {
			const selectedCount = updateSelectedCount();
			const totalCount = calculateTotalCount();
			if (selectedCount < totalCount) {
				alert(`還需要 ${totalCount - selectedCount} 張票`);
			} else if (selectedCount > totalCount) {
				alert(`超過 ${selectedCount - totalCount} 張票`);
			} else {
				saveToSessionStorage(); // 點擊時保存座位狀態
				// 可以添加進一步的處理邏輯，如跳轉到下一頁面
			}
		});
	}
});

document.getElementById('lastButton').addEventListener('click', function() {
	window.history.back();
});



	nextButton.addEventListener('click', function(event) {
		event.preventDefault();  // 阻止默認提交行為
		console.log('Default form submission prevented.');
		window.location.href = '/checkorder.jsp';
	});
