<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 차트 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@3.0.0"></script>


<%-- <script src="${pageContext.request.contextPath}/resources/js/user/map.js"></script> --%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9bdfa0d98e7c6b1949b387b6e48e0de3&libraries=services"></script>

	<style>
		.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
		.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
		.map_wrap {position:relative;width:100%;height:500px;}
		#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
		.bg_white {background:#fff;}
		#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
		#menu_wrap .option{text-align: center;}
		#menu_wrap .option p {margin:10px 0;}  
		#menu_wrap .option button {margin-left:5px;}
		#placesList li {list-style: none;}
		#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
		#placesList .item span {display: block;margin-top:4px;}
		#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
		#placesList .item .info{padding:10px 0 10px 55px;}
		#placesList .info .gray {color:#8a8a8a;}
		#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
		#placesList .info .tel {color:#009900;}
		#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
		#placesList .item .marker_1 {background-position: 0 -10px;}
		#placesList .item .marker_2 {background-position: 0 -56px;}
		#placesList .item .marker_3 {background-position: 0 -102px}
		#placesList .item .marker_4 {background-position: 0 -148px;}
		#placesList .item .marker_5 {background-position: 0 -194px;}
		#placesList .item .marker_6 {background-position: 0 -240px;}
		#placesList .item .marker_7 {background-position: 0 -286px;}
		#placesList .item .marker_8 {background-position: 0 -332px;}
		#placesList .item .marker_9 {background-position: 0 -378px;}
		#placesList .item .marker_10 {background-position: 0 -423px;}
		#placesList .item .marker_11 {background-position: 0 -470px;}
		#placesList .item .marker_12 {background-position: 0 -516px;}
		#placesList .item .marker_13 {background-position: 0 -562px;}
		#placesList .item .marker_14 {background-position: 0 -608px;}
		#placesList .item .marker_15 {background-position: 0 -654px;}
		#pagination {margin:10px auto;text-align: center;}
		#pagination a {display:inline-block;margin-right:10px;}
		#pagination .on {font-weight: bold; cursor: default;color:#777;}
	</style>

</head>
<body>
	
	<style>
	
		#content{
			height: auto;
			width: auto;
		}
		#map {
			margin-top: 5px;
			margin-bottom: 5px;
			width: 1200px;
			height: 500px;
			position: relative; 
			overflow: hidden;
		}
		.title {
			margin-top: 5px;
			margin-bottom: 5px;
			font-size: 24px;
			text-align: center;
		}
		hr {
			margin: 0 0 0 0;
			width: 1200px;
		}
		#parkingChart {
            margin-top: 5px;
            margin-bottom: 5px;
        }
        #list-box table {
	    	margin-top: 10px;
	    	margin-bottom: 10px;
	    	width: 1200px;
	    	height: 20px;
	    }
	    #list-box table td {
	    	border: 1px solid grey;
	    }
	    #list-box table td a{
	    	text-decoration: none;
	    	cursor: pointer;
	    }
	    tr:first-child {
			font-size: 20px;
			font-style: bold;
			background-color: #f5f5f5;
			border-top-color: black;
			color: #525252;
		}
	    td {
	    	text-align: center;
			padding-top: 5px;
			padding-bottom: 5px;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		#parkingChart{
			width: 1200px;
			height: 500px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		#parkingChart2{
			width: 600px;
			height: auto;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		#parkingChart3{
			width: 600px;
			height: auto;
			margin-top: 10px;
			margin-bottom: 10px;
		}
	</style>

	<hr />
		<div class="title">주차장 검색하기</div>
	<hr />
	
	 <div style="color : gray; display: flex;">
        * 본 게시판은 주차대수 10대 이상의 주차장만 조회한 결과입니다.
    </div>
	
	<div id="list-box">
		<table>
			<tr>
				<td><a href="map">서울시 공영주차장</a></td>
				<td><a href="ec_map">서울시 전기차 충전소</a></td>
			</tr>
		</table>
	</div>
	
	<div class="map_wrap">
		<div id="map"></div>

		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>
					<form onsubmit="searchPlaces(); return false;">
						키워드 : <input type="text" value="구로구 공영주차장" id="keyword" size="15">
						<button type="submit">검색하기</button>
					</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>

<script>
	//마커를 담을 배열입니다
	var markers = [];
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.5668106, 126.9786417), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	// 키워드로 장소를 검색합니다
	searchPlaces();
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
	
	    var keyword = document.getElementById('keyword').value;
	
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);
	
	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);
	
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	
	    } else if (status === kakao.maps.services.Status.ERROR) {
	
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	
	    }
	}
	
	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
	
	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
	
	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);
	
	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });
	
	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	
	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };
	
	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name);
	
	        fragment.appendChild(itemEl);
	    }
	
	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}
	
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	
	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';
	
	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           
	
	    el.innerHTML = itemStr;
	    el.className = 'item';
	
	    return el;
	}
	
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 
	
	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	
	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;
	
	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }
	
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}
	
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}
	
	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}
</script>

	<!-- 차트 -->
	<canvas id="parkingChart"></canvas>
	<script>
	    var parkingData = JSON.parse('${arr}');
	
	    var labels = parkingData[0].seoul_parking_chart_data.map(function(item) {
	        return item.구;
	    });
	
	    var parkingCounts = parkingData[0].seoul_parking_chart_data.map(function(item) {
	        return item.PARKING_COUNT;
	    });
	
	    // 차트
	    var ctx = document.getElementById('parkingChart').getContext('2d');
	    var chart = new Chart(ctx, {
	        type: 'bar',
	        data: {
	            labels: labels,
	            datasets: [{
	                label: '주차장 갯수',
	                data: parkingCounts,
	                backgroundColor: [
	            				'rgba(75, 192, 192, 0.2)',
				                'rgba(0, 0, 255, 0.3)',
			                	'rgba(60, 179, 113, 0.3)',
			                	'rgba(238, 130, 238, 0.3)',
			                	'rgba(255, 165, 0, 0.3)',
			                	'rgba(0, 255, 71, 0.3)',
			                	'rgba(255, 255, 71, 0.3)',
			                	'rgba(64, 161, 42, 0.3)',
			                	'rgba(215, 161, 42, 0.3)',
			                	'rgba(215, 25, 42, 0.3)'
			                	],
	                borderColor: 'rgba(75, 192, 192, 1)',
	                borderWidth: 1
	            }]
	        },
	        options: {
	        	responsive: false,
	            scales: {
	                y: {
	                    beginAtZero: true
	                }
	            },
	        },
	        plugins: {
            	datalabels: {
                    display: true,
                    color: 'black', // 레이블 텍스트 색상
                    font: {
                        weight: 'bold'
                    }
                }
            }
	    });
	   
	</script>
	
	<div style="display:flex; margin-top: 10px; margin-bottom: 10px;">
		<!-- 구 무료 주차장 갯수 -->
		<canvas id="parkingChart2"></canvas>
		<script>
		    var FreeparkingData = JSON.parse('${arr2}');
		
		    var free_labels = FreeparkingData[0].seoul_parking_chart_free_data.map(function(item) {
		        return item.구;
		    });
		
		    var freeparkingCounts = FreeparkingData[0].seoul_parking_chart_free_data.map(function(item) {
		        return item.FREE_PARKING_COUNT;
		    });
		
		    // 차트
		    var ctx = document.getElementById('parkingChart2').getContext('2d');
		    var chart = new Chart(ctx, {
		        type: 'line',
		        data: {
		            labels: free_labels,
		            datasets: [{
		                label: '무료 주차장 갯수',
		                data: freeparkingCounts,
		                backgroundColor: [
		                	'rgba(255, 0, 0, 0.3)',
		                	'rgba(0, 0, 255, 0.3)',
		                	'rgba(60, 179, 113, 0.3)',
		                	'rgba(238, 130, 238, 0.3)',
		                	'rgba(255, 165, 0, 0.3)',
		                	'rgba(0, 255, 71, 0.3)',
		                	'rgba(255, 255, 71, 0.3)',
		                	'rgba(64, 161, 42, 0.3)',
		                	'rgba(215, 161, 42, 0.3)',
		                	'rgba(215, 25, 42, 0.3)',
		                	],
		                borderColor: 'rgba(75, 192, 192, 1)',
		                borderWidth: 1
		            }]
		        },
		        options: {
		        	responsive: false,
		            scales: {
		                y: {
		                    beginAtZero: true
			                }
			            },
			            plugins: {
			            	datalabels: {
			                    display: true,
			                    color: 'black', // 레이블 텍스트 색상
			                    font: {
			                        weight: 'bold'
			                    }
			                }
			                /* legend: {
			                    display: true, // 이 부분을 추가하여 레전드를 표시합니다.
			                    position: 'top', // 레전드의 위치를 설정합니다. 필요에 따라 수정하세요.
			                },
			                tooltip: {
			                    enabled: true // 툴팁을 표시하도록 설정합니다.
			                } */
			            }
			        }
			    });
		</script>
		
		<!-- 구 유료 주차장 갯수 -->
		<canvas id="parkingChart3"></canvas>
		<script>
		    var NotFreeparkingData = JSON.parse('${arr3}');
		
		    var Notfree_labels = NotFreeparkingData[0].seoul_parking_chart_not_free_data.map(function(item) {
		        return item.구;
		    });
		
		    var NotfreeparkingCounts = NotFreeparkingData[0].seoul_parking_chart_not_free_data.map(function(item) {
		        return item.NOT_FREE_PARKING_COUNT;
		    });
		
		    // 차트
		    var ctx = document.getElementById('parkingChart3').getContext('2d');
		    var chart = new Chart(ctx, {
		        type: 'line',
		        data: {
		            labels: Notfree_labels,
		            datasets: [{
		                label: '유료 주차장 갯수',
		                data: NotfreeparkingCounts,
		                backgroundColor: [
		                	'rgba(255, 0, 0, 0.3)',
		                	'rgba(0, 0, 255, 0.3)',
		                	'rgba(60, 179, 113, 0.3)',
		                	'rgba(238, 130, 238, 0.3)',
		                	'rgba(255, 165, 0, 0.3)',
		                	'rgba(0, 255, 71, 0.3)',
		                	'rgba(255, 255, 71, 0.3)',
		                	'rgba(64, 161, 42, 0.3)',
		                	'rgba(215, 161, 42, 0.3)',
		                	'rgba(215, 25, 42, 0.3)',
		                	],
		            
		                borderColor: 'rgba(0, 0, 0, 1)',
		                borderWidth: 1
		            }]
		        },
		        options: {
		        	responsive: false,
		            scales: {
		                y: {
		                    beginAtZero: true
			                }
			            },
			        }
			    });
		    console.log(NotFreeparkingData);
		    console.log(Chart.version);
		</script>
		
	</div>
</body>
</html>
 