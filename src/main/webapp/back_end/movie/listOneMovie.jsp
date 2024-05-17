<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.entity.*"%>
<%@ page import="java.util.List"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>新增成功</title>
<style>
.movie-container {
	min-width: 600px;;
	max-width:600px;
	margin: 20px auto;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	MARGIN-LEFT: 250PX;
	margin-top: 80px; border-radius : 25px;
	justify-content: center;
	border: 2px solid white;
	background-color: rgb(255, 255, 255, 0.65);
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	border-radius: 25px;
	padding:50px;
}

.movie-actions {
	text-align: center;
	margin-top: 20px;
	order: -1; /* 将编辑按钮放置到第一个位置 */
}

.movie {
	display: flex;
	margin-bottom: 10px;
	justify-content: space-between;
}

.movie-label {
	flex: 1;
	font-weight: bold;
	padding:5px;
}

.movie-value {
	flex: 9;
	font-weight: bold;
}

.movie-actions {
	text-align: center;
	margin-top: 20px;
}

.continue-add {
	text-align: center;
	margin-top: 20px;
}

.btn {
	padding: 8px 16px;
	font-size: 16px;
	background-color: #61bdd3;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.btn:hover {
	background-color: #0056b3;
}

.movie-value {
	flex: 3;
	word-wrap: break-word;
	width: 70%; /* 调整宽度，使其能够容纳内容 */
	overflow: auto; /* 添加溢出处理 */
	padding-bottom: 20px;
}
</style>
</head>


<body>

<jsp:include page="../management.jsp" />
	<h3>電影資料 -新增成功囉!</h3>


	
	
	<div class="movie-container">
		<div class="movie">
			<div class="movie-label">電影編號</div>
			<div class="movie-value" name="movieId" value="${movie.movieId}">${movie.movieId}</div>
		</div>
		<div class="movie">
			<div class="movie-label">電影名稱</div>
			<div class="movie-value">${movie.movieName}</div>
		</div>
		<div class="movie">
			<div class="movie-label">電影時長</div>
			<div class="movie-value">${movie.runtime}</div>
		</div>
		<div class="movie">
			<div class="movie-label">上映日期</div>
			<div class="movie-value">${movie.releaseDate}</div>
		</div>
		<div class="movie">
			<div class="movie-label">下檔日期</div>
			<div class="movie-value">${movie.offDate}</div>
		</div>
		<div class="movie">
			<div class="movie-label">電影類型</div>
			<div class="movie-value">${movie.genre}</div>
		</div>
		<div class="movie">
			<div class="movie-label">電影語言</div>
			<div class="movie-value">${movie.language}</div>
		</div>
		<div class="movie">
			<div class="movie-label">電影分級</div>
			<div class="movie-value">${movie.rating}</div>
		</div>
		<div class="movie">
			<div class="movie-label">電影簡介</div>
			<div class="movie-value">${movie.movieInfo}</div>
		</div>
		<div class="movie">
			<div class="movie-label">電影狀態</div>
			<div class="movie-value">${movie.movieStatus}</div>
		</div>
		<div class="movie">
			<div class="movie-label">電影圖片</div>
			<div class="movie-value">
				<img src="data:image/jpeg;base64,${movie.picBase64}"
					alt="Movie Image" style="width: 100px; height: auto;">
			</div>
		</div>
		<div class="movie">
			<div class="movie-label">預告片(關鍵字)</div>
			<div class="movie-value">${movie.trailer}</div>
		</div>
		<iframe width="460" height="215" src="https://www.youtube.com/embed/${movie.trailer}?si=bobwqzEX36K-qg5Z" title="YouTube video player" frameborder="0" allow="fullscreen; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
		<div class="movie-actions">
			<form action="<%=request.getContextPath()%>/MovieController"
				method="post">
				<input type="hidden" name="action" value="editMovie"> <input
					type="hidden" name="movieId" value="${movie.movieId}">
				<button type="submit" class="btn">編輯</button>
				<button  type="button" class="btn" onclick="redirectToPage()">新增</button>
				<button  type="button" class="btn" onclick="backToListAll()">查看全部</button>
			</form>
		</div>
	</div>




	<script>
		function redirectToPage() {
			// 使用 window.location.href 属性来设置新页面的 URL
			window.location.href = "./back_end/movie/addMovie.jsp";
		}
		
		function backToListAll() {
			// 使用 window.location.href 属性来设置新页面的 URL
			window.location.href = "./back_end/movie/listAllMovie.jsp";
		}
		</script>

		</body>
		</html>
	