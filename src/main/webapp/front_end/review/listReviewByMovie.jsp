<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
	    
	    body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .description {
            display: flex;
            align-items: center;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
            margin: 20px;
            border-radius: 10px; 
        }

        .movieImg {
            flex: 0 0 auto; 
            margin-right: 20px; 
        }

        .movieImg img {
            width: 250px;
            height: 300px;
            object-fit: cover;
            border-radius: 10px;
        }

        .textIntro {
            color: #333;
            width: 60%;
            margin: 0;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        .textIntro h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .textIntro span {
            font-size: 16px;
            line-height: 1.6;
        }

        .main {
            padding: 20px;
            margin: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px; 
        }

        .main a {
            display: inline-block;
            margin-right: 10px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px; 
            transition: background-color 0.3s;
        }

        .main a:hover {
            background-color: #0056b3;
        }

        .container {
            padding: 20px;
        }

        .reviewlist {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 10px; 
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
        }

        .reviewItem {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        .content_footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }

        .editTime {
            color: #888;
            font-size: 14px;
        }

        .content_report button {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px; 
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .content_report button:hover {
            background-color: #e60000;
        }

        button#showBtn {
            display: block;
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

        .reviewDetails {
            width: 100%;
            height: 60px;
            resize: none;
            box-sizing: border-box;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px; 
            border: 1px solid #ccc;
        }

        .comment input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px; 
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .comment input[type="submit"]:hover {
            background-color: #0056b3;
        }

		.modal {
		    display: none;
		    position: fixed;
		    z-index: 1;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    overflow: auto;
		    background-color: rgba(0, 0, 0, 0.4);
		}
		
		.modal-content {
		    background-color: #fefefe;
		    margin: 15% auto;
		    padding: 20px;
		    border: 1px solid #888;
		    width: 30%;
		    border-radius: 10px; 
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
		    display: flex; 
		    flex-direction: column; 
		    align-items: center;
		}
		
		.close {
		    align-self: flex-end;
		    color: #aaa;
		    font-size: 28px;
		    font-weight: bold;
		    cursor: pointer;
		}
		
		.close:hover,
		.close:focus {
		    color: black;
		    text-decoration: none;
		}
		
		.modal-content form {
		    width: 100%;
		}
		
		.modal-content label,
		.modal-content select,
		.modal-content input[type="submit"] {
		    width: 100%;
		    margin-bottom: 15px;
		}
		
		.modal-content textarea {
			width: 100%;
			height: 200px;
		    margin-bottom: 15px; 
			resize: none;
		}
	</style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div class="xxx" id="xxx">
	 <div class="description">
        <div class="movieImg">
            <img src="<%= request.getContextPath() %>/movie/MovieGifReader?movieId=${oneMovie.movieId}" alt="Image">
        </div>
        <div class="textIntro" id="textIntro">
            <h1>${oneMovie.movieName}</h1>
            <span>${oneMovie.movieInfo}</span>
        </div>
    </div>
    <hr>

	
	<div class="main" id="main">
		<a href="<%= request.getContextPath() %>/front/message.do?action=getMem&mem=240001">進入個人通知</a>
		<a href="<%= request.getContextPath() %>/front/review.do?action=getMem&mem=240001">進入個人評論</a>
		<a href="<%= request.getContextPath() %>/front_end/review/reviewFront.jsp">回主頁</a>
		<a href="<%= request.getContextPath() %>/front/review.do?action=getMovie&movie=${oneMovie.movieId}">所有評論</a>
		<div class="container">
        	<div class="reviewlist" id="reviewlist">
        		<c:forEach var="review" items="${reviewList}">
       				<div class="reviewItem">
		               <span class="content_mem">${review.mem.memId}</span>
		               <article class="content_article">
		                   <span class="content_detail">${review.reviewDetails}</span>
		               </article>
		               <div class="content_footer">
		                   <div class="timeItem">${review.reviewDate}</div>
		                   <div class="content_report">
		                   	<button type="button" onclick="showReportModal(${review.reviewId})">檢舉</button>
		                   </div>
		               </div>
	               </div>
       			</c:forEach>
       			<div class="comment">
		            <form method="post" action="<%= request.getContextPath() %>/front/review.do" id="reviewForm">
		                <textarea name="reviewDetails" class="reviewDetails" id="reviewDetails" placeholder="留言..."></textarea>
		                <span  id ="reviewDetails.errors" class="error">${errorMsgs.reviewDetails}</span>
		                <input type="hidden" name="movie" value="${oneMovie.movieId}">
		                <input type="hidden" name="action" value="insert">
		                <input type="submit">
		            </form>
        		</div>
       		</div>
       	</div>
       <button id="showBtn">顯示更多</button>
	</div>
	
	<div id="reportModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form method="post" action="<%= request.getContextPath() %>/front/report.do" id="rptForm">
                <label for="rptType">檢舉類型:</label>
				<select id="rptType" name="rptType" required>
			        <option value="色情或裸露內容">色情或裸露內容</option>
			        <option value="暴力或仇恨言論">暴力或仇恨言論</option>
			        <option value="垃圾訊息或廣告其他違規行為">垃圾訊息或廣告其他違規行為</option>
			    </select>
				<span  id ="rptType.errors" class="error">${errorMsgs.rptType}</span>

                <label for="rptDetail">檢舉內容:</label>
				<textarea id="rptDetail" name="rptDetail" onclick="hideContent('rptDetail.errors');" required>${param.rptDetail}</textarea>
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

   	    document.querySelector("#rptForm").addEventListener("submit", function(event) {
   	    	event.preventDefault();

	        var formData = new FormData(this);

	        fetch('<%= request.getContextPath() %>/front/report.do?action=insert', {
	            method: 'POST',
	            body: formData
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                alert('檢舉成功');
	                document.getElementById("reportModal").style.display = "none";
	            } else {
	                alert('檢舉失敗: ' + data.errorMessage);
	            }
	        })
	        .catch(error => console.error('Error:', error));
	    });
		
   	 	document.querySelector("#reviewForm").addEventListener("submit", function(event) {
	    	event.preventDefault();

	        var formData = new FormData(this);

	        fetch('<%= request.getContextPath() %>/front/review.do?action=insert', {
	            method: 'POST',
	            body: formData
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                alert('留言成功');
            		document.getElementById("reviewDetails").value = '';
	            } else {
	                alert('留言失敗: ' + data.errorMessage);
	            }
	        })
	        .catch(error => console.error('Error:', error));
	    });
   	 
		function showReportModal(reviewId) {
            var modal = document.getElementById("reportModal");
            var span = document.getElementsByClassName("close")[0];
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
	
		document.addEventListener('DOMContentLoaded', () => {
	        const reviewBody = document.getElementById('reviewlist');
	        const rows = Array.from(reviewBody.getElementsByClassName('reviewItem'));

	        rows.forEach(row => {
	            const dateCell = row.querySelector('.timeItem');
	            const date = new Date(dateCell.textContent.trim());
	            dateCell.textContent = date.toISOString().slice(0, 19).replace('T', ' ');
	            row.reviewDateValue = date.getTime();
	        });

	        rows.sort((a, b) => b.reviewDateValue - a.reviewDateValue);

	        rows.forEach(row => reviewBody.appendChild(row));
	    });
	
	</script>
</body>
</html>