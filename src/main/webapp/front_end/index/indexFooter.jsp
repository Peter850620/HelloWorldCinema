<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<br>





    <!-- 底部footer -->
    <footer class="footer">
        <div class="titleCont">
            <h1 class="main-title" id="main-title">
                    "You must not be afraid to dream a little bigger, darling."
            </h1>
        </div>
        <div class="container">
            <div class="row">
                <div class="footer-col">
                    <h4 class="neon2">關於我們</h4>
                    <ul>
                        <li><a href="<%=request.getContextPath()%>/front_end/aboutPage/cinemaInfo.jsp">影城簡介</a></li>
                        <li><a href="<%=request.getContextPath()%>/front_end/aboutPage/transportation.jsp">影城交通</a></li>
                        <li><a href="#">影城設備</a></li>
                        <li><a href="<%=request.getContextPath()%>/front_end/aboutPage/cinemaNote.jsp">注意事項</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4 class="neon2">電影評論區</h4>
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/front/review.do?action=loadMovie">影評查詢</a></li>
                        <li><a href="#">電影分類</a></li>
                        <li><a href="#">排行榜</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4 class="neon2">客服中心</h4>
                    <ul>
                        <li><a href="<%=request.getContextPath()%>/front_end/aboutPage/FAQpage.jsp">FAQ</a></li>
                        <li><a href="#">真人聊天室</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4 class="neon2">follow us</h4>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
            <p class="copy_right">Copyright © 2024 CIA101G4. All rights reserved.</p>
        </div>
   </footer>



    
    

    <script src="<%=request.getContextPath()%>/front_end/index/js/jquery-3.4.1.min.js"></script>
    

    
</body>
</html>