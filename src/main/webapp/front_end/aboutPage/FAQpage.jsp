<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
     	body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        .main {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        hr {
            border: 0;
            height: 1px;
            background: #ddd;
            margin: 20px 0;
        }

        .question_mem {
            list-style: none;
            padding: 0;
        }

        .question_mem1 {
            display: block;
            background-color: #007BFF;
            color: white;
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .question_mem1:hover {
            background-color: #0056b3;
        }

        .question_msg {
            display: none;
            background-color: #f9f9f9;
            padding: 15px;
            margin: 10px 0;
            border-left: 4px solid #007BFF;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .question_msg p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
    <div class="main" id="main">
    	<h1>常見問題</h1>
        <hr>
		<div class="question_mem">
            <ul>
                <span class="question_mem1">如何加入會員?</span>
                <li class="question_msg">
                    <p>會員資格申請：請至世界影城官網首頁，點選會員登入/註冊 →點選「註冊會員」進行申請，</p>
                    <p>完成後請至信箱收取確認信，啟用帳號成功後，即可使用線上訂票功能。</p>
                </li>
            </ul>
            <ul>
                <span class="question_mem1">為什麼不能登入網站?</span>
                <li class="question_msg">
                   <p>請先確認</p>
                    <p>1.所輸入的帳號密碼大小寫正確，且未因複製貼上時貼到空白鍵或是key到空白鍵。</p>
                    <p> 2.帳號是否被停用、未註冊成功或是尚未完成開卡。</p>
                    <p>初次申請會員：</p>
                    <p>加入世界影城會員後，系統會主動發一封確認信至所註冊的信箱，煩請打開此封確認信且點選信件內容的連結來啟用帳號，成功後即可正常使用網站會員功能。</p>                                                           
                </li>
            </ul>
            <ul>
                <span class="question_mem1">加入會員後一直收不到會員確認信?</span>
                <li class="question_msg">
                    <p>若是一直收不到確認信的原因及處理方法如下：</p>
                    <br>
                    <p>1. email 帳號填錯或無效</p>
                    <p>處理：請洽各影城服務專線協助查詢修改。</p>
                    <p>2. 被email 帳號的郵件主機擋信(世界影城建議不要使用以下信箱註冊，以免無法收取會員確認信。)</p>
                    <p>一、Pchome、智邦的電子信箱。</p>
                    <p> 二、銀行或是公家機關的信箱。</p>
                    <p>三、若使用公司信箱註冊，請先確認 貴公司之資訊安全政策不會被擋信。</p>
                    <p>處理：繼續等待或申請更換帳號。</p>
                    <p> 3. 被email 帳號的郵件主機當成垃圾信件</p>
                    <p>處理：若信箱是使用奇摩、Pchome等免費信箱，請由網路登入信箱並至垃圾信郵件區裡面檢查是否有會員確認信。</p>
                </li>
            </ul>
            <ul>
                <span class="question_mem1">影城開始營業的時間?</span>
                <li class="question_msg">
                    <p>影城營業時間為首場電影開演前30-60分鐘，詳細開館時間請洽各影城。</p>
                </li>
            </ul>
            <ul>
                <span class="question_mem1">影城臨櫃售票開始與結束的時間?</span>
                <li class="question_msg">
                    <p>影城每日將於首場電影前30-60分鐘開放臨櫃售票；當日最末場電影開演10分鐘後，即停止臨櫃售票。</p>
                    <p>非影城臨櫃售票期間，亦可利用世界影城官網進行線上訂購。</p>
                </li>
            </ul>
            <ul>
                <span class="question_mem1">請問影城禁止攜入影廳食物規定為何?</span>
                <li class="question_msg">
                    <p>◎味道嗆辣濃郁食物：漢堡、披薩、滷味、油炸、燒烤食品、臭豆腐、烤玉米、章魚燒、榴槤...等味道嗆辣濃郁食物。</p>
                    <p>◎高溫熱燙食物：熱湯、熱麵、泡麵、關東煮、燒仙草、速食店蘋果派...等高溫熱燙食物。</p>
                    <p>◎食用時會發出聲響之食物：瓜子、花生、燒酒螺...等食物。</p>
                    <p>◎任何含酒精飲料。</p>
                    <p>◎若對以上禁止攜入影廳食物有爭議時，將由影城工作人員認定。</p>
                </li>
            </ul>
            <ul>
                <span class="question_mem1">請問威秀影城有為殘障朋友設置容易進出的設備嗎?</span>
                <li class="question_msg">
                    <p>全台世界影城都有為身心障礙朋友設置的電梯以及無障礙坡道，並提供了專區或專有座位方便身心障礙朋友觀賞電影。</p>
                </li>
            </ul>
        </div>

	</div>
</div>

<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    <script>
	    document.querySelectorAll('.question_mem1').forEach(item => {
	        item.addEventListener('click', event => {
	            const questionMsg = item.nextElementSibling;
	            if (questionMsg.style.display === 'block') {
	                questionMsg.style.display = 'none';
	            } else {
	                document.querySelectorAll('.question_msg').forEach(msg => msg.style.display = 'none');
	                questionMsg.style.display = 'block';
	            }
	        });
	    });
    </script>
</body>
</html>