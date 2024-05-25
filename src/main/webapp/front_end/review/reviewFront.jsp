<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>

	<style>

		 body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        
        .compositequery {
            text-align: center;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .compositequery a {
            display: inline-block;
            margin: 0 10px;
            padding: 10px 20px;
            text-decoration: none;
            color: #007BFF;
            background-color: #e9ecef;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .compositequery a:hover {
            background-color: #007BFF;
            color: #fff;
        }

        .item-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .item {
            width: calc(20% - 20px);
            margin: 10px;
            box-sizing: border-box;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s;
        }

        .item:hover {
            transform: scale(1.05);
        }

        .item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .item-details {
            padding: 10px;
            text-align: center;
        }

        .item-details h2 {
            font-size: 18px;
            margin: 0;
            color: #333;
        }

        button#showBtn {
            display: none;
            width: 200px;
            margin: 20px auto;
            padding: 15px;
            font-size: 18px;
            color: white;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button#showBtn:hover {
            background-color: #0056b3;
        }

        .item-container .item:nth-child(5n+1) {
            clear: left;
        }
	</style>
</head>
<body>

<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
 	<div id="xxx">
 		<div class="compositequery">
			<a href="<%= request.getContextPath() %>/front/review.do?action=compositeQuery&movieStatus=即將上映">即將上映</a>
			<a href="<%= request.getContextPath() %>/front/review.do?action=compositeQuery&movieStatus=熱映中">熱映中</a>
			<a href="<%= request.getContextPath() %>/front/review.do?action=compositeQuery&movieStatus=已下檔">已下檔</a>
			<a href="<%= request.getContextPath() %>/front/review.do?action=loadMovie">所有電影</a>
		</div>
 		<div class="item-container">
	 		<c:forEach var="movie" items="${movieList}">
				<div class="item">
			        <a href="<%= request.getContextPath() %>/front/review.do?action=getMovie&movie=${movie.movieId}">
		              	<img src="<%=request.getContextPath()%>/movie/MovieGifReader?movieId=${movie.movieId}"  alt="Image">
			            <div class="item-details">
		                	<h2 class="movie-title">${movie.movieName}</h2>
			          	</div>
			        </a>
			      </div>
	      	</c:forEach>
	      <button id="showBtn">顯示更多</button>
 		</div>
	</div>

<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    <script>
      document.addEventListener("DOMContentLoaded", function() {
      var itemContainer = document.querySelector('.item-container');
      var items = document.querySelectorAll('.item');
      var numItemsToShow = 15;
      var numItems = items.length;
      var currentIndex = 0;

      // 超過三行隱藏
      function hideItemsBeyondLimit() {
        for (var i = numItemsToShow; i < numItems; i++) {
          items[i].style.display = 'none';
        }
      }

      // 顯示更多
      function showMoreItems() {
        var nextIndex = currentIndex + numItemsToShow;
        for (var i = currentIndex; i < nextIndex && i < numItems; i++) {
          items[i].style.display = 'block';
        }
        currentIndex = nextIndex;
        if (currentIndex >= numItems) {
          showMoreBtn.style.display = 'none';
        }
      }

      // 更多點擊
      var showMoreBtn = document.getElementById("showBtn");
      showMoreBtn.addEventListener('click', function() {
        showMoreItems();
      });

      // 載入，隱藏剩三行
      hideItemsBeyondLimit();
      if (numItems > numItemsToShow) {
        showMoreBtn.style.display = 'block';
      }
    });

    </script>
</body>
</html>