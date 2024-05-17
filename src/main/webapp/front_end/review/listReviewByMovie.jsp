<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
    	
		.reviewlist{
            background-color: aliceblue;
            border: solid;
        }
        .reviewItem{
            border: solid yellow;
            word-wrap: break-word; 
            overflow-wrap: break-word; 
        }

        .description {
            display: flex;
            align-items: center;
            padding-left: 101.852px;
            
        }

        .movieImg {
            flex: 0 0 auto; 
            margin-right: 20px; 
        }

        .textIntro {
            color: aliceblue;
            width: 60%;
            margin: 0px; 
            padding-bottom: 200px;
            word-wrap: break-word; 
            overflow-wrap: break-word;
          
        }

        .reviewDetails {
            height: 30px; 
            width: 90%; 
            resize: none; 
            box-sizing: border-box;
        }

        .comment {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0px -2px 10px rgba(0, 0, 0, 0.1);
            z-index: 999; 
       	}
       	
       	.content_footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
          /* 檢舉彈窗 */
	    .modal {
	        display: none;
	        position: fixed;
	        z-index: 1;
	        left: 0;
	        top: 0;
	        width: 100%;
	        height: 100%;
	        overflow: auto;
	        background-color: rgb(0,0,0);
	        background-color: rgba(0,0,0,0.4);
	    }
	    .modal-content {
	        background-color: #fefefe;
	        margin: 15% auto;
	        padding: 20px;
	        border: 1px solid #888;
	        width: 80%;
	        
	    }
	    .close {
	        color: #aaa;
	        float: right;
	        font-size: 28px;
	        font-weight: bold;
	    }
	    .close:hover,
	    .close:focus {
	        color: black;
	        text-decoration: none;
	        cursor: pointer;
	    }
	</style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div class="xxx" id="xxx">
	 <div class="description">
        <div class="movieImg">
            <img src="<%= request.getContextPath() %>/images/hakunamatata.jpg" alt="Archive">
        </div>
        <div class="textIntro" id="textIntro">
            <h1>大尾鱸鰻</h1>
            <span>ahhahahahahahahahahahahahahahahahhaahahahahahahahooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo</span>
        </div>
    </div>
    <hr>

	
	<div class="main" id="main">
	<a href="<%= request.getContextPath() %>/front/message.do?action=getMem&mem=240001" style="color: white;">進入個人通知</a>
		<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&mem=240001" style="color: white;">進入個人評論</a>
		<a href="<%= request.getContextPath() %>/front-end/review/reviewFront.jsp" style="color: white;">回主頁</a>
		
		
		<div class="container">
		
        	<div class="reviewlist">
        		<c:forEach var="review" items="${reviewList}">
       				<div class="reviewItem">
		               <span class="content_mem">${review.mem.memId}</span>
		               <article class="content_article">
		                   <span class="content_detail">${review.reviewDetails}</span>
		               </article>
		               <div class="content_footer">
		                   <div class="editTime">${review.reviewDate}</div>
		                   <div class="content_report">
		                   	<button type="button" onclick="showReportModal(${review.reviewId})">檢舉</button>
		                   </div>
		               </div>
	               </div>
       			</c:forEach>
       		</div>
           		
       	</div>
           		
       <button id="showBtn">顯示更多</button>

        <div class="comment">
            <form method="post" action="<%= request.getContextPath() %>/front/review.do">
                <textarea name="reviewDetails" class="reviewDetails" id="reviewDetails" placeholder="留言..."></textarea>
                <!-- 測試用 -->
                <!-- 測試用 -->
                <input type="hidden" name="action" value="insert">
                <input type="submit">
            </form>
        </div>
	        
		
	</div>
	
	<div id="reportModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form method="post" action="<%= request.getContextPath() %>/front/report.do">
                <!-- <input type="hidden" name="mem" id="modalMemId"> -->
                <!-- <input type="hidden" name="review" id="modalReviewId"> -->

                <label for="rptType">檢舉類型:</label>
				<select id="rptType" name="rptType" required>
			        <option value="色情或裸露內容">色情或裸露內容</option>
			        <option value="暴力或仇恨言論">暴力或仇恨言論</option>
			        <option value="垃圾訊息或廣告其他違規行為">垃圾訊息或廣告其他違規行為</option>
			    </select>
				<span  id ="rptType.errors" class="error">${errorMsgs.rptType}</span>

                <label for="rptDetail">檢舉內容:</label>
				<textarea id="rptDetail" name="rptDetail" onclick="hideContent('rptDetail.errors');" style="font-weight: bold; width: 300px; height: 100px; resize: vertical;" required>${param.rptDetail}</textarea>
				<span  id ="reviewDetails.errors" class="error">${errorMsgs.reviewDetails}</span>
                <input type="hidden" name="action" value="insert">
                <input type="hidden" id="reviewId" name="reviewId" value="">
                <input type="submit" value="submit">
            </form>
        </div>
    </div>
</div>

<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    <script>
    	document.addEventListener("DOMContentLoaded", function() {
	    var itemlist = document.querySelector('.reviewlist');
	    var items = document.querySelectorAll('.reviewItem');
	    var numItemsToShow = 10;
	    var numItems = items.length;
	    var currentIndex = 0;
	
	    function hideItemsBeyondLimit() {
	      for (var i = numItemsToShow; i < numItems; i++) {
	        items[i].style.display = 'none';
	      }
	    }
	
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
	
	    var showMoreBtn = document.getElementById("showBtn");
	    showMoreBtn.addEventListener('click', function() {
	      showMoreItems();
	    });
	
	    hideItemsBeyondLimit();
	    if (numItems > numItemsToShow) {
	      itemlist.parentNode.appendChild(showMoreBtn);
	    }
	  	});
		
		function showReportModal(reviewId) {
            var modal = document.getElementById("reportModal");
            var span = document.getElementsByClassName("close")[0];

            //document.getElementById("modalMemId").value = memId;
            //document.getElementById("modalReviewId").value = reviewId;
 			document.getElementById("reviewId").value = reviewId;
 			
            modal.style.display = "block";
	
            span.onclick = function() {
                modal.style.display = "none";
            }

            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        }
	
	
	</script>
</body>
</html>