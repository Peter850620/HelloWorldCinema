<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.dao.*"%>
<%@page import="com.entity.*"%>
<%@page import="com.service.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>世界影城 HelloWorld Cinema</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/orderTicket/screenfile/screen1/screen1.css">
<style>
</style>
</head>

<jsp:include page="/front_end/orderTicket/index/indexHeader.jsp"
	flush="true" />


<body>
	<input type="hidden" id="showId" name="showId" value="">
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
				<button type="button" id="nextButton">下一步</button>
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