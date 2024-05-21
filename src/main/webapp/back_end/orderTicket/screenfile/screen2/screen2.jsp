
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
	href="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen2/screen2.css">
<style>
</style>
</head>




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
				</ol>
			</li>

		</ol>
		<div class="exit exit--back"></div>

		<div class="sub">

			<ul class="pay">

				<li class="total">選取:
					<p id="selectedCount">0</p>
				</li>
				<li class="price">總額:
					<p>0</p>
				</li>
				<button id="nextButton">下一步</button>
			</ul>
			<div class="arrow1">
				<a href="#"> <span class="left"></span>
				</a>
			</div>

			<div class="arrow2">
				<a href="#"> <span class="right"></span>
				</a>
			</div>

		</div>
	</div>

	<script
		src="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen.js">
		
	</script>
</body>

</html>