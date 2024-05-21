<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>

</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
	
		<div class="main" align="center">
			<h3><b>所有欄位皆為必填欄位</b></h3>
			
			
			<div class="comment_body">
		       <form action="<%= request.getContextPath() %>/front/review.do" method="post">
					<div>
						<div>
						<label for="review">評論編號:</label>
						<input id ="review" name="review" type="text" value="${param.review}" onclick="hideContent('review.errors');" />
						<span  id ="review.errors" class="error">${errorMsgs.review}</span>
						</div>
						
						<label for="mem">會員編號:</label>
						<input id ="mem" name="mem" type="text" value="${param.mem}" onclick="hideContent('mem.errors');" />
						<span  id ="mem.errors" class="error">${errorMsgs.mem}<br/></span>
						</div>
						
						<div>
						<label for="rptType">檢舉類型:</label>
						<select id="rptType" name="rptType">
					        <option value="色情或裸露內容">色情或裸露內容</option>
					        <option value="暴力或仇恨言論">暴力或仇恨言論</option>
					        <option value="垃圾訊息或廣告其他違規行為">垃圾訊息或廣告其他違規行為</option>
					    </select>
						<span  id ="rptType.errors" class="error">${errorMsgs.rptType}</span>
						</div>
						
						<div>
						<label for="rptDetail">檢舉內容:</label>
						<textarea id="rptDetail" name="rptDetail" onclick="hideContent('rptDetail.errors');">${param.rptDetail}</textarea>
						<span  id ="reviewDetails.errors" class="error">${errorMsgs.reviewDetails}</span>
						</div>

						<div>
							<div></div>
							<input  type="hidden" name="action" value="insert">
							<input id ="newTime" name="rptDate" type="hidden" value="${param.reviewDate}"/>
							<button type="submit" id="submit"> 送出新增 </button>
							<div></div>
						</div>
					</form>
					<a href="<%= request.getContextPath() %>/front/review.do?action=getMovie">回查詢頁</a>
			</div>
	
		
		</div>
	</div>





<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    <script src="./js/index.js"></script>
    <script>
		function hideContent(d) {
		    document.getElementById(d).style.display = "none";
		}
	</script>
</body>
</html>