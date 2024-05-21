
let totalLoadedDataCount = 0; //計算已經載入多少部電影

window.addEventListener("scroll", function() {
	var scrollThreshold = 200; // 固定的滚動距離底部 200px;


       //當前可視高度加上先前滑動高度                                        //整個網頁內容底部距離瀏覽器視窗底部的距離 = 整個網頁內容的高度 - scrollThreshold
	if (window.innerHeight + window.scrollY >= document.body.offsetHeight - scrollThreshold) {
		document.getElementById("loadMoreButton").style.display = "block";

	} else {
		document.getElementById("loadMoreButton").style.display = "none";

	}
});

document.getElementById("loadMoreButton").addEventListener("click", function() {

	loadMore();
});

var movies = [];

function loadMore() {

	movies = [];

	// 獲取表單元素
	let form = document.getElementById('sortedListAll');
	// 創建 FormData 對象來獲取表單的值
	let formData = new FormData(form);

	
    
  
   

	fetch("/HelloWorldCinema/MovieController?action=loadmore&offset=" + totalLoadedDataCount, {

		method: 'POST', // 使用 POST 方法
		body: formData // 將表單的值包含在請求中
	})
		.then(response => response.json())

		.then(data1 => {
			//抓到 controller 回傳的數據''
			// 變成物件
			data1.forEach(item => {
				let movie = {
					movieId: item.movieId,
					movieName: item.movieName,
					genre: item.genre,
					runtime: item.runtime,
					releaseDate: item.releaseDate,
					offDate: item.offDate,
					rating: item.rating,
					language: item.language,
					movieInfo: item.movieInfo,
					movieStatus: item.movieStatus,
					poster: item.poster,
					trailer: item.trailer
				};
				// 物件加入倒movies陣列裡
				movies.push(movie);


			});
			// 重新計算載入的電影數量
			totalLoadedDataCount += data1.length;
			console.log(totalLoadedDataCount);
			initApp();
		})
		.catch(error => {
			// 處理錯誤情況
			console.error('Error:', error);
		});
}



//當網頁載入時先執行第一次搜尋
window.onload = function() {

	loadMore();
};



function initApp() {
	movies.forEach((value, key) => {
		let newForm = document.createElement('form');
		newForm.setAttribute('action','/CIA10140-Webapp/MovieController');  //注意無法動態路徑屆時要改
		newForm.setAttribute('method', 'post');
       
		newForm.innerHTML = `
            <div class="card">
                <div class="row">
                    <div class="movie_info col l7 m7 s12">
                        <div class="row">
                            <img src="data:image/jpeg;base64,${value.poster}">
                            <div class="movie_deatils">
                                <div class="movie_title">${value.movieName}</div>
                                <ul class="movie_data" id="movie_data">
                                    <li><i class='bx bx-flag'></i>語言：${value.language}</li>
                                    <li><i class='bx bxs-camera-movie'></i>類型：${value.genre}</li>
                                    <li><i class='bx bx-calendar-check'></i>上映日期：${value.releaseDate}</li>
                                    <li><i class='bx bx-calendar-check'></i>下檔日期：${value.offDate}</li>
                                    <li><i class='bx bx-time-five'></i>時長:${value.runtime}分</li>
                                    <li><i class='bx bxs-film'></i>級數：${value.rating}</li>
                                    <li><i class='bx bx-checkbox-checked'></i>狀態：${value.movieStatus}</li>
                                </ul>
                            </div>
                        </div>
                        <div class="movie_times col l5 m5 s12">
                            <div class="movie_session"><i class="material-icons left"></i>簡介:</div>
                            <div class="room">
                               ${value.movieInfo}
                            </div>
                            <div>
                                <ul class="btn_time">
                                    <li>
                                        <input type="submit" name="startTime" value="moredetails">
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <input type="hidden" name="action" value="moredetails">
            <input type="hidden" name="movieId" class="movieId" value="${value.movieId}">
        `;

		// 串接給HTML DIV標籤裡的containerformovie
		document.getElementById('containerformovie').appendChild(newForm);
	});
}


document.getElementById('sortedListAll').addEventListener('submit', function(event) {
	event.preventDefault(); // 防止表單自動提交
 totalLoadedDataCount = 0;
 document.getElementById('containerformovie').innerHTML = '';
	loadMore();

});


let addMovie=document.getElementById("addMovie");
addMovie.addEventListener("click",function(event){

 event.preventDefault();
 window.location.href = "./addMovie.jsp";  //當前資料夾的add
});
