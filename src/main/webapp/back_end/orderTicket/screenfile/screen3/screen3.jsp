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
	href="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen3/screen3.css">
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



					<li class="seat"><input type="checkbox" id="A01" /> <label
						for="A01">A01</label></li>
					<li class="seat"><input type="checkbox" id="A02" /> <label
						for="A02">A02</label></li>
					<li class="seat"><input type="checkbox" id="A03" /> <label
						for="A03">A03</label></li>

					<li class="seat"><input type="checkbox" id="A04" /> <label
						for="A04">A04</label></li>

					<li class="seat"><input type="checkbox" id="A05" /> <label
						for="A05">A05</label></li>
					<li class="seat"><input type="checkbox" id="A06" /> <label
						for="A06">A06</label></li>

					<li class="seat"><input type="checkbox" id="A07" /> <label
						for="A07">A07</label></li>
					<li class="seat"><input type="checkbox" id="A08" /> <label
						for="A08">A08</label></li>
				</ol>
			</li>

			<li class="row row--2">
				<ol class="seats" type="B">
					<li class="seat"><input type="checkbox" id="B01" /> <label
						for="B01">B01</label></li>
					<li class="seat"><input type="checkbox" id="B02" /> <label
						for="B02">B02</label></li>
					<li class="seat"><input type="checkbox" id="B03" /> <label
						for="B03">B03</label></li>
					<li class="seat"><input type="checkbox" id="B04" /> <label
						for="B04">B04</label></li>
					<li class="seat"><input type="checkbox" id="B05" /> <label
						for="B05">B05</label></li>
					<li class="seat"><input type="checkbox" id="B06" /> <label
						for="B06">B06</label></li>

					<li class="seat"><input type="checkbox" id="B07" /> <label
						for="B07">B07</label></li>
					<li class="seat"><input type="checkbox" id="B08" /> <label
						for="B08">B08</label></li>
				</ol>
			</li>
			<li class="row row--3">
				<ol class="seats" type="C">
					<li class="seat"><input type="checkbox" id="C01" /> <label
						for="C01">C01</label></li>
					<li class="seat"><input type="checkbox" id="C02" /> <label
						for="C02">C02</label></li>
					<li class="seat"><input type="checkbox" id="C03" /> <label
						for="C03">C03</label></li>
					<li class="seat"><input type="checkbox" id="C04" /> <label
						for="C04">C04</label></li>
					<li class="seat"><input type="checkbox" id="C05" /> <label
						for="C05">C05</label></li>
					<li class="seat"><input type="checkbox" id="C06" /> <label
						for="C06">C06</label></li>

					<li class="seat"><input type="checkbox" id="C07" /> <label
						for="C07">C07</label></li>
					<li class="seat"><input type="checkbox" id="C08" /> <label
						for="C08">C08</label></li>
				</ol>
			</li>
			<li class="row row--4">
				<ol class="seats" type="D">
					<li class="seat"><input type="checkbox" id="D01" /> <label
						for="D01">D01</label></li>
					<li class="seat"><input type="checkbox" id="D02" /> <label
						for="D02">D02</label></li>
					<li class="seat"><input type="checkbox" id="D03" /> <label
						for="D03">D03</label></li>
					<li class="seat"><input type="checkbox" id="D04" /> <label
						for="D04">D04</label></li>
					<li class="seat"><input type="checkbox" id="D05" /> <label
						for="D05">D05</label></li>
					<li class="seat"><input type="checkbox" id="D06" /> <label
						for="D06">D06</label></li>

					<li class="seat"><input type="checkbox" id="D07" /> <label
						for="D07">D07</label></li>
					<li class="seat"><input type="checkbox" id="D08" /> <label
						for="D08">D08</label></li>
				</ol>
			</li>
			<li class="row row--5">
				<ol class="seats" type="E">
					<li class="seat"><input type="checkbox" id="E01" /> <label
						for="E01">E01</label></li>
					<li class="seat"><input type="checkbox" id="E02" /> <label
						for="E02">E02</label></li>
					<li class="seat"><input type="checkbox" id="E03" /> <label
						for="E03">E03</label></li>
					<li class="seat"><input type="checkbox" id="E04" /> <label
						for="E04">E04</label></li>
					<li class="seat"><input type="checkbox" id="E05" /> <label
						for="E05">E05</label></li>
					<li class="seat"><input type="checkbox" id="E06" /> <label
						for="E06">E06</label></li>

					<li class="seat"><input type="checkbox" id="E07" /> <label
						for="E07">E07</label></li>
					<li class="seat"><input type="checkbox" id="E08" /> <label
						for="E08">E08</label></li>
				</ol>
			</li>
			<li class="row row--6">
				<ol class="seats" type="F">
					<li class="seat"><input type="checkbox" id="F01" /> <label
						for="F01">F01</label></li>
					<li class="seat"><input type="checkbox" id="F02" /> <label
						for="F02">F02</label></li>
					<li class="seat"><input type="checkbox" id="F03" /> <label
						for="F03">F03</label></li>
					<li class="seat"><input type="checkbox" id="F04" /> <label
						for="F04">F04</label></li>
					<li class="seat"><input type="checkbox" id="F05" /> <label
						for="F05">F05</label></li>
					<li class="seat"><input type="checkbox" id="F06" /> <label
						for="F06">F06</label></li>

					<li class="seat"><input type="checkbox" id="F07" /> <label
						for="F07">F07</label></li>
					<li class="seat"><input type="checkbox" id="F08" /> <label
						for="F08">F08</label></li>
				</ol>
			</li>
			<li class="row row--7">
				<ol class="seats" type="G">
					<li class="seat"><input type="checkbox" id="G01" /> <label
						for="G01">G01</label></li>
					<li class="seat"><input type="checkbox" id="G02" /> <label
						for="G02">G02</label></li>
					<li class="seat"><input type="checkbox" id="G03" /> <label
						for="G03">G03</label></li>
					<li class="seat"><input type="checkbox" id="G04" /> <label
						for="G04">G04</label></li>
					<li class="seat"><input type="checkbox" id="G05" /> <label
						for="G05">G05</label></li>
					<li class="seat"><input type="checkbox" id="G06" /> <label
						for="G06">G06</label></li>

					<li class="seat"><input type="checkbox" id="G07" /> <label
						for="G07">G07</label></li>
					<li class="seat"><input type="checkbox" id="G08" /> <label
						for="G08">G08</label></li>
				</ol>
			</li>
			<li class="row row--8">
				<ol class="seats" type="H">
					<li class="seat"><input type="checkbox" id="H01" /> <label
						for="H01">H01</label></li>
					<li class="seat"><input type="checkbox" id="H02" /> <label
						for="H02">H02</label></li>
					<li class="seat"><input type="checkbox" id="H03" /> <label
						for="H03">H03</label></li>
					<li class="seat"><input type="checkbox" id="H04" /> <label
						for="H04">H04</label></li>
					<li class="seat"><input type="checkbox" id="H05" /> <label
						for="H05">H05</label></li>
					<li class="seat"><input type="checkbox" id="H06" /> <label
						for="H06">H06</label></li>

					<li class="seat"><input type="checkbox" id="H07" /> <label
						for="H07">H07</label></li>
					<li class="seat"><input type="checkbox" id="H08" /> <label
						for="H08">H08</label></li>
				</ol>
			</li>

		</ol>
		<div class="exit exit--back"></div>

		<div class="sub">

			<ul class="pay">

				<li class="total">選取:
					<p id="selectedCount"></p>
				</li>
				<li class="price">總額:
					<p></p>
				</li>
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
		src="<%=request.getContextPath()%>/back_end/orderTicket/screenfile/screen3/screen3.js">
		
	</script>

</body>

</html>