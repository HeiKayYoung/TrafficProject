<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/user/s_info_disability_fac.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<h3>지하철 편의시설</h3>
<hr />
<p style="color:gray;">아이콘을 클릭하시면 지도에서 위치 확인 가능합니다.</p> 


  
<div id="mapwrap"> 
    <!-- 지도가 표시될 div -->
    <div id="map" style="width:100%;height:450px;"></div>
    <!-- 지도 위에 표시될 마커 카테고리 -->
    <div class="category">
        <ul>
            <li id="statn_evMenu" onclick="changeMarker('statn_ev')">
                <span class="ico_comm ico_statn_ev"></span>
                엘리베이터
            </li>
            <li id="statn_wlMenu" onclick="changeMarker('statn_wl')">
                <span class="ico_comm ico_statn_wl"></span>
                휠체어리프트
            </li>
            <li id="statn_bfMenu" onclick="changeMarker('statn_bf')">
                <span class="ico_comm ico_statn_bf"></span>
                유아수유방
            </li>
            <li id="statn_emMenu" onclick="changeMarker('statn_em')">
                <span class="ico_comm ico_statn_em"></span>
                환전키오스크
            </li>
        </ul>
    </div>
</div>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=d948241e2d589435279f349c165e5c95"></script>
<script>
var evArr = new Array();
evArr = JSON.parse('${evArr }');
var wlArr = new Array();
wlArr = JSON.parse('${wlArr }');
var bfArr = new Array();
bfArr = JSON.parse('${bfArr }');
var emArr = new Array();
emArr = JSON.parse('${emArr }');



var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(37.498004414546934, 127.02770621963765), // 지도의 중심좌표 
        level: 6 // 지도의 확대 레벨 
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


//엘리베이터 마커가 표시될 좌표 배열입니다
var statn_evPositions = [];
for (var i = 0; i < evArr.length; i++) {  
    
	  var latLng = new kakao.maps.LatLng(parseFloat(evArr[i].evMapX), parseFloat(evArr[i].evMapY));
	    statn_evPositions.push(latLng);
}     


// 휠체어 마커가 표시될 좌표 배열입니다
var statn_wlPositions = [];
for (var i = 0; i < wlArr.length; i++) {  
    
	  var latLng = new kakao.maps.LatLng(parseFloat(wlArr[i].MapX), parseFloat(wlArr[i].MapY));
	    statn_wlPositions.push(latLng);
}     

// 유아수유방 마커가 표시될 좌표 배열입니다
var statn_bfPositions = [];  
for (var i = 0; i < bfArr.length; i++) {  
    
	  var latLng = new kakao.maps.LatLng(parseFloat(bfArr[i].MapX), parseFloat(bfArr[i].MapY));
	  statn_bfPositions.push(latLng);
}    

// 환전키오스크 마커가 표시될 좌표 배열입니다
var statn_emPositions = [];  
for (var i = 0; i < emArr.length; i++) {  
    
	  var latLng = new kakao.maps.LatLng(parseFloat(emArr[i].MapX), parseFloat(emArr[i].MapY));
	  statn_emPositions.push(latLng);
}    

var markerImageSrc = '${pageContext.request.contextPath }/resources/img/subway_img/kakaoMapTestImg.png';  // 마커이미지의 주소입니다. 스프라이트 이미지 입니다
    statn_evMarkers = [], // 엘리베이터 마커 객체를 가지고 있을 배열입니다
    statn_wlMarkers = [], // 휠체어 마커 객체를 가지고 있을 배열입니다
    statn_bfMarkers = []; // 유아수유방 마커 객체를 가지고 있을 배열입니다
    statn_emMarkers = []; // 환전키오스크 마커 객체를 가지고 있을 배열입니다

    
createStatn_evMarkers(); // 엘리베이터 마커를 생성하고 엘리베이터 마커 배열에 추가합니다
createStatn_wlMarkers(); // 휠체어 마커를 생성하고 휠체어 마커 배열에 추가합니다
createStatn_bfMarkers(); // 유아수유방 마커를 생성하고 유아수유방 마커 배열에 추가합니다
createStatn_emMarkers(); // 환전키오스크 마커를 생성하고 환전키오스크 마커 배열에 추가합니다

changeMarker('statn_ev'); // 지도에 엘리베이터 마커가 보이도록 설정합니다    


// 마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수입니다
function createMarkerImage(src, size, options) {
    var markerImage = new kakao.maps.MarkerImage(src, size, options);
    return markerImage;            
}

// 좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수입니다
function createMarker(position, image) {
    var marker = new kakao.maps.Marker({
        position: position,
        image: image
    });
    
    return marker;  
}   
   
// 엘리베이터 마커를 생성하고 커피숍 마커 배열에 추가하는 함수입니다
function createStatn_evMarkers() {
    
    for (var i = 0; i < statn_evPositions.length; i++) {  
        
        var imageSize = new kakao.maps.Size(25, 26),
            imageOptions = {  
                spriteOrigin: new kakao.maps.Point(8, 0),    
                spriteSize: new kakao.maps.Size(36, 144)  
            };     
        
        // 마커이미지와 마커를 생성합니다
        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
            marker = createMarker(statn_evPositions[i], markerImage);  
        
        // 생성된 마커를 엘리베이터 마커 배열에 추가합니다
        statn_evMarkers.push(marker);
    }     
}

// 엘리베이터 마커들의 지도 표시 여부를 설정하는 함수입니다
function setStatn_evMarkers(map) {        
    for (var i = 0; i < statn_evMarkers.length; i++) {  
       statn_evMarkers[i].setMap(map);
    }        
}

// 휠체어 마커를 생성하고 편의점 마커 배열에 추가하는 함수입니다
function createStatn_wlMarkers() {
    for (var i = 0; i < statn_wlPositions.length; i++) {
        
        var imageSize = new kakao.maps.Size(25, 26),
            imageOptions = {   
                spriteOrigin: new kakao.maps.Point(8, 36),    
                spriteSize: new kakao.maps.Size(36, 144)  
            };       
     
        // 마커이미지와 마커를 생성합니다
        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
            marker = createMarker(statn_wlPositions[i], markerImage);  

        // 생성된 마커를 휠체어 마커 배열에 추가합니다
        statn_wlMarkers.push(marker);    
    }        
}

// 휠체어 마커들의 지도 표시 여부를 설정하는 함수입니다
function setStatn_wlMarkers(map) {        
    for (var i = 0; i < statn_wlMarkers.length; i++) {  
    	statn_wlMarkers[i].setMap(map);
    }        
}

// 유아수유방 마커를 생성하고 유아수유방 마커 배열에 추가하는 함수입니다
function createStatn_bfMarkers() {
    for (var i = 0; i < statn_bfPositions.length; i++) {
        
        var imageSize = new kakao.maps.Size(25, 26),
            imageOptions = {   
                spriteOrigin: new kakao.maps.Point(8, 74),    
                spriteSize: new kakao.maps.Size(36, 144)  
            };       
     
        // 마커이미지와 마커를 생성합니다
        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
            marker = createMarker(statn_bfPositions[i], markerImage);  

        // 생성된 마커를 주차장 마커 배열에 추가합니다
        statn_bfMarkers.push(marker);        
    }                
}

// 유아수유방 마커들의 지도 표시 여부를 설정하는 함수입니다
function setStatn_bfMarkers(map) {        
    for (var i = 0; i < statn_bfMarkers.length; i++) {  
    	statn_bfMarkers[i].setMap(map);
    }        
}

//환전키오스크 마커를 생성하고 환전키오스크 마커 배열에 추가하는 함수입니다
function createStatn_emMarkers() {
    
    for (var i = 0; i < statn_emPositions.length; i++) {  
        
        var imageSize = new kakao.maps.Size(25, 26),
            imageOptions = {  
                spriteOrigin: new kakao.maps.Point(8, 114),    
                spriteSize: new kakao.maps.Size(36, 144)  
            };     
        
        // 마커이미지와 마커를 생성합니다
        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
            marker = createMarker(statn_emPositions[i], markerImage);  
        
        // 생성된 마커를 환전키오스크 마커 배열에 추가합니다
        statn_emMarkers.push(marker);
    }     
}

// 환전키오스크 마커들의 지도 표시 여부를 설정하는 함수입니다
function setStatn_emMarkers(map) {        
    for (var i = 0; i < statn_emMarkers.length; i++) {  
       statn_emMarkers[i].setMap(map);
    }        
}




// 카테고리를 클릭했을 때 type에 따라 카테고리의 스타일과 지도에 표시되는 마커를 변경합니다
function changeMarker(type){
    
    var statn_evMenu = document.getElementById('statn_evMenu');
    var statn_wlMenu = document.getElementById('statn_wlMenu');
    var statn_bfMenu = document.getElementById('statn_bfMenu');
    var statn_emMenu = document.getElementById('statn_emMenu');
    
    // 커피숍 카테고리가 클릭됐을 때
    if (type === 'statn_ev') {
    
        // 커피숍 카테고리를 선택된 스타일로 변경하고
        statn_evMenu.className = 'menu_selected';
        
        // 편의점과 주차장 카테고리는 선택되지 않은 스타일로 바꿉니다
        statn_wlMenu.className = '';
        statn_bfMenu.className = '';
        statn_emMenu.className = '';
        
        // 커피숍 마커들만 지도에 표시하도록 설정합니다
        setStatn_evMarkers(map);
        setStatn_wlMarkers(null);
        setStatn_bfMarkers(null);
        setStatn_emMarkers(null);
        
    } else if (type === 'statn_wl') { // 편의점 카테고리가 클릭됐을 때
    
        // 편의점 카테고리를 선택된 스타일로 변경하고
        statn_evMenu.className = '';
        statn_wlMenu.className = 'menu_selected';
        statn_bfMenu.className = '';
        statn_emMenu.className = '';
        
        // 편의점 마커들만 지도에 표시하도록 설정합니다
        setStatn_evMarkers(null);
        setStatn_wlMarkers(map);
        setStatn_bfMarkers(null);
        setStatn_emMarkers(null);
        
    } else if (type === 'statn_bf') { // 주차장 카테고리가 클릭됐을 때
     
        // 주차장 카테고리를 선택된 스타일로 변경하고
        statn_evMenu.className = '';
        statn_wlMenu.className = '';
        statn_bfMenu.className = 'menu_selected';
        statn_emMenu.className = '';
        
        // 주차장 마커들만 지도에 표시하도록 설정합니다
        setStatn_evMarkers(null);
        setStatn_wlMarkers(null);
        setStatn_bfMarkers(map);
        setStatn_emMarkers(null);
    } else if (type === 'statn_em') { // 주차장 카테고리가 클릭됐을 때
     
        // 주차장 카테고리를 선택된 스타일로 변경하고
        statn_evMenu.className = '';
        statn_wlMenu.className = '';
        statn_bfMenu.className = '';
        statn_emMenu.className = 'menu_selected';
        
        // 주차장 마커들만 지도에 표시하도록 설정합니다
        setStatn_evMarkers(null);
        setStatn_wlMarkers(null);
        setStatn_bfMarkers(null);
        setStatn_emMarkers(map);
    }    
} 
</script>
    
    
  <!--  <table>
		<tr>
			<td><a href="s_info_disability_fac?fac=statn_ev"><img src="resources/img/subway_img/lift-sign.png" alt="엘리베이터" ><br />엘리베이터</a></td>
			<td><a href="#"><img src="resources/img/MyPage.png" alt="#" ><br />환전키오스크유무</a></td>
			<td><a href="#"><img src="resources/img/MyPage.png" alt="#" ><br />휠체어리프트</a></td>
			<td><a href="#"><img src="resources/img/MyPage.png" alt="#" ><br />유아수유방</a></td>
		</tr>
	</table> -->
	<details>
		<summary>
			<p>엘레베이터 자세한 위치 정보  <img src="resources/img/subway_img/click.png" alt="clickIMG"  width="40"></p>
		</summary>

		<div>
			<!-- 검색기능 -->
			<form action="s_info_disability_fac_ev" method="get" class="sc">
				 <input type="text" name="sek" value="${sek }" id="sek"
					onclick="clearVal()" /> <input type="submit" value="역사 이름 검색" />
			</form>
		</div>
		<div class="tb">
			<table class="tg" style="table-layout: fixed; width: 1000px">
				<colgroup>
					<col style="width: 67px">
					<col style="width: 262px">
					<col style="width: 247px">
					<col style="width: 201px">
					<col style="width: 156px">

				</colgroup>
				<thead>
					<tr>
						<th>호선</th>
						<th>역사이름</th>
						<th>엘레베이터 위치</th>
						<th>승강기번호</th>
						<th>진행방향</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${ev_info }" var="ei">
						<tr>
							<td>${ei.route }</td>
							<td>${ei.statn_nm }</td>
							<td>${ei.ev_loca }</td>
							<td>${ei.ev_nv }</td>
							<td>${ei.ev_ml }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

	
		</div>
		</details>
	<details open>
		<summary>
			<p>휠체어리프트 자세한 위치 정보  <img src="${pageContext.request.contextPath }/resources/img/subway_img/click.png" alt="clickIMG"  width="40"></p>
		</summary>

		<div>
			<!-- 검색기능 -->
			<form action="s_info_disability_fac_wl" method="get" class="sc">
				 <input type="text" name="swlk" value="${swlk }" id="swlk"
					onclick="clearVal()" /> <input type="submit" value="역사 이름 검색" />
			</form>
		</div>
		<div class="tb">
			<table class="tg" style="table-layout: fixed; width: 1000px">
				<colgroup>
					<col style="width: 67px">
					<col style="width: 262px">
					<col style="width: 247px">
					<col style="width: 201px">
					<col style="width: 156px">

				</colgroup>
				<thead>
					<tr>
						<th>호선</th>
						<th>역사이름</th>
						<th>휠레어리프트 위치</th>
						<th>승강기번호</th>
						<th>진행방향</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${wl_info }" var="wl">
						<tr>
							<td>${wl.route }</td>
							<td>${wl.statn_nm }</td>
							<td>${wl.wl_loca }</td>
							<td>${wl.wl_nv }</td>
							<td>${wl.wl_ml }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

	
		</div>
		</details>
</body>
</html>
 