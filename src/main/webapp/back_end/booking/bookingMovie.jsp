<%@page import="com.service.BookingService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.List" %>
<%@ page import="com.service.*" %>
<%@ page import="java.util.Set" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>快速訂票</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/back_end/booking/bookingMovie.css"/>
 <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

<jsp:include page="../management.jsp" />
 <section class="showtimes">
        <div class="content">

            <form action="<%= request.getContextPath() %>/BookingController" id="formShowTime" method="post">
            <input id="showDate" name="showDate" type="hidden" value="" />
              <input type="hidden" name="action" value="formShowTime">
                <div class="search">
                    <h1 class="title">場次查詢 SHOWTIMES</h1>
                    <select id="selectDate" name="selectDate" class="browser-default">
                        <option value="" disabled selected>選擇日期</option>
                       
                    </select>
                    <button class="btn waves-effect waves-light red btn_search btnCalss" >
                    <i class='bx bx-search'></i>查詢</button>

                </div>
            </form>

           <% 
           LocalDate today = LocalDate.now();
           DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
           String todayStr = today.format(dateFormatter);
           List<Movie> movies=(List<Movie>)request.getAttribute("movies");
           BookingService bookingService=new BookingService();
           if(movies==null){
        	  
        	   movies=bookingService.findMoviesShowingToday(todayStr);
           }
           
           for(Movie movie:movies){
           
           
           %>
              
            <form action="<%= request.getContextPath() %>/BookingController" method="post">
                <input name="__RequestVerificationToken" type="hidden" value="" />
                <div class="card">
                    <div class="row">
                        <div class="movie_info col l7 m7 s12">
                            <div class="row">
                                <!--照片大小185*270-->
                                <img src="data:image/jpeg;base64,<%=movie.getPicBase64()%>">
                                <div class="movie_deatils">
                                    <div class="movie_title"><%=movie.getMovieName() %></div>
                                    <div class="language">(<%=movie.getLanguage() %>)</div>
                                    <p>
                                    <ul class="movie_data" id="movie_data">
                                        <li><i class='bx bx-calendar-check'></i>上映日期：<%=movie.getReleaseDate() %></li>
                                        <li><i class='bx bx-time-five'></i>片長：<%=movie.getRuntime() %></li>
                                        <li><i class='bx bxs-film'></i>級數： <span class="rating"><%=movie.getRating() %></span></li>
                                    </ul>
                                    
                                </div>

                            </div>
                            <div class="movie_times col l5 m5 s12">
                                <div class="movie_session"><i class="material-icons left"></i>請選擇場次:</div>
                                <div class="room">
                                
                                <%
                                
                                String screen="";
                                Set<ShowtimeInfo> showtimes = movie.getShowtime();

                                  for(ShowtimeInfo showtime :showtimes){
                                	  
                                    if(screen!=showtime.getScreen().getScreenId()){
                                %>
                                  <span class="font_blue">
                                    <%=showtime.getScreen().getScreenId() %>
                                  </span>
                              </div>
                                
                                
                                <ul class="btn_time">
                                  
                                <%  screen=showtime.getScreen().getScreenId(); 
                                    }
                                  
                                %>
                             
                                    <li>
                                         <input type="submit" name="startTime" value="<%=bookingService.startTime(showtime.getShowtime())%>"  onclick="setHiddenValue('<%=showtime.getShowtimeId()%>')">
                                    </li>
                                 <%  } %>   
                                </ul>

                            </div>
                        </div>
                    </div>
                </div>
                 <input type="hidden" name="action" value="bookWhichShow">
                <input type="hidden" name="selectedTime" class="selectedTime" value="">
            </form>
            
            <%
            
           }
            %>
        </div>

        </section>
        
        
         <script>

            let selectDate=document.getElementById('selectDate');
            let showDate = document.getElementById('showDate');

            function thenextTenDays(startDate,tenDays){

                for(var i=0;i<tenDays;i++){

                    var date=new Date();
                    date.setDate(date.getDate()+startDate+i);
                   
                    
                    var year = date.getFullYear().toString();



                    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份
				        var day = date.getDate().toString().padStart(2, '0'); // 日期
				
				        var option = document.createElement('option');
				        option.value = year+'-'+ month + '-' + day; // Format: MM/DD
				        option.text = year+'-'+ month + '-' + day;
				        selectDate.appendChild(option);
                }



            }
            
            //選日期時觸發 把日期值也帶入隱藏的input按鈕
            selectDate.addEventListener('change', function(event) {
                var selectedDate = event.target.value;
                showDate.value = selectedDate;
                saveDate(selectedDate);   //change事件觸發時把日期值也一併存在storage
            });

            thenextTenDays(0,10);
            
            function saveDate(selectedDate) {
                sessionStorage.setItem("selectedDate", selectedDate);//暫存在storage的方法
            }
            
            window.onload = function() {
                var selectedDate = sessionStorage.getItem("selectedDate");//畫面載入時去storage查看有沒有站存的日期
                if (selectedDate) {
                	selectDate.value=selectedDate;
                    
                }
            }
            
            
            var lis = document.getElementsByTagName('li');

            for(var i=0;i<lis.length;i++){
            	var button = lis[i].querySelector('input[type="submit"]');
         
            	console.log(button);
            	
            }
            
            
            //因為多個 form表單 都有隱藏的 input tag 抓取點擊時的時間對應的場次ID
            function setHiddenValue(value) {
                let selectedTimes = document.querySelectorAll('.selectedTime');
                
                selectedTimes.forEach(function(eachSelectedTime) {
                    eachSelectedTime.value = value;
                });
            }

        </script>
         
</body>
</html>