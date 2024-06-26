<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>世界影城 HelloWorld Cinema</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/orderTicket/screenfile/screen4/screen4.css">
<style>
</style>
</head>


<jsp:include page="/front_end/orderTicket/index/indexHeader.jsp"
	flush="true" />

<body>
	<title>seat booking</title>
	<div class="theatre">
		<div class="screen-side">
			<div class="screen">銀幕</div>
			<h3 class="select-text">請選擇座位</h3>
		</div>
		<div class="exit exit--front"></div>
		<ol class="cabin">
			<li class="row row--1">
				<ol class="seats" type="A">



					<li class="seat"><input type="checkbox" name="seatStatus" id="A01"
						data-status="Y" /> <label for="A01">A01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="A02"
						data-status="Y" /> <label for="A02">A02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="A03"
						data-status="Y" /> <label for="A03">A03</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="A04"
						data-status="Y" /> <label for="A04">A04</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="A05"
						data-status="Y" /> <label for="A05">A05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="A06"
						data-status="Y" /> <label for="A06">A06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="A07"
						data-status="Y" /> <label for="A07">A07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="A08"
						data-status="Y" /> <label for="A08">A08</label></li>
				</ol>
			</li>

			<li class="row row--2">
				<ol class="seats" type="B">
					<li class="seat"><input type="checkbox" name="seatStatus" id="B01"
						data-status="Y" /> <label for="B01">B01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="B02"
						data-status="Y" /> <label for="B02">B02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="B03"
						data-status="Y" /> <label for="B03">B03</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="B04"
						data-status="Y" /> <label for="B04">B04</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="B05"
						data-status="Y" /> <label for="B05">B05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="B06"
						data-status="Y" /> <label for="B06">B06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="B07"
						data-status="Y" /> <label for="B07">B07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="B08"
						data-status="Y" /> <label for="B08">B08</label></li>
				</ol>
			</li>
			<li class="row row--3">
				<ol class="seats" type="C">
					<li class="seat"><input type="checkbox" name="seatStatus" id="C01"
						data-status="Y" /> <label for="C01">C01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="C02"
						data-status="Y" /> <label for="C02">C02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="C03"
						data-status="Y" /> <label for="C03">C03</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="C04"
						data-status="Y" /> <label for="C04">C04</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="C05"
						data-status="Y" /> <label for="C05">C05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="C06"
						data-status="Y" /> <label for="C06">C06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="C07"
						data-status="Y" /> <label for="C07">C07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="C08"
						data-status="Y" /> <label for="C08">C08</label></li>
				</ol>
			</li>
			<li class="row row--4">
				<ol class="seats" type="D">
					<li class="seat"><input type="checkbox" name="seatStatus" id="D01"
						data-status="Y" /> <label for="D01">D01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="D02"
						data-status="Y" /> <label for="D02">D02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="D03"
						data-status="Y" /> <label for="D03">D03</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="D04"
						data-status="Y" /> <label for="D04">D04</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="D05"
						data-status="Y" /> <label for="D05">D05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="D06"
						data-status="Y" /> <label for="D06">D06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="D07"
						data-status="Y" /> <label for="D07">D07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="D08"
						data-status="Y" /> <label for="D08">D08</label></li>
				</ol>
			</li>
			<li class="row row--5">
				<ol class="seats" type="E">
					<li class="seat"><input type="checkbox" name="seatStatus" id="E01"
						data-status="Y" /> <label for="E01">E01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="E02"
						data-status="Y" /> <label for="E02">E02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="E03"
						data-status="Y" /> <label for="E03">E03</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="E04"
						data-status="Y" /> <label for="E04">E04</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="E05"
						data-status="Y" /> <label for="E05">E05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="E06"
						data-status="Y" /> <label for="E06">E06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="E07"
						data-status="Y" /> <label for="E07">E07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="E08"
						data-status="Y" /> <label for="E08">E08</label></li>
				</ol>
			</li>
			<li class="row row--6">
				<ol class="seats" type="F">
					<li class="seat"><input type="checkbox" name="seatStatus" id="F01"
						data-status="Y" /> <label for="F01">F01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="F02"
						data-status="Y" /> <label for="F02">F02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="F03"
						data-status="Y" /> <label for="F03">F03</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="F04"
						data-status="Y" /> <label for="F04">F04</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="F05"
						data-status="Y" /> <label for="F05">F05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="F06"
						data-status="Y" /> <label for="F06">F06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="F07"
						data-status="Y" /> <label for="F07">F07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="F08"
						data-status="Y" /> <label for="F08">F08</label></li>
				</ol>
			</li>
			<li class="row row--7">
				<ol class="seats" type="G">
					<li class="seat"><input type="checkbox" name="seatStatus" id="G01"
						data-status="Y" /> <label for="G01">G01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="G02"
						data-status="Y" /> <label for="G02">G02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="G03"
						data-status="Y" /> <label for="G03">G03</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="G04"
						data-status="Y" /> <label for="G04">G04</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="G05"
						data-status="Y" /> <label for="G05">G05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="G06"
						data-status="Y" /> <label for="G06">G06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="G07"
						data-status="Y" /> <label for="G07">G07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="G08"
						data-status="Y" /> <label for="G08">G08</label></li>
				</ol>
			</li>
			<li class="row row--8">
				<ol class="seats" type="H">
					<li class="seat"><input type="checkbox" name="seatStatus" id="H01"
						data-status="Y" /> <label for="H01">H01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="H02"
						data-status="Y" /> <label for="H02">H02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="H03"
						data-status="Y" /> <label for="H03">H03</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="H04"
						data-status="Y" /> <label for="H04">H04</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="H05"
						data-status="Y" /> <label for="H05">H05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="H06"
						data-status="Y" /> <label for="H06">H06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="H07"
						data-status="Y" /> <label for="H07">H07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="H08"
						data-status="Y" /> <label for="H08">H08</label></li>
				</ol>
			</li>


			<li class="row aisle">
				<ol class="aisle" type="aisle">
					<pre class="aisleletter">                                                     </pre>
				</ol>
			<li class="row row--9">
				<ol class="seats" type="I">



					<li class="seat"><input type="checkbox" name="seatStatus" id="I01"
						data-status="Y" /> <label for="I01">I01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="I02"
						data-status="Y" /> <label for="I02">I02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="I03"
						data-status="Y" /> <label for="I03">I03</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="I04"
						data-status="Y" /> <label for="I04">I04</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="I05"
						data-status="Y" /> <label for="I05">I05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="I06"
						data-status="Y" /> <label for="I06">I06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="I07"
						data-status="Y" /> <label for="I07">I07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="I08"
						data-status="Y" /> <label for="I08">I08</label></li>
				</ol>
			</li>
			<li class="row row--10">
				<ol class="seats" type="J">



					<li class="seat"><input type="checkbox" name="seatStatus" id="J01"
						data-status="Y" /> <label for="J01">J01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="J02"
						data-status="Y" /> <label for="J02">J02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="J03"
						data-status="Y" /> <label for="J03">J03</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="J04"
						data-status="Y" /> <label for="J04">J04</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="J05"
						data-status="Y" /> <label for="J05">J05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="J06"
						data-status="Y" /> <label for="J06">J06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="J07"
						data-status="Y" /> <label for="J07">J07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="J08"
						data-status="Y" /> <label for="J08">J08</label></li>
				</ol>
			</li>
			<li class="row row--11">
				<ol class="seats" type="K">



					<li class="seat"><input type="checkbox" name="seatStatus" id="K01"
						data-status="Y" /> <label for="K01">K01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="K02"
						data-status="Y" /> <label for="K02">K02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="K03"
						data-status="Y" /> <label for="K03">K03</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="K04"
						data-status="Y" /> <label for="K04">K04</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="K05"
						data-status="Y" /> <label for="K05">K05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="K06"
						data-status="Y" /> <label for="K06">K06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="K07"
						data-status="Y" /> <label for="K07">K07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="K08"
						data-status="Y" /> <label for="K08">K08</label></li>
				</ol>
			</li>
			<li class="row row--12">
				<ol class="seats" type="L">



					<li class="seat"><input type="checkbox" name="seatStatus" id="L01"
						data-status="Y" /> <label for="L01">L01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="L02"
						data-status="Y" /> <label for="L02">L02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="L03"
						data-status="Y" /> <label for="L03">L03</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="L04"
						data-status="Y" /> <label for="L04">L04</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="L05"
						data-status="Y" /> <label for="L05">L05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="L06"
						data-status="Y" /> <label for="L06">L06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="L07"
						data-status="Y" /> <label for="L07">L07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="L08"
						data-status="Y" /> <label for="L08">L08</label></li>
				</ol>
			</li>
			<li class="row row--13">
				<ol class="seats" type="M">



					<li class="seat"><input type="checkbox" name="seatStatus" id="M01"
						data-status="Y" /> <label for="M01">M01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="M02"
						data-status="Y" /> <label for="M02">M02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="M03"
						data-status="Y" /> <label for="M03">M03</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="M04"
						data-status="Y" /> <label for="M04">M04</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="M05"
						data-status="Y" /> <label for="M05">M05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="M06"
						data-status="Y" /> <label for="M06">M06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="M07"
						data-status="Y" /> <label for="M07">M07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="M08"
						data-status="Y" /> <label for="M08">M08</label></li>
				</ol>
			</li>
			<li class="row row--14">
				<ol class="seats" type="N">



					<li class="seat"><input type="checkbox" name="seatStatus" id="N01"
						data-status="Y" /> <label for="N01">N01</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="N02"
						data-status="Y" /> <label for="N02">N02</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="N03"
						data-status="Y" /> <label for="N03">N03</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="N04"
						data-status="Y" /> <label for="N04">N04</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="N05"
						data-status="Y" /> <label for="N05">N05</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="N06"
						data-status="Y" /> <label for="N06">N06</label></li>

					<li class="seat"><input type="checkbox" name="seatStatus" id="N07"
						data-status="Y" /> <label for="N07">N07</label></li>
					<li class="seat"><input type="checkbox" name="seatStatus" id="N08"
						data-status="Y" /> <label for="N08">N08</label></li>
				</ol>
			</li>
		</ol>

		<div class="exit exit--back"></div>

		<div class="sub">
			<ul class="pay">
				<li class="needpick">已選取:<p id="selectedCount">&#20;0&#20;</p><p>張</p>
				</li>
				<li class="total">需選取:<p id="totalCount"></p><p>張</p>
				</li>
			</ul>
			<div style="text-align: center;">
				<button id="lastButton">上一步</button>
				<button id="nextButton">下一步</button>
			</div>
		</div>

		
	</div>




	<script
		src="<%=request.getContextPath()%>/front_end/orderTicket/screenfile/screen.js">
		
	</script>

</body>
<jsp:include page="/front_end/orderTicket/index/indexFooter.jsp"
	flush="true" />
</html>