<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.entity.*"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>世界影城 HelloWorld Cinema</title>
    <link rel="icon" href="<%=request.getContextPath()%>/front_end/index/img/icon.ico" type="image/x-icon">

    <meta name="description" content="世界影城、提供電影介紹、場次時刻表、購票資訊、會員網路訂票服務、電影周邊商品販售、影廳場地租借服務">
    <meta name="keywords" content="世界、電影、世界影城、HelloWorld Cinema" />
    <meta name="robots" content="Index,follow">
    <meta property="og:title" content="世界影城" />
    <meta property="og:image" content=".img/bk.jpg" />
    <meta property="og:site_name" content="世界影城網站" />
    <meta property="og:url" content="https://www.ambassador.com.tw" />
    <meta property="og:description" content="世界影城、提供電影介紹、場次時刻表、購票資訊、會員網路訂票服務、電影周邊商品販售、影廳場地租借服務" />
    <!-- RWD -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    
    
    
    
    <!-- 底部footer -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    
    
    
    <!-- 主要css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/index/css/index.css" />
    <style>
        .notice {
            position: relative;
            display: inline-block;
            margin-left: 350px;
        }
        .notice-list {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            width: 250px; 
            max-height: 250px; 
            overflow-y: auto;
            background-color: white;
            border: 1px solid #ccc;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        .notice-list.show {
            display: block;
        }
        .notice-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .notice-item:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>


<% 
Object memObject = session.getAttribute("mem");
Mem mem = null;
if (memObject instanceof Mem) {
    mem = (Mem) memObject; 
}
%>
    <!-- 選單 -->
    <header class="header">
        <div id="box" class="logo">
            <h1 class="neon"><a href="<%=request.getContextPath()%>/front_end/homePage.jsp"><span class="logo_el">H</span>ello<span class="logo_el">W</span>orld <span class="logo_el">C</span>inema</a></h1>
        </div>
        <div id="box">
            <nav class="nav">
                <ul class="nav_menu">
                    <li class="nav__menu-item">
                        <a href=""><h4 class="neon2">影城資訊</h4></a>
                        <ul class="nav__submenu">
                            <li class="nav__submenu-item">
                                <a href="<%=request.getContextPath()%>/front/homeAnn.do?action=getAll">最新資訊</a>
                            </li>
                            <li class="nav__submenu-item">
                                <a href="<%=request.getContextPath()%>/front_end/aboutPage/ticketDetail.jsp">票價說明</a>
                            </li>
                            <li class="nav__submenu-item">
                                <a href="<%=request.getContextPath()%>/front_end/movie/movieCommingSoon.jsp">即將上映</a>
                            </li>
                            <li class="nav__submenu-item">
                                <a href="<%=request.getContextPath()%>/front_end/movie/movieNowShowing.jsp">現正熱映</a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav__menu-item">
                        <a href=""><h4 class="neon2">線上訂票</h4></a>
                        <ul class="nav__submenu">
                            <li class="nav__submenu-item">
                                <a href=""></a>
                            </li>

                        </ul>
                    
                    </li>
                    <li class="nav__menu-item">
                        <a href="<%=request.getContextPath()%>/front_end/merch/merchStore.jsp"><h4 class="neon2">周邊商城</h4></a>
                        <ul class="nav__submenu">
                            <li class="nav__submenu-item">
                                <a href=""></a>
                            </li>

                        </ul>
                    </li>
                    <li class="nav__menu-item">
                        <a href=""><h4 class="neon2">場地租借</h4></a>
                        <ul class="nav__submenu">
                            <li class="nav__submenu-item">
                                <a href="">場地租借須知</a>
                            </li>
                            <li class="nav__submenu-item">
                                <a href="">可租借場地資訊</a>
                            </li>
                            <li class="nav__submenu-item">
                                <a href="">租借表單填寫</a>
                            </li>
                        </ul>
                    </li>

                     <% if (mem != null) { %>
                    <li class="nav__menu-item">
                        <a href="#">
                         <h4 class="neon2">
            <%= mem.getMemName() != null ? mem.getMemName() : "Log In" %>
                      </h4>
                        </a>
                        <ul class="nav__submenu">
                             <li class="nav__submenu-item">
                                <a href="<%=request.getContextPath()%>/front_end/booking/booking.jsp">電影訂單</a>
                            </li>
                            <li class="nav__submenu-item">
                                <a href="<%=request.getContextPath()%>/front/message.do?action=getMem">個人通知</a>
                            </li>
                            <li class="nav__submenu-item">
                                <a href="<%=request.getContextPath()%>/merchOrder/merchOrder.do?action=showById&memId=${memId}">周邊訂單</a>
                            </li>
                            <li class="nav__submenu-item">
                                <a href="<%=request.getContextPath()%>/front/review.do?action=getMem">個人評論</a>
                            </li>
                            
                             <li class="nav__submenu-item">
                                <a href="javascript:void(0);" onclick="logout()">登出</a>
                            </li>
                 <%}else{ %>
                 
                 <li class="nav__menu-item">
                        <a href="<%=request.getContextPath()%>/front_end/mem/mem.jsp">
                         <h4 class="neon2">
                       Log In
                      </h4>
                        </a>
                        <ul class="nav__submenu">
                            
                            <%} %>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="notice">
            	<a href=""><h4 class="neon2"><i class="far fa-bell"></i></h4></a>
            	<div class="notice-list" id="notice-list">
            		<!-- 通知項目會動態插入 -->
            		<ul class="msg_list" id="msg_list">
            		</ul>
                </div>
            </div>
        </div>
        
    </header>

<script>
        function logout() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "<%=request.getContextPath()%>/front_end/mem/logout.jsp", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    window.location.href = "<%=request.getContextPath()%>/front_end/movie/movieNowShowing.jsp";
                }
            };
            xhr.send();
        }
        
        const userId = "<%= mem != null ? mem.getMemId() : "" %>";
        console.log("userId: ", userId);
        const wsUrl = `${pageContext.request.contextPath}/socket/message?userId=\${userId}`;
        console.log("WebSocket URL: ", wsUrl);
        const socket = new WebSocket(wsUrl);
        socket.onopen = function(event) {
            console.log('WebSocket is connected.');
            socket.send(userId);
        };

        socket.onmessage = function(event) {
        	console.log('Received message from server:', event.data);
        	try{
        		const message = JSON.parse(event.data);
                console.log('解析後的通知:', message);
                displayNotification(message);
        	} catch (error) {
                console.error('解析有問題:', error);
            }
            
        };
		
        socket.onclose = function(event) {
            console.log('WebSocket is closed now.');
        };
        
        socket.onerror = function(error) {
            console.log('WebSocket Error: ' + error);
        };

        function displayNotification(message) {
            console.log("displayNotification called with message:", message);
            if (message == null) {
                console.log("message in js is null");
            } else {
                console.log("message in js is correct");

                // 確認資料
                const msgId = message.msgId;
		        const msgTitle = message.msgTitle;
		        const msgTime = message.msgTime;
		
		        console.log("message.msgId:", msgId);
		        console.log("message.msgTitle:", msgTitle);
		        console.log("message.msgTime:", msgTime);

                // 轉換時間格式
                const date = new Date(msgTime);
                const formattedDate = date.toLocaleString();

                const msg_list = document.getElementById('msg_list');
                if (msg_list) {
                    console.log("'msg_list' element found");

                    const listItem = document.createElement('li');
                    const dynamicContent = `<a href="${pageContext.request.contextPath}/front/message.do?action=getMessage&msgId=\${msgId}">\${msgTitle}</a><span>\${formattedDate}</span>`;
                    console.log("Dynamic content to be inserted:", dynamicContent);
                    
                    listItem.innerHTML = dynamicContent;
                    msg_list.appendChild(listItem);
                } else {
                    console.error("'msg_list' element not found in the DOM");
                }
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const noticeElement = document.querySelector('.notice');
            const noticeList = document.querySelector('.notice-list');

            noticeElement.addEventListener('mouseenter', function() {
                noticeList.classList.add('show');
            });

            noticeElement.addEventListener('mouseleave', function() {
                noticeList.classList.remove('show');
            });
        });
        
    </script>

