<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back_end/orderTicket/index/css/index.css" />
    
</head>
<body>

    <!-- 選單 -->
    <header class="header">
        <div id="box" class="logo">
            <h1 class="neon"><a href="index.html"><span class="logo_el">H</span>ello<span class="logo_el">W</span>orld <span class="logo_el">C</span>inema</a></h1>
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
                                <a href="">票價說明</a>
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
                        <a href="merchStore.html"><h4 class="neon2">周邊商城</h4></a>
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
                    <li class="nav__menu-item">
                        <a href=""><h4 class="neon2">Log In</h4></a>
                        <ul class="nav__submenu">
                            <li class="nav__submenu-item">
                                <a href=""></a>
                            </li>

                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
        
    </header>


<br>

