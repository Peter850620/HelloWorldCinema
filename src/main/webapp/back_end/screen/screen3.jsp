<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.dao.*"%>

<%@ page import="java.util.Set"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>




<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>C廳</title>
<link rel="stylesheet" href="./back_end/screen/screen3.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link></link>
</head>
<body>

<jsp:include page="../management.jsp" />

	<!-- ====================座位渲染區域 test======================= -->
	
	<div class="theatre">
		<div class="screen-side">
			<div class="screen">銀幕</div>
			<%		
			ShowtimeInfo show = (ShowtimeInfo)session.getAttribute("whichShow");
			
			%>
			<h3 class="select-text">請選擇座位</h3>
			<h3 class="select-text">電影:<%=show.getMovie().getMovieName() %></h3>
			<input type="hidden" id="myshowtimeInfo"value="<%=show.getShowtimeId()%>">
		</div>
		<div class="exit exit--front"></div>
		<ol class="cabin">

			<li class="row row--A">
				<ol class="seats" type="A">
					<%
					 //取得場次資訊
					String seatStatus = show.getSeatStatus();   //取得該場次所有座位
					
					Pattern pattern = Pattern.compile("([A-N][0-9]+[N,Y])");
					Matcher matcher = pattern.matcher(seatStatus);
					String currentRow = "A"; // 追蹤目前是第幾排ROW

					while (matcher.find()) {
						String eachSeat = matcher.group(1);
						String row = eachSeat.substring(0, 1); //取出ROW的第一個字母
						String ableToBook = eachSeat.substring(3, 4);
						String firstThreeLetter = eachSeat.substring(0, 3);
						if (!row.equals(currentRow)) { // 如果目前的ROW不符合取出的座位號碼排數
					%>
				</ol>
			</li>

			<li class="row row--<%=row%>">
				<ol class="seats" type=<%=row%>>

					<%
					currentRow = row; // 更新ROW 名字ˋ
					}
					%>


					<%
					switch (ableToBook) {
					case "N":
					%>

					<li class="seat">
					<input type="checkbox"  id="<%=firstThreeLetter%>" name="seatStatus" value="<%=eachSeat%>" disabled />
				     <label for="<%=firstThreeLetter%>"><%=firstThreeLetter%></label>
				    </li>

					<%
					break;

					case "Y":
					%>


					<li class="seat"><input type="checkbox"
						id="<%=firstThreeLetter%>" name="seatStatus"
						value="<%=eachSeat%>"  onclick="toggleSeat(this.id, this.checked);"/> <label
						for="<%=firstThreeLetter%>"><%=firstThreeLetter%></label></li>


					<%
					break;

					case "F":
					%>
					 
					 <li class="seat">
					<input type="checkbox"  id="<%=firstThreeLetter%>" name="seatStatus" value="<%=eachSeat%>" disabled />
				     <label for="<%=firstThreeLetter%>"><%=firstThreeLetter%></label>
				    </li>
					
					<%
					                     }
					}
					%>
				</ol>
			</li>



		</ol>
		<div class="exit exit--back"></div>

		<div class="sub">

			<ul class="pay">

				<li class="total">
					<h3>選取:</h3>
					<p id="selectedCount"></p>
				</li>
				<li class="price">
					<h3>總額:</h3>
					<p id="totalprice"></p>
				</li>
			</ul>
			
			


			<!-- 遞增遞減 -->
			<div class="container">
			
			<%
			

			char dimClass = '`'; 
			TicketDAOImpl ticketdao=new TicketDAOImpl();
			
			List<Ticket> tickets=ticketdao.getAllforbooking();
			for(Ticket ticket:tickets){
				
				dimClass++;
			
			%>
				<div class="input-row">
					<div class="title">
						<h3 class="label-一般票"><%=ticket.getTkName() %></h3>
						<!-- <p class="description">People 18 years old and above.</p> -->
					</div>
					<div class="input">
						<button class="minus" aria-label="Decrease by one" disabled>
							<svg width="16" height="2" viewBox="0 0 16 2" fill="none"
								xmlns="http://www.w3.org/2000/svg">
                                <line y1="1" x2="16" y2="1"
									stroke="#0064FE" stroke-width="2" class="icon" />
                            </svg>
						</button>
						<div class="number dim_<%=dimClass%>">0</div>
						<p name="price<%=dimClass%>"><%=ticket.getTkPrice() %></p>
						<button class="plus" aria-label="Increase by one">
							<svg width="16" height="16" viewBox="0 0 16 16" fill="none"
								xmlns="http://www.w3.org/2000/svg" class="icon">
                                <line x1="8" y1="4.37114e-08" x2="8"
									y2="16" stroke="#0064FE" stroke-width="2" />
                                <line y1="8" x2="16" y2="8"
									stroke="#0064FE" stroke-width="2" />
                            </svg>

						</button>
					</div>
				</div>
			
<%} %>

			</div>

			<div class="continue">
              <a class="nextStep" href=./back_end/booking/foodOrder.jsp>
				<input type="button" ><i
					class="fas fa-regular fa-credit-card"></i>Next Step</input>
					</a>
			</div>

		</div>
	</div>





<script src="./back_end/screen/screen.js"></script>


    <script type="text/javascript">
        var ws;
        var seats = new Set();  // 當前用戶存取選的座位
        var showid=document.getElementById("myshowtimeInfo").value;
 

        window.onload = function() {
            connectWebSocket();
            updateSelectedCount();
          
        };

        function connectWebSocket() {
        	
        	var wsPath = "${pageContext.request.contextPath}/seatSyncc";

        	// 創建 WebSocket 對象
        	 ws = new WebSocket(wsPath);
      

            ws.onmessage = function(event) {
                var message = event.data;
                
                console.log("Received message:", message); 
                var seatInfo = message.split(',');
                var seatId = seatInfo[0];   //取得座位號碼
                var seatStatus =seatInfo[1].trim();   //取得狀態
                var sentedShowId=seatInfo[2];   //取得場次
             
                if(sentedShowId!==showid){
                	
                	return;
                }
                
                if (seatStatus.startsWith("錯誤")) {    //如果用戶取消非自己的座位時會傳送ERROR回來
                    alert(seatStatus);
                    var checkbox = document.getElementById(seatId);
                    if (checkbox) {
                        checkbox.checked = true;
                        seats.delete(seatId);
                        console.log( "我是選到別人"+selectedSeats);
                    }
                    
                } else {
                    var checkbox = document.getElementById(seatId);
                    if (checkbox) {
                        checkbox.checked = (seatStatus === 'selected');
                    } else {
                        console.error('找不到ID為', seatId, '的座位元素');
                    }
                }
            };

            ws.onopen = function() {
                console.log('WebSocket 連接已開啟。');
            };

            ws.onclose = function(event) {
                console.log('WebSocket 連接已關閉。關閉碼：', event.code);
            };

            ws.onerror = function(err) {
                console.error('WebSocket 錯誤：', err);
            };
        }

        function toggleSeat(seatId, isChecked) {
       

            if (ws && ws.readyState === WebSocket.OPEN) {
                var message = seatId + "," + (isChecked ? 'selected' : 'cancelled')+","+showid;
                ws.send(message);  //發送給服務器
               
                
                if (isChecked) {
                    seats.add(seatId);
                  
                  
                } else {
                    seats.delete(seatId);
                  
                }
                updateSelectedCount();
                
                
            } else {
                console.error("WebSocket 未連接或關閉。");
            }
        }
        



        //更新P標籤的功能
            function updateSelectedCount() {
            let howmanyseat = seats.size;
            	document.getElementById('selectedCount').textContent = howmanyseat;
            	sessionStorage.setItem("quantity", howmanyseat);


            }

        
    </script>
</body>
</html>
	