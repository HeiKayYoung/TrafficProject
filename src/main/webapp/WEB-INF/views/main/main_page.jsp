<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- 개별 화면 content 크기를 조절하는 방법 -->
	<style>
		#content{
			height: auto;
		}
		table {
			margin-top: 20px;
			margin-bottom: 20px;
			/* width: 80%; */
			width: 1200px;
			height: 200px;
			margin-left: auto;
			margin-right: auto;
		}
		td {
			border-right: 1px solid grey;
			width: 100px;
			height: 100px;
		}
		table td:last-child {
			border-right: 0;
		}
		.name{
			font-size: 30px;
			text-decoration: none;
		}
		#map {
			width:80%;
			height:600px; 
			margin-left: auto;
			margin-right: auto;
			border: 3px solid black;
			border-radius: 10px;
			z-index: 0;
		}
	</style>
	  
		<link rel="stylesheet" href="datepicker.css">
		<script src="${pageContext.request.contextPath}/resources/layout/main_js/search.js"></script>
		
		
	
	<style>
		
		@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		*{
			font-family: 'GmarketSansMedium';
		}
	</style>
	
	
</head>

<body >

<div id="map"></div>

	<!-- 카카오 지도 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9bdfa0d98e7c6b1949b387b6e48e0de3"></script>
	<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(37.5666612, 126.9783785), // 지도의 중심좌표
			        level: 2 // 지도의 확대 레벨
			    };
			
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(37.5668106, 126.9786417); 
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
			// marker.setMap(null);    
	</script>
	
	<table>
		<tr>
			<td><a class="name" href="user/caraccident_percnt"><img src="resources/img/caraccident.png" alt="#" width="225px" height="225px"><br />남기문</a></td>
			<td><a class="name" href="user/s_info_disability_fac"><img src="resources/img/subway_img/Subway_train.png" alt="#" width="225px" height="225px"><br />송경미</a></td>
			<td><a class="name" href="user/parking"><img src="resources/img/parking.png" alt="#" width="225px" height="225px"><br />신재환</a></td>
			<td><a class="name" href="user/new_mem23"><img src="resources/img/bicycle.jpg" alt="#" width="225px" height="220px"><br />임찬규</a></td>
		</tr>
	</table>
	
</body>
</html>