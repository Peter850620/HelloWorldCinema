<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>

<%@ page import="com.entity.*"%>
<%@ page import="com.service.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>所有電影</title>
<style>

      .showtimes {
      
            font-family: Arial, sans-serif;
            margin: 20px auto;
            max-width: 800px;
            margin-left:340px;
        }
        
        h1 {
			text-align: center;
			margin-top: 20px;
		}

        .title {
            color:white;
            font-size: 24px;
        }

        .search {
            margin-bottom: 20px;
        }

        .btn_search {
            background-color: #ff0000;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
  
       .showtimes {
            font-family: Arial, sans-serif;
            margin: 20px auto;
            max-width: 800px;
            margin-left: 340px;
        }

        .title {
            color: white;
            font-size: 24px;
        }

        .search {
            margin-bottom: 20px;
        }

        .btn_search {
            background-color: #ff0000;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin-left:15px;
        }
      .btn_search:hover {
       background-color: #cc0000; 
}

        .font_red {
            color: #ff0000;
        }

        .card {
            background-color: #f9f9f9;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 900px;
        }

        .movie_info {
            display: flex;
            align-items: center;
            width: 900px;
        }

        .movie_deatils {
            margin-left: 20px;
            padding-left: 20px;
            height: 200px;
            margin-top: 40px;
        }

        .movie_info img {
            width: 200px;
            height: 270px;
            margin-right: 0px;
        }

        .movie_title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .movie_title_en {
            font-style: italic;
            color: #777;
        }

        .movie_data {
            list-style-type: none;
            padding: 0;
        }

        .movie_data li {
            margin-bottom: 5px;
            color: #555;
            width: 210px;
        }

        .movie_level {
            font-size: 14px;
            padding: 3px 8px;
            border-radius: 3px;
        }

        .font_blue {
            color: #007bff;
        }

        .movie_times {
            text-align: center;
            margin-left: 50px;
            width: 100%;
            max-height: 200px;
        }

        .movie_session {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .room {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .moredetails {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-wrap: wrap;
            margin-left: 40px;
        }

        .moredetails li {
            margin: 15px;
            display: inline-block;
            margin-right: 10px;
            width: 30%;
            margin-bottom: 3px;
            /* Set the width to 20% so that 5 items fit in one row */
        }

        /* 按鈕樣式 */
        input[type="submit"] {
            background-color: #1b7ef4;
            /* Green */
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 8px;
            margin-top: 70px;
        }


        input[type="submit"]:hover {
            background-color: #0a4285;
            /* Darker green */
        }

        /* 按鈕按下時的樣式 */
        input[type="submit"]:active {
            background-color: #3e8e41;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
       
       input[type="text"]{
       
            padding: 10px;
		    font-size: 20px;
		    border: 2px solid #ccc;
		    border-radius: 5px;
		    margin-right: 10px;
       }

        #selectStatus {
            width: 150px;
            padding: 10px;
            font-size: 20px;
            border: 2px solid #ccc;
            border-radius: 5px;
            margin-right: 10px;
        }

        .row {
            display: flex;
        }

        .room {
            text-align: left;
            /* 文字靠左侧显示 */
            display: -webkit-box;
            /* 將元素设置為-webkit-box布局 */
            -webkit-box-orient: vertical;
            /* 設置元素垂直排列 */
            -webkit-line-clamp: 3;
            /* 設置最多顯示的行數 */
            overflow: hidden;
            /* 隱藏超出部分 */
        }

        li {
            list-style: none;
        }
        
        #main_area{
        margin-left:330px;
        
        }
        
        #loadMoreButton{
	    background-color: #007bff; /* Blue background color */
	    color: #fff; /* White text color */
	    border: none; /* Remove border */
	    padding: 10px 20px; /* Add padding */
	    font-size: 16px; /* Increase font size */
	    cursor: pointer; /* Change cursor to pointer on hover */
	    border-radius: 5px; /* Add border radius */
	}
	
	#addMovie{
	margin-left:100px;
	background-color: #ff0000;
    color: #fff;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
	
	}
	
	#addMovie:hover{
	 
    background-color: #cc0000; /* 鼠标悬停时的背景颜色 */
}
	
		
		#loadMoreButton:hover{
		background-color: #0056b3; /* Darker blue color on hover */
		}
		
		
		input[type="month"] {
		  padding: 12px 12px;
		  font-size: 16px;
		  border: 1px solid #ccc;
		  border-radius: 5px;
		  width: 200px; /* 調整大小以符合你的需求 */
		}
        
    </style>
</head>
<body>
 
<jsp:include page="../management.jsp" />
 <div id="main_area">
	<h1>所有電影</h1>
	
	       <form action="<%= request.getContextPath() %>/MovieController" id="sortedListAll" method="post">
            <input id="showDate" name="movieStatus" type="hidden" value="" />
            
              <input type="hidden" name="action" value="loadmore">
                <div class="search">
                    <h1 class="title">瀏覽電影 Movies</h1>
                    <select id="selectStatus" name="sorted" class="browser-default">
                        <option value="查詢全部" selected>查詢全部</option>
                        <option value="即將上映"  >即將上映</option>
                        <option value="熱映中"  >熱映中</option>
                        <option value="已下檔"  >已下檔</option>  
                    </select>
                    <input type="text" name="keywords" placeholder="輸入電影名字">
                    <input type="month" name="releaseDate" placeholder="月份查詢">
                    
                    <button class="btn waves-effect waves-light red btn_search btnCalss" >
                    
                    <i class='bx bx-search'></i>查詢</button>
                    
                    <button id="addMovie">新增</button>
                </div>
            </form>
	
	 <div class="containerformovie" id="containerformovie">
        

    </div>
	<div class="container">

		<button id="loadMoreButton">更多结果</button>
		

	

	</div>
</div>

  <script src="<%=request.getContextPath() %>/back_end/movie/listAllmovies.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>


</body>

</html>
