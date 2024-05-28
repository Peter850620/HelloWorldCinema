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
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            text-align: center;
        }

        .aboutus_main {
            padding: 20px;
            line-height: 1.8;
        }

        .aboutus_main p {
            color: #555;
            margin: 10px 0;
            text-align: justify;
        }

        .aboutus_main p:first-child {
            margin-top: 0;
        }

        hr {
            border: 0;
            height: 1px;
            background: #ddd;
            margin: 20px 0;
        }
    </style>
</head>
<body>
<%@ include file="../index/indexHeader.jsp" %>
<!-- ========================以下區域可放置其他內容======================== -->
<div id="xxx">
    <div class="main" id="main">
    	<h1>影城簡介</h1>
        <hr>
		<div class="aboutus_main">
            <p>世界影城（WORLD CINEMA）自2024年營業至今，為tibame最大的影城，全台共計1座據點，桃園1座影城。</p>
            <br>
            <p>世界影城致力於提供消費者完善的服務，包括便捷的電影評論資訊在購前,能先瀏覽影評並立即下訂,無需轉換平台。</p>
            <p>線上購票者也能立即取得電子票卷,再也不用提前至現場排隊換實體票卷。除了電影購票加購食物外,若有喜歡的限量</p>
            <p>周邊也能線上購買,並且宅配到家。如有使用大型場地的需求，世界影城也有提供影廳租借的服務，無論是慶生聚會</p>
            <p>或是演講活動，世界影城將會是您最好的選擇。</p>
            <br>
            <p>世界影城擁有最出色的播映設備，也因影城多角化經營而讓世界影城成為tibame影城界的領導品牌，2024年起深耕</p>
            <p>海外直播演唱會及舞台劇，我們不僅提供一流的放映設備，還定期組織各種電影活動，讓您盡情享受電影之樂。</p>       
            <br>
            <p>世界影城擁有一支專業的團隊，包括技術人員、服務人員以及管理人員。我們的團隊致力於為您提供周到的服務，</p>
            <p>讓您感受到家的溫暖。</p>
            <br>
            <p>世界影城的願景是成為全球領先的電影院品牌，為觀眾帶來無與倫比的電影體驗，我們預計將繼續增開新點，希望能</p>
            <p>將影像事業推展為文化產業，並未電影產業做出貢獻。</p>
        </div>

	</div>
</div>

<!-- ========================以上區域可放置其他內容======================== -->
<%@ include file="../index/indexFooter.jsp" %>
    
    <!-- 主要js -->
    <script src="<%= request.getContextPath() %>/js/index.js"></script>
    <script>
	
    </script>
</body>
</html>