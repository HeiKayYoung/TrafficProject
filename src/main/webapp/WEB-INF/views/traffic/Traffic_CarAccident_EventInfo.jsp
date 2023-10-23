<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>

	<style>
	
		#form{
			width: 1100px;
		}
		
		table {
		  border-collapse: separate;
		  border-spacing: 0;
		  width: 1100px;
		}
		th, td {
		  padding: 6px 15px;
		}
		th {
		  background: #42444e;
		  color: #fff;
		  font-size: 18px;
		  text-align: center;
		}
		tr:first-child th:first-child {
		  border-top-left-radius: 6px;
		}
		tr:first-child th:last-child {
		  border-top-right-radius: 6px;
		}
		td {
		  border-right: 1px solid #c6c9cc;
		  border-bottom: 1px solid #c6c9cc;
		}
		td:first-child {
		  border-left: 1px solid #c6c9cc;
		}
		tr:nth-child(even) td {
		  background: #eaeaed;
		}
		tr:last-child td:first-child {
		  border-bottom-left-radius: 6px;
		}
		tr:last-child td:last-child {
		  border-bottom-right-radius: 6px;
		}
		
		@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}

		#type, #eventType, .button{
		  /* 생략 */
		  font-family: 'GmarketSansMedium', sans-serif; 
		  font-size: 1rem;
		  font-weight: 400;
		  line-height: 1.5;
		
		  color: #444;
		  background-color: #fff;
		
		  padding: 0.6em 1.4em 0.5em 0.8em;
		  margin: 0;
		
		  border: 1px solid #aaa;
		  border-radius: 0.5em;
		  box-shadow: 0 1px 0 1px rgba(0, 0, 0, 0.04);
		}
		
		#map{
			display: none;
		}
		.button{
			color: black;
            background-color: lightblue;
            cursor: pointer;
		}
		
		#loading_form{
			display: none;
			text-align: center;
			margin: 0 auto;
		}
		.loading {
			width: 150px;
			height: 150px;
			position: relative;
			margin: 0 auto;
		}
		.loading span {
			position: absolute;
			width: 60px;
			height: 60px;
			background-color: grey;
			top: 0;
			left: 0;
			animation: loading 1.5s infinite;
		}
		
		@keyframes loading {
		  0%,
		  100% {
			top: 0;
			left: 0;
			background-color: red;
		  }
		  25% {
			top: 0;
			left: calc(100% - 10px);
			background-color: dodgerblue;
		  }
		  50% {
			top: calc(100% - 10px);
			left: calc(100% - 10px);
			background-color: orange;
		  }
		  75% {
			top: calc(100% - 10px);
			left: 0;
			background-color: yellowgreen;
		  }
		}
		
		.loading span:nth-child(2) {
		  animation-delay: .75s;
		}
		
	</style>

	<h1>실시간 교통사고 / 재난 정보</h1>
	<br />
	
    <div id="map" style="width:1100px; height:550px;"></div>
    
   	<div id="loading_form">
		<div class="loading">
		   <span></span>
		   <span></span>
		</div>
		<br /><br /><br />
		<div>
			<span style="font-size: 20px;">CCTV 영상을 로딩중입니다....</span>
		</div>
 	</div>
      
    
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=76c95b8154684160a740218f83546db0"></script>
    <script>
    	
    	// 카카오맵
    	
    	var cctv_url = "";
    	
    	function clickData(title, lo_crd, la_crd){
        	
    		var cctv_url = ""; // CCTV URL 초기화
    		
    		$("#map").css("display", "block");
    		
    	    var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    		    mapOption = { 
    		        center: new kakao.maps.LatLng(la_crd, lo_crd), // 지도의 중심좌표
    		        level: 7 // 지도의 확대 레벨
    		    };
    		
    		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    		
    		// 원 표시
    		var circle = new kakao.maps.Circle({
    		    center : new kakao.maps.LatLng(la_crd, lo_crd),  // 원의 중심좌표 입니다 
    		    radius: 600, // 미터 단위의 원의 반지름입니다 
    		    strokeWeight: 5, // 선의 두께입니다 
    		    strokeColor: '#75B8FA', // 선의 색깔입니다
    		    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
    		    strokeStyle: 'dashed', // 선의 스타일 입니다
    		    fillColor: '#CFE7FF', // 채우기 색깔입니다
    		    fillOpacity: 0.7  // 채우기 불투명도 입니다   
    		}); 
    		
    		circle.setMap(map); 
    		//////
    		
    		// 교통량 표시
    		map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
    		//////
    		
    		// 마커 이미지의 이미지 주소입니다
    		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png"; 
    		    
    		// 마커 이미지의 이미지 크기 입니다
    		var imageSize = new kakao.maps.Size(24, 35); 
    		    
    		// 마커 이미지를 생성합니다    
    		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    		    
    		// 마커를 생성합니다
    		var marker = new kakao.maps.Marker({
    		    map: map, // 마커를 표시할 지도
    		    position: new kakao.maps.LatLng(la_crd, lo_crd), // 마커를 표시할 위치
    		    title : title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
    		    image : markerImage, // 마커 이미지 
    		    clickable: true
    		});
    		
    		var iwContent = '<div style="width: 300px; height: 300px;"></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
	
	    	// 인포윈도우를 생성합니다
	    	var infowindow = new kakao.maps.InfoWindow({
	    	    content : iwContent,
	    	    removable : iwRemoveable
	    	});
	
	    	// 마커에 클릭이벤트를 등록합니다
	    	kakao.maps.event.addListener(marker, 'click', function() {
	    		
	    		if(cctv_url == ""){
	    			
	    			// 로딩중 표시
	    			$("#map").css("display", "none");
	    			$("#loading_form").css("display", "block");
	    			
		    		$.ajax({
		                type : "GET",
		                url : "caraccident_cctv?coordx=" + lo_crd + "&coordy=" + la_crd,
		                success : function(result){
		                	
		                	if(result == "ERROR_NO_CCTVINFO"){
		                		
		                		// 로딩중 제거
			                	$("#map").css("display", "block");
			                	$("#loading_form").css("display", "none");
		                		
		                		alert("해당 위치 근처의 CCTV정보가 없습니다.")
		                		
		                		return;
		                	}
		                	
		                	// 로딩중 제거
		                	$("#map").css("display", "block");
		                	$("#loading_form").css("display", "none");
		                	
		                	cctv_url = result;
		            		window.open(cctv_url, "근처 CCTV 영상", "width=700, height=600, top=10, left=10");
		                }
		            });
	    		}
	    		else{
	    			window.open(cctv_url, "근처 CCTV 영상", "width=700, height=600, top=10, left=10");
	    		}
	    		
	    	});
    	}
    </script>
    
    
    <div id="form">
    	
    
    	<div>
    		<br />
    		<form action="caraccident_eventinfo">
	            <div>
	                <span>
	                    <select name="type" id="type">
	                        <option value="all" ${param.type == 'all' ? "selected" : "" }>전체</option>
	                        <option value="ex" ${param.type == 'ex' ? "selected" : "" }>고속도로</option>
	                        <option value="its" ${param.type == 'its' ? "selected" : "" }>국도</option>
	                        <option value="loc" ${param.type == 'loc' ? "selected" : "" }>지방도</option>
	                        <option value="sgg" ${param.type == 'sgg' ? "selected" : "" }>시군도</option>
	                        <option value="etc" ${param.type == 'etc' ? "selected" : "" }>기타</option>
	                    </select>
	                </span>
	                <span>
	                    <select name="eventType" id="eventType">
	                        <%-- <option value="all" ${param.eventType == 'all' ? "selected" : "" }>전체</option> --%>
	                        <%-- <option value="cor" ${param.eventType == 'cor' ? "selected" : "" }>공사</option> --%>
	                        <option value="acc" ${param.eventType == 'acc' ? "selected" : "" }>교통사고</option>
	                        <%-- <option value="wea" ${param.eventType == 'wea' ? "selected" : "" }>기상</option> --%>
	                        <option value="etce" ${param.eventType == 'etce' ? "selected" : "" }>기타돌발</option>
	                        <option value="dis" ${param.eventType == 'dis' ? "selected" : "" }>재난</option>
	                        <%-- <option value="etc" ${param.eventType == 'etc' ? "selected" : "" }>기타</option> --%>
	                    </select>
	                </span>
	                <span>
	                    <input type="submit" class="button" value="검색">
	                </span>
	                <span style="color: red; font-weight: bold;">
	                	&nbsp;&nbsp; * 지도의 마커를 클릭하면 근처의 CCTV 영상을 확인하실 수 있습니다.
	                </span>
	            </div>
	        </form>
    	</div>
        <div>
        	<br />
        	<table id="event_info">
        		<tr style="background-color: lightblue">
        			<th width="10%">도로 유형</th>
        			<th width="20%">이벤트 유형</th>
        			<th width="20%">도로명 / 도로번호</th>
        			<th width="10%">도로 방향</th>
        			<th width="10%">차로</th>
        			<th width="40%">내용</th>
        		</tr>
        		<c:forEach items="${list}" var="li">
        			<tr>
        				<td>${li.type != 'null' ? li.type : "-"}</td>
	        			<td>${li.eventType != 'null' ? li.eventType : "-"} / ${li.eventDetailType != 'null' ? li.eventDetailType : "-"}</td>
	        			<!-- 링크 클릭시 지도정보 가져오고, 맨 위로 이동함 -->
	        			<td><a href="javascript:clickData('','${li.coordX}','${li.coordY}'); $('#loading_form').css('display', 'none'); location.replace('#');">${li.roadName != 'null' ? li.roadName : "-"} / ${li.roadNo != 'null' ? li.roadNo : "-"}</a></td>
	        			<td>${li.roadDrcType != 'null' ? li.roadDrcType : "-"}</td>
	        			<td>${li.lanesBlocked != 'null' ? li.lanesBlocked : "-"}</td>
	        			<td>${li.message != 'null' ? li.message : "-"}</td>
        			</tr>
        		</c:forEach>
        	</table>
        	<br />
        </div>
    </div>
	
</body>
</html>