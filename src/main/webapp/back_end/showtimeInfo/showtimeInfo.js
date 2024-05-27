function calculateTotalTime() {
	// 获取输入的时间
	var showtime = document.getElementById('showtime').value;

	// 将时间字符串解析为小时和分钟
	var parts = showtime.split(':');
	var hours = parseInt(parts[0], 10);
	var minutes = parseInt(parts[1], 10);

	// 将小时和分钟转换为分钟数
	var showtimeMinutes = hours * 60 + minutes;

	var runtime = parseInt(document.getElementById('runtime').value) || 0;
	var additionalTime = parseInt(document.getElementById('additionalTime').value) || 0;
	var totalMinutes = showtimeMinutes + runtime + additionalTime; // 起始時間(已分鐘呈現)+時長+清潔時間

	// 如果需要处理跨越24小时的情况，可以使用下面的方法
	if (totalMinutes > 1440) {
		totalMinutes = totalMinutes % 1440;
	}

	// Convert total minutes to HH:MM format
	var hours = Math.floor(totalMinutes / 60);
	var minutes = totalMinutes % 60;

	// Ensure hours and minutes are two digits
	var formattedTime = (hours < 10 ? '0' : '') + hours + ':' + (minutes < 10 ? '0' : '') + minutes;

	document.getElementById('endtime').value = formattedTime;
}

// 使用 textContent 设置值
function selectMovieId() {
	var selectedOption = document.getElementById('movieId').options[document.getElementById('movieId').selectedIndex];
	var runtime = selectedOption.getAttribute('data-runtime');
	document.getElementById('runtime').value = runtime;

	calculateTotalTime();
}


// 在页面加载完成后调用函数
window.onload = function() {
	if (document.getElementsByName('action')[0].value == "insert") {
		selectMovieId();
	}
	calculateTotalTime();
};
