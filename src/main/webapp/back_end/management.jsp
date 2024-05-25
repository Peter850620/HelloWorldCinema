<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>世界影城</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/back_end/management.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>



<body>

    <div class="sidebar-container" id="sidebar-container">
        <div class="sidebar">
            <div class="top">
                <div class="logo">

                    <i class='bx bxs-cat'></i>
                    <span>HelloWorld<br>員工後臺
                    </span>
                </div>

                <i class="bx bx-menu" id="btn"></i>
            </div>
            <div class="user">
                <img src="<%=request.getContextPath() %>/images/hakunamatata.jpg" alt="fang" class="user-img">
                <div>
                    <p class="bold">Client B.</p>
                    <p>Admin</p>
                </div>


            </div>

            <ul>
                <li>
                    <a href="<%=request.getContextPath() %>/back_end/booking/bookingMovie.jsp">
                        <i class="bx bxs-grid-alt"></i>
                        <span class="nav-item">售票管理

                        </span>

                    </a>

                    <span class="tooltip">售票管理</span>

                    <div class="side">
                        <a class="items" href="<%=request.getContextPath() %>/back_end/booking/bookingSearch.jsp">
                            <span class="itemstooltip">查詢電影訂單</span>
                        </a>
                        <a class="items" href="<%=request.getContextPath() %>/back_end/booking/bookingMovie.jsp">
                            <span class="itemstooltip">現場畫位</span>
                        </a>
                        <a class="items" href="<%= request.getContextPath() %>/back_end/merchOrder/select_page.jsp">
                            <span class="itemstooltip">周邊訂單</span>
                        </a>
                    </div>

                </li>
                <li>
                    <a href="">
                        <i class='bx bx-chalkboard'></i>
                        <span class="nav-item">會員管理</span>
                    </a>
                    <span class="tooltip">會員管理</span>

                    <div class="side">
                        <a class="items" href="">
                            <span class="itemstooltip">會員查詢</span>
                        </a>
                        <a class="items" href="">
                            <span class="itemstooltip">帳號停權/復權</span>
                        </a>
                        <a class="items" href="<%= request.getContextPath() %>/back/message.do?action=getAll">
                            <span class="itemstooltip">個人公告</span>
                        </a>
                    </div>
                </li>


                <li>
                    <a href="">
                        <i class='bx bxs-discount'></i>
                        <span class="nav-item">影廳管理</span>
                    </a>
                    <span class="tooltip">影廳管理</span>


                    <div class="side">
                        <a class="items" href="<%= request.getContextPath() %>/back_end/showtimeInfo/listAllShowtimeInfo.jsp">
                            <span class="itemstooltip">場次管理</span>
                        </a>
                        <a class="items" href="<%= request.getContextPath() %>/back_end/ticket/select_page.jsp">
                            <span class="itemstooltip">票種管理</span>
                        </a>

                    </div>
                </li>
                <li>
                    <a href="">
                        <i class='bx bxs-movie'></i>
                        <span class="nav-item">資訊管理</span>
                    </a>
                    <span class="tooltip">資訊管理</span>


                    <div class="side">
                        <a class="items" href="<%= request.getContextPath() %>/back_end/movie/listAllMovie.jsp">
                            <span class="itemstooltip">電影資訊管理</span>
                        </a>
                        <a class="items" href="<%= request.getContextPath() %>/back/review.do?action=getAll">
                            <span class="itemstooltip">討論區管理</span>
                        </a>
                        <a class="items" href="<%= request.getContextPath() %>/back/homeAnn.do?action=getAll">
                            <span class="itemstooltip">最新消息管理</span>
                        </a>


                    </div>
                </li>
                <li>
                    <a href="">
                        <i class='bx bx-calendar-alt'></i>
                        <span class="nav-item">商城管理</span>
                    </a>
                    <span class="tooltip">商城管理</span>

                    <div class="side">
                        <a class="items" href="<%= request.getContextPath() %>/back_end/food/select_page.jsp">
                            <span class="itemstooltip">餐飲管理</span>
                        </a>
                        <a class="items" href="">
                            <span class="itemstooltip">周邊管理</span>
                        </a>



                    </div>
                </li>
                <li>
                    <a href="">
                        <i class='bx bxs-shopping-bag'></i>
                        <span class="nav-item">場地租借</span>
                    </a>
                    <span class="tooltip">場地租借</span>

                    <div class="side">
                        <a class="items" href="">
                            <span class="itemstooltip">租借單審核</span>
                        </a>
                        <a class="items" href="">
                            <span class="itemstooltip">歸還管理</span>
                        </a>



                    </div>
                </li>
                <li>
                    <a href="">
                        <i class='bx bxs-file'></i>
                        <span class="nav-item">員工管理</span>
                    </a>
                    <span class="tooltip">員工管理</span>

                    <div class="side">
                        <a class="items" href="">
                            <span class="itemstooltip">員工基本資料</span>
                        </a>
                        <a class="items" href="">
                            <span class="itemstooltip">員工權限管理</span>
                        </a>



                    </div>
                </li>
                <li>
                    <a href="">
                        <i class='bx bx-user-circle'></i>
                        <span class="nav-item">客服中心</span>
                    </a>
                    <span class="tooltip">客服中心</span>

                    <div class="side">
                        <a class="items" href="">
                            <span class="itemstooltip">客服即時通</span>
                        </a>



                    </div>
                </li>

                <li>
                    <a href="">
                        <i class="bx bx-log-out"></i>
                        <span class="nav-item">Logout</span>
                    </a>
                    <span class="tooltip">Logout</span>
                </li>
            </ul>
        </div>
    </div>

</body>
<script src="<%=request.getContextPath() %>/back_end/management.js">
   


</script>

</html>