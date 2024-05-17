<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>

	<style>
	  
	  .item-container {
	    display: flex;
	    flex-wrap: wrap;
	  }
	
	  .item {
	    width: calc(20% - 20px); /* 20% 寬度，並考慮 margin */
	    margin: 10px; /* 每個 item 的 margin */
	    box-sizing: border-box; /* 考慮 padding 和 border 的寬度 */
	  }
	
	  /* 每行第五個 item */
	  .item-container .item:nth-child(5n+1) {
	    clear: left; /* 清除左邊浮動 */
	  }
		
	</style>
</head>
<body>

<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->

<!-- <section id="content" class="inner-container">
    <div class="cookie-message notice show">
      <div class="notice-icon"><i class="fa fa-info-circle"></i></div>
      <p>Your personal online video library that allows you to watch streaming movies in high definition for free and without limits on PC, Smart TV, Console, tablet and smartphone.</p>
      <div class="close-notice"><i>x</i></div>
    </div> -->

 
    
	
 	<div id="xxx">
 		
 		<div class="item-container">
	 		<%--<c:forEach var="" item="">--%>
 				<%-- <form method="post" action="<%= request.getContextPath() %>/front/review.do"> --%>
 					<div class="item">
				        <a href="<%= request.getContextPath() %>/front/review.do?action=getMovie&movie=1">
				        
				          <div class="item-flip">
				            <div class="item-inner">
				              <img src="<%= request.getContextPath() %>/images/hakunamatata.jpg" alt="Archive">
				            </div>
				            <div class="item-details">
			                	<h2 class="movie-title">Archive</h2>
				          	</div>
				          </div>
				          <!-- <input type="hidden" name="movie" value="1"> -->
				        </a>
				      </div>
				      <!-- <input type="submit" value="getByMovie"> -->
 				<!-- </form> -->
		      
		      
	      	<%--</c:forEach>--%>
	      
	      
	      
	      <div class="container">
	      	<div class="movie">
	      		<form method="post" action="<%= request.getContextPath() %>/front/review.do">
	      			
	      		</form>
	      	</div>
	      </div>
 		</div>
	</div>



<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    
</body>
</html>