<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>訂單成立中</title>

<style type="text/css">
html, body {
  align-items: center;
  background-color: black;
  display: flex;
  height: 100%;
  justify-content: center;
  margin: 0;
}

.loader {
  width: 60px;
}

.loader-wheel {
  animation: spin 1s infinite linear;
  border: 2px solid rgba(30, 30, 30, 0.5);
  border-left: 4px solid #fff;
  border-radius: 50%;
  height: 50px;
  margin-bottom: 10px;
  width: 50px;
}

.loader-text {
  color: #fff;
  font-family: arial, sans-serif;
  width:100px;
}

.loader-text:after {
  content: '訂單已成立';
  animation: load 4s linear 1 forwards;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@keyframes load {
  0% {
    content: '交易確認中...';
  }
  25% {
    content: '交易完成...';
  }
  50% {
    content: '訂單成立中...';
  }
  75% {
    content: '訂單成立中...';
  }
  100% {
    content: '訂單已成立...';
  }
}

</style>
</head>
<body>


<div class="loader">
  <div class="loader-wheel"></div>
  <div class="loader-text"></div>
</div>


<script type="text/javascript">

document.addEventListener("DOMContentLoaded", function() {
    // 獲取 .loader-text 元素
    var loaderText = document.querySelector('.loader-text');
    
    // 監聽 .loader-text 元素的動畫結束事件
    loaderText.addEventListener('animationend', function() {
  
        
        // 在動畫完成後兩秒後執行頁面導航函數
        redirectToHomepage();
    });
});

// 執行頁面導航函數
function redirectToHomepage() {
    setTimeout(function() {
        window.location.href = "back_end/management.jsp";
    }, 1000); // 2000 毫秒為兩秒
}

sessionStorage.clear();

</script>


</body>
</html>