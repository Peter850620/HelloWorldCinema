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
	href="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen4/screen4.css">
<style>
</style>
</head>


<jsp:include page="/back_end/orderTicket/index/indexHeader.jsp"
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



					<li class="seat"><input type="checkbox" id="A01"
						data-status="Y" /> <label for="A01">A01</label></li>
					<li class="seat"><input type="checkbox" id="A02"
						data-status="Y" /> <label for="A02">A02</label></li>
					<li class="seat"><input type="checkbox" id="A03"
						data-status="Y" /> <label for="A03">A03</label></li>

					<li class="seat"><input type="checkbox" id="A04"
						data-status="Y" /> <label for="A04">A04</label></li>

					<li class="seat"><input type="checkbox" id="A05"
						data-status="Y" /> <label for="A05">A05</label></li>
					<li class="seat"><input type="checkbox" id="A06"
						data-status="Y" /> <label for="A06">A06</label></li>

					<li class="seat"><input type="checkbox" id="A07"
						data-status="Y" /> <label for="A07">A07</label></li>
					<li class="seat"><input type="checkbox" id="A08"
						data-status="Y" /> <label for="A08">A08</label></li>
				</ol>
			</li>

			<li class="row row--2">
				<ol class="seats" type="B">
					<li class="seat"><input type="checkbox" id="B01"
						data-status="Y" /> <label for="B01">B01</label></li>
					<li class="seat"><input type="checkbox" id="B02"
						data-status="Y" /> <label for="B02">B02</label></li>
					<li class="seat"><input type="checkbox" id="B03"
						data-status="Y" /> <label for="B03">B03</label></li>
					<li class="seat"><input type="checkbox" id="B04"
						data-status="Y" /> <label for="B04">B04</label></li>
					<li class="seat"><input type="checkbox" id="B05"
						data-status="Y" /> <label for="B05">B05</label></li>
					<li class="seat"><input type="checkbox" id="B06"
						data-status="Y" /> <label for="B06">B06</label></li>

					<li class="seat"><input type="checkbox" id="B07"
						data-status="Y" /> <label for="B07">B07</label></li>
					<li class="seat"><input type="checkbox" id="B08"
						data-status="Y" /> <label for="B08">B08</label></li>
				</ol>
			</li>
			<li class="row row--3">
				<ol class="seats" type="C">
					<li class="seat"><input type="checkbox" id="C01"
						data-status="Y" /> <label for="C01">C01</label></li>
					<li class="seat"><input type="checkbox" id="C02"
						data-status="Y" /> <label for="C02">C02</label></li>
					<li class="seat"><input type="checkbox" id="C03"
						data-status="Y" /> <label for="C03">C03</label></li>
					<li class="seat"><input type="checkbox" id="C04"
						data-status="Y" /> <label for="C04">C04</label></li>
					<li class="seat"><input type="checkbox" id="C05"
						data-status="Y" /> <label for="C05">C05</label></li>
					<li class="seat"><input type="checkbox" id="C06"
						data-status="Y" /> <label for="C06">C06</label></li>

					<li class="seat"><input type="checkbox" id="C07"
						data-status="Y" /> <label for="C07">C07</label></li>
					<li class="seat"><input type="checkbox" id="C08"
						data-status="Y" /> <label for="C08">C08</label></li>
				</ol>
			</li>
			<li class="row row--4">
				<ol class="seats" type="D">
					<li class="seat"><input type="checkbox" id="D01"
						data-status="Y" /> <label for="D01">D01</label></li>
					<li class="seat"><input type="checkbox" id="D02"
						data-status="Y" /> <label for="D02">D02</label></li>
					<li class="seat"><input type="checkbox" id="D03"
						data-status="Y" /> <label for="D03">D03</label></li>
					<li class="seat"><input type="checkbox" id="D04"
						data-status="Y" /> <label for="D04">D04</label></li>
					<li class="seat"><input type="checkbox" id="D05"
						data-status="Y" /> <label for="D05">D05</label></li>
					<li class="seat"><input type="checkbox" id="D06"
						data-status="Y" /> <label for="D06">D06</label></li>

					<li class="seat"><input type="checkbox" id="D07"
						data-status="Y" /> <label for="D07">D07</label></li>
					<li class="seat"><input type="checkbox" id="D08"
						data-status="Y" /> <label for="D08">D08</label></li>
				</ol>
			</li>
			<li class="row row--5">
				<ol class="seats" type="E">
					<li class="seat"><input type="checkbox" id="E01"
						data-status="Y" /> <label for="E01">E01</label></li>
					<li class="seat"><input type="checkbox" id="E02"
						data-status="Y" /> <label for="E02">E02</label></li>
					<li class="seat"><input type="checkbox" id="E03"
						data-status="Y" /> <label for="E03">E03</label></li>
					<li class="seat"><input type="checkbox" id="E04"
						data-status="Y" /> <label for="E04">E04</label></li>
					<li class="seat"><input type="checkbox" id="E05"
						data-status="Y" /> <label for="E05">E05</label></li>
					<li class="seat"><input type="checkbox" id="E06"
						data-status="Y" /> <label for="E06">E06</label></li>

					<li class="seat"><input type="checkbox" id="E07"
						data-status="Y" /> <label for="E07">E07</label></li>
					<li class="seat"><input type="checkbox" id="E08"
						data-status="Y" /> <label for="E08">E08</label></li>
				</ol>
			</li>
			<li class="row row--6">
				<ol class="seats" type="F">
					<li class="seat"><input type="checkbox" id="F01"
						data-status="Y" /> <label for="F01">F01</label></li>
					<li class="seat"><input type="checkbox" id="F02"
						data-status="Y" /> <label for="F02">F02</label></li>
					<li class="seat"><input type="checkbox" id="F03"
						data-status="Y" /> <label for="F03">F03</label></li>
					<li class="seat"><input type="checkbox" id="F04"
						data-status="Y" /> <label for="F04">F04</label></li>
					<li class="seat"><input type="checkbox" id="F05"
						data-status="Y" /> <label for="F05">F05</label></li>
					<li class="seat"><input type="checkbox" id="F06"
						data-status="Y" /> <label for="F06">F06</label></li>

					<li class="seat"><input type="checkbox" id="F07"
						data-status="Y" /> <label for="F07">F07</label></li>
					<li class="seat"><input type="checkbox" id="F08"
						data-status="Y" /> <label for="F08">F08</label></li>
				</ol>
			</li>
			<li class="row row--7">
				<ol class="seats" type="G">
					<li class="seat"><input type="checkbox" id="G01"
						data-status="Y" /> <label for="G01">G01</label></li>
					<li class="seat"><input type="checkbox" id="G02"
						data-status="Y" /> <label for="G02">G02</label></li>
					<li class="seat"><input type="checkbox" id="G03"
						data-status="Y" /> <label for="G03">G03</label></li>
					<li class="seat"><input type="checkbox" id="G04"
						data-status="Y" /> <label for="G04">G04</label></li>
					<li class="seat"><input type="checkbox" id="G05"
						data-status="Y" /> <label for="G05">G05</label></li>
					<li class="seat"><input type="checkbox" id="G06"
						data-status="Y" /> <label for="G06">G06</label></li>

					<li class="seat"><input type="checkbox" id="G07"
						data-status="Y" /> <label for="G07">G07</label></li>
					<li class="seat"><input type="checkbox" id="G08"
						data-status="Y" /> <label for="G08">G08</label></li>
				</ol>
			</li>
			<li class="row row--8">
				<ol class="seats" type="H">
					<li class="seat"><input type="checkbox" id="H01"
						data-status="Y" /> <label for="H01">H01</label></li>
					<li class="seat"><input type="checkbox" id="H02"
						data-status="Y" /> <label for="H02">H02</label></li>
					<li class="seat"><input type="checkbox" id="H03"
						data-status="Y" /> <label for="H03">H03</label></li>
					<li class="seat"><input type="checkbox" id="H04"
						data-status="Y" /> <label for="H04">H04</label></li>
					<li class="seat"><input type="checkbox" id="H05"
						data-status="Y" /> <label for="H05">H05</label></li>
					<li class="seat"><input type="checkbox" id="H06"
						data-status="Y" /> <label for="H06">H06</label></li>

					<li class="seat"><input type="checkbox" id="H07"
						data-status="Y" /> <label for="H07">H07</label></li>
					<li class="seat"><input type="checkbox" id="H08"
						data-status="Y" /> <label for="H08">H08</label></li>
				</ol>
			</li>


			<li class="row aisle">
				<ol class="aisle" type="aisle">
					<pre class="aisleletter">                                                     </pre>
				</ol>
			<li class="row row--9">
				<ol class="seats" type="I">



					<li class="seat"><input type="checkbox" id="I01"
						data-status="Y" /> <label for="I01">I01</label></li>
					<li class="seat"><input type="checkbox" id="I02"
						data-status="Y" /> <label for="I02">I02</label></li>
					<li class="seat"><input type="checkbox" id="I03"
						data-status="Y" /> <label for="I03">I03</label></li>

					<li class="seat"><input type="checkbox" id="I04"
						data-status="Y" /> <label for="I04">I04</label></li>

					<li class="seat"><input type="checkbox" id="I05"
						data-status="Y" /> <label for="I05">I05</label></li>
					<li class="seat"><input type="checkbox" id="I06"
						data-status="Y" /> <label for="I06">I06</label></li>

					<li class="seat"><input type="checkbox" id="I07"
						data-status="Y" /> <label for="I07">I07</label></li>
					<li class="seat"><input type="checkbox" id="I08"
						data-status="Y" /> <label for="I08">I08</label></li>
				</ol>
			</li>
			<li class="row row--10">
				<ol class="seats" type="J">



					<li class="seat"><input type="checkbox" id="J01"
						data-status="Y" /> <label for="J01">J01</label></li>
					<li class="seat"><input type="checkbox" id="J02"
						data-status="Y" /> <label for="J02">J02</label></li>
					<li class="seat"><input type="checkbox" id="J03"
						data-status="Y" /> <label for="J03">J03</label></li>

					<li class="seat"><input type="checkbox" id="J04"
						data-status="Y" /> <label for="J04">J04</label></li>

					<li class="seat"><input type="checkbox" id="J05"
						data-status="Y" /> <label for="J05">J05</label></li>
					<li class="seat"><input type="checkbox" id="J06"
						data-status="Y" /> <label for="J06">J06</label></li>

					<li class="seat"><input type="checkbox" id="J07"
						data-status="Y" /> <label for="J07">J07</label></li>
					<li class="seat"><input type="checkbox" id="J08"
						data-status="Y" /> <label for="J08">J08</label></li>
				</ol>
			</li>
			<li class="row row--11">
				<ol class="seats" type="K">



					<li class="seat"><input type="checkbox" id="K01"
						data-status="Y" /> <label for="K01">K01</label></li>
					<li class="seat"><input type="checkbox" id="K02"
						data-status="Y" /> <label for="K02">K02</label></li>
					<li class="seat"><input type="checkbox" id="K03"
						data-status="Y" /> <label for="K03">K03</label></li>

					<li class="seat"><input type="checkbox" id="K04"
						data-status="Y" /> <label for="K04">K04</label></li>

					<li class="seat"><input type="checkbox" id="K05"
						data-status="Y" /> <label for="K05">K05</label></li>
					<li class="seat"><input type="checkbox" id="K06"
						data-status="Y" /> <label for="K06">K06</label></li>

					<li class="seat"><input type="checkbox" id="K07"
						data-status="Y" /> <label for="K07">K07</label></li>
					<li class="seat"><input type="checkbox" id="K08"
						data-status="Y" /> <label for="K08">K08</label></li>
				</ol>
			</li>
			<li class="row row--12">
				<ol class="seats" type="L">



					<li class="seat"><input type="checkbox" id="L01"
						data-status="Y" /> <label for="L01">L01</label></li>
					<li class="seat"><input type="checkbox" id="L02"
						data-status="Y" /> <label for="L02">L02</label></li>
					<li class="seat"><input type="checkbox" id="L03"
						data-status="Y" /> <label for="L03">L03</label></li>

					<li class="seat"><input type="checkbox" id="L04"
						data-status="Y" /> <label for="L04">L04</label></li>

					<li class="seat"><input type="checkbox" id="L05"
						data-status="Y" /> <label for="L05">L05</label></li>
					<li class="seat"><input type="checkbox" id="L06"
						data-status="Y" /> <label for="L06">L06</label></li>

					<li class="seat"><input type="checkbox" id="L07"
						data-status="Y" /> <label for="L07">L07</label></li>
					<li class="seat"><input type="checkbox" id="L08"
						data-status="Y" /> <label for="L08">L08</label></li>
				</ol>
			</li>
			<li class="row row--13">
				<ol class="seats" type="M">



					<li class="seat"><input type="checkbox" id="M01"
						data-status="Y" /> <label for="M01">M01</label></li>
					<li class="seat"><input type="checkbox" id="M02"
						data-status="Y" /> <label for="M02">M02</label></li>
					<li class="seat"><input type="checkbox" id="M03"
						data-status="Y" /> <label for="M03">M03</label></li>

					<li class="seat"><input type="checkbox" id="M04"
						data-status="Y" /> <label for="M04">M04</label></li>

					<li class="seat"><input type="checkbox" id="M05"
						data-status="Y" /> <label for="M05">M05</label></li>
					<li class="seat"><input type="checkbox" id="M06"
						data-status="Y" /> <label for="M06">M06</label></li>

					<li class="seat"><input type="checkbox" id="M07"
						data-status="Y" /> <label for="M07">M07</label></li>
					<li class="seat"><input type="checkbox" id="M08"
						data-status="Y" /> <label for="M08">M08</label></li>
				</ol>
			</li>
			<li class="row row--14">
				<ol class="seats" type="N">



					<li class="seat"><input type="checkbox" id="N01"
						data-status="Y" /> <label for="N01">N01</label></li>
					<li class="seat"><input type="checkbox" id="N02"
						data-status="Y" /> <label for="N02">N02</label></li>
					<li class="seat"><input type="checkbox" id="N03"
						data-status="Y" /> <label for="N03">N03</label></li>

					<li class="seat"><input type="checkbox" id="N04"
						data-status="Y" /> <label for="N04">N04</label></li>

					<li class="seat"><input type="checkbox" id="N05"
						data-status="Y" /> <label for="N05">N05</label></li>
					<li class="seat"><input type="checkbox" id="N06"
						data-status="Y" /> <label for="N06">N06</label></li>

					<li class="seat"><input type="checkbox" id="N07"
						data-status="Y" /> <label for="N07">N07</label></li>
					<li class="seat"><input type="checkbox" id="N08"
						data-status="Y" /> <label for="N08">N08</label></li>
				</ol>
			</li>
			<li class="row row--15">
				<ol class="seats" type="O">



					<li class="seat"><input type="checkbox" id="O01"
						data-status="Y" /> <label for="O01">O01</label></li>
					<li class="seat"><input type="checkbox" id="O02"
						data-status="Y" /> <label for="O02">O02</label></li>
					<li class="seat"><input type="checkbox" id="O03"
						data-status="Y" /> <label for="O03">O03</label></li>

					<li class="seat"><input type="checkbox" id="O04"
						data-status="Y" /> <label for="O04">O04</label></li>

					<li class="seat"><input type="checkbox" id="O05"
						data-status="Y" /> <label for="O05">O05</label></li>
					<li class="seat"><input type="checkbox" id="O06"
						data-status="Y" /> <label for="O06">O06</label></li>

					<li class="seat"><input type="checkbox" id="O07"
						data-status="Y" /> <label for="O07">O07</label></li>
					<li class="seat"><input type="checkbox" id="O08"
						data-status="Y" /> <label for="O08">O08</label></li>
				</ol>
			</li>
			<li class="row row--16">
				<ol class="seats" type="P">



					<li class="seat"><input type="checkbox" id="P01"
						data-status="Y" /> <label for="P01">P01</label></li>
					<li class="seat"><input type="checkbox" id="P02"
						data-status="Y" /> <label for="P02">P02</label></li>
					<li class="seat"><input type="checkbox" id="P03"
						data-status="Y" /> <label for="P03">P03</label></li>

					<li class="seat"><input type="checkbox" id="P04"
						data-status="Y" /> <label for="P04">P04</label></li>

					<li class="seat"><input type="checkbox" id="P05"
						data-status="Y" /> <label for="P05">P05</label></li>
					<li class="seat"><input type="checkbox" id="P06"
						data-status="Y" /> <label for="P06">P06</label></li>

					<li class="seat"><input type="checkbox" id="P07"
						data-status="Y" /> <label for="P07">P07</label></li>
					<li class="seat"><input type="checkbox" id="P08"
						data-status="Y" /> <label for="P08">P08</label></li>
				</ol>
			</li>


		</ol>

		</li>

		<div class="exit exit--back"></div>

		<div class="sub">

			<ul class="pay">

				<li class="total">已選取:
					<p id="selectedCount">0
					<p>張</p>
				</li>
				<li class="total">需選取:
					<p id="">0</p>
					<p>張</p>
				</li>

			</ul>
			<div style="text-align: center;">
				<button id="lastButton">上一步</button>
				<button id="nextButton">下一步</button>
			</div>

		</div>
	</div>




	<script
		src="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen.js">
		
	</script>

</body>
<jsp:include page="/back_end/orderTicket/index/indexFooter.jsp"
	flush="true" />
</html>