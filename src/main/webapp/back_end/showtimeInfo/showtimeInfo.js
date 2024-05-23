function calculateTotalTime() {
            var runtime = parseInt(document.getElementById('runtime').value) || 0;
            var additionalTime = parseInt(document.getElementById('additionalTime').value) || 0;
            var totalMinutes = runtime + additionalTime;
            
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
}

        document.getElementById('runtime').addEventListener('change', calculateTotalTime);

    // 在页面加载完成后调用函数
    window.onload = function() {
        calculateTotalTime();
        selectMovieId();
    };
