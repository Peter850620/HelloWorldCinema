// 場次資訊

//$(document).ready(function() {
//  // 使用 jQuery 的 AJAX 函數發送請求獲取 playdates 資料
//  $.ajax({
//    url: '<%=request.getContextPath()%>/getPlaydates', // 請填寫您的 servlet 或 controller 的路徑
//    type: 'GET',
//    dataType: 'json',
//    success: function(data) {
//      // 成功獲取資料後的處理邏輯
//      var playdatesList = $('#playdatesList');
//      playdatesList.empty(); // 清空原有資料
//
//      // 將獲取的 playdates 資料動態添加到列表中
//      data.forEach(function(playdate) {
//        var li = $('<li></li>');
//        var link = $('<a></a>').attr('href', '<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Info&movieId=<%= movie.movieId %>&playdate=' + playdate)
//                               .text(playdate);
//        li.append(link);
//        playdatesList.append(li);
//      });
//    },
//    error: function(xhr, status, error) {
//      // 處理請求錯誤的情況
//      console.error(error);
//    }
//  });
//
//  // 使用 jQuery 的 AJAX 函數發送請求獲取 showtimes 資料
//  $.ajax({
//    url: '<%=request.getContextPath()%>/getShowtimes', // 請填寫您的 servlet 或 controller 的路徑
//    type: 'GET',
//    dataType: 'json',
//    data: {
//      movieId: <%= movie.movieId %>, // 傳遞 movieId 參數
//      playdate: selectedPlaydate // 假設您已經獲取了選擇的 playdate
//    },
//    success: function(data) {
//      // 成功獲取資料後的處理邏輯
//      var showtimesContainer = $('#showtimesContainer');
//      showtimesContainer.empty(); // 清空原有資料
//
//      // 將獲取的 showtimes 資料動態添加到容器中
//      data.forEach(function(showtime) {
//        var showtimeBtn = $('<a></a>').addClass('showtime_btn')
//                                        .attr('href', '#')
//                                        .attr('data-modal', '.confirm')
//                                        .text(showtime.showtime + ' ' + showtime.screen.screenId);
//        showtimesContainer.append(showtimeBtn);
//      });
//    },
//    error: function(xhr, status, error) {
//      // 處理請求錯誤的情況
//      console.error(error);
//    }
//  });
//
//});


//訂票確認視窗
$(".confirm").each(function() {
	$(this).wrap('<div class="overlay"></div>')
});

$(".showtime_btn").on('click', function(e) {
	e.preventDefault();
	e.stopImmediatePropagation;

	var $this = $(this),
		modal = $($this).data("modal");

	$(modal).parents(".overlay").addClass("open");
	setTimeout(function() {
		$(modal).addClass("open");
	}, 350);

	$(document).on('click', function(e) {
		var target = $(e.target);

		if ($(target).hasClass("overlay")) {
			$(target).find(".confirm").each(function() {
				$(this).removeClass("open");
			});
			setTimeout(function() {
				$(target).removeClass("open");
			}, 350);
		}

	});

});

$(".no").on('click', function(e) {
	e.preventDefault();
	e.stopImmediatePropagation;

	var $this = $(this),
		modal = $($this).data("modal");

	$(modal).removeClass("open");
	setTimeout(function() {
		$(modal).parents(".overlay").removeClass("open");
	}, 350);

});




// 電影PV
$(document).ready(function() {
	// 隱藏所有的 tab 內容
	$(".tab_content").hide();
	$(".tab_content:first").show();

	// 如果是標籤模式
	$("ul.tabs li a").click(function(e) {
		e.preventDefault(); // 阻止默認跳轉行為

		// 隱藏所有的 tab 內容
		$(".tab_content").hide();

		// 獲取所點擊標籤對應的內容
		var activeTab = $(this).attr("href");
		$(activeTab).fadeIn(); // 顯示所點擊標籤對應的內容

		// 移除所有標籤的 active 樣式，並為所點擊的標籤添加 active 樣式
		$("ul.tabs li a").removeClass("active");
		$(this).addClass("active");
	});
});

// 存取showtimeId
document.addEventListener('DOMContentLoaded', function() {
	// 獲取 input 元素
	var inputElement = document.getElementById('myshowId');

	// 獲取 input 的 value
	var showIdValue = inputElement.value;

	// 將 value 存入 sessionStorage
	sessionStorage.setItem('showId', showIdValue);

	// 驗證 sessionStorage 中的數據
	console.log(sessionStorage.getItem('showId')); // 應顯示 showtime.showtimeId 的值
});
