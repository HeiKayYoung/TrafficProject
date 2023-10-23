<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<style>

        #form{
            width: 1150px;
        }

		table {
		  border-collapse: separate;
		  border-spacing: 0;
		  width: 1150px;
		}
		th, td {
		  padding: 6px 15px;
		}
		th {
		  background: #42444e;
		  color: #fff;
		  font-size: 16px;
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
				
		#searchYearCd, #sido, #gugun, .button{
		  /* 생략 */
		  font-family: 'GmarketSansMedium';
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
		
		.button{
			color: black;
            background-color: lightblue;
            cursor: pointer;
		}
		
    </style>
    
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	
</head>
<body>

	<h1>지자체별 사고다발지역 TOP3</h1>
	<br />
	<h3 style="color: red">* 구(區), 군(郡) 을 전체로 선택하면 해당 시/도의 모든 데이터를 보여줍니다.</h3>
	<h3 style="color: red">* 구(區), 군(郡) 을 선택 시 사고 발생수 상위 3개씩 보여줍니다.</h3>
	<br />
	
    <div id="map" style="width:100%; height:550px;"></div>
    
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=76c95b8154684160a740218f83546db0"></script>
    <script>
    
    	// 카카오맵
    	
    	var info = [];
    	var positions = [];
    	
    	<c:forEach items="${list}" var="li">
    		info.push({title:"${li.spot_nm}", la_crd:"${li.la_crd}", lo_crd:"${li.lo_crd}"})
   			positions.push({title:"${li.spot_nm}",  latlng: new kakao.maps.LatLng("${li.la_crd}", "${li.lo_crd}")})
   		</c:forEach>
    	
	    var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		    mapOption = { 
		        center: new kakao.maps.LatLng(info[0].la_crd, info[0].lo_crd), // 지도의 중심좌표
		        level: 6 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png"; 
		    
		for (var i = 0; i < positions.length; i ++) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		}
    	
		////////////////////////////////////////////////////////////////////////////////
    	
		function firstConditionChanged(){
   
            var sido = $("select[name=sido]").val();

            $.ajax({
                type : "GET",
                url : "caraccident_top3_typechanged?sido="+sido,
                success : function(result){
                	
                	$("select#gugun option").remove();
                	
                	$("select#gugun").append("<option value='' selected>" + '전체' + "</option>");
                	
                	for(var i = 0; i<result.length; i++){
                		$("select#gugun").append("<option value='" + result[i].subcode + "'>" + result[i].subcodename + "</option>");
                	}
                	
                }
            });
			
		};
		
    </script>
    
	<br />
	
    <div id="form">
        <form action="caraccident_top3">
            <div>
            	<span>
            		<select name="searchYearCd" id="searchYearCd">
                    	<c:forEach items="${yearSearchType}" var="li">
                    		<c:if test="${ searchYearCd == li.code }">
                        		<option value="${li.code}" selected>${li.codename}</option>
                        	</c:if>
							<c:if test="${ searchYearCd != li.code }">
                        		<option value="${li.code}">${li.codename}</option>
                        	</c:if>
                    	</c:forEach>
                    </select>
            	</span>
                <span>
                    <select name="sido" id="sido" onchange="firstConditionChanged()">
                    	<c:forEach items="${firstSearchType}" var="li">
                    		<c:if test="${ sido == li.code }">
                        		<option value="${li.code}" selected>${li.codename}</option>
                        	</c:if>
							<c:if test="${ sido != li.code }">
                        		<option value="${li.code}">${li.codename}</option>
                        	</c:if>
                    	</c:forEach>
                    </select>
                </span>
                <span>
                    <select name="gugun" id="gugun">
                    	<c:if test="${empty param.gugun}">
                    		<option value="" selected>전체</option>
                    	</c:if>
                    	<c:if test="${not empty param.gugun}">
                    		<option value="">전체</option>
                    	</c:if>
                        <c:forEach items="${secondSearchType}" var="li">
                        	<c:if test="${ gugun == li.subcode }">
                        		<option value="${li.subcode}" selected>${li.subcodename}</option>
                        	</c:if>
							<c:if test="${ gugun != li.subcode }">
                        		<option value="${li.subcode}">${li.subcodename}</option>
                        	</c:if>
                    	</c:forEach>
                    </select>
                </span>
                <span>
                    <input type="submit" class="button" value="검색">
                </span>
            </div>
            <br>
            <div>
                <table>
                    <tr>
                        <th width="5%">순위</th>
                        <th width="35%">사고다발 지역 주소</th>
                        <th width="11%">총 사고건수</th>
                        <th width="11%">총 경상자수</th>
                        <th width="11%">총 중상자수</th>
                        <th width="11%">총 사망자수</th>
                        <th width="8%">위치 위도</th>
                        <th width="8%">위치 경도</th>
                    </tr>
                    <c:forEach items="${list}" var="li" varStatus="st">
                    	<tr>
	                        <td width="5%">${st.index + 1}</td>
	                        <td width="35%">${li.spot_nm}</td>
	                        <td width="10%" style="color: blue">${li.occrrnc_cnt}</td>
	                        <td width="10%" style="color: green">${li.sl_dnv_cnt}</td>
	                        <td width="10%" style="color: purple">${li.se_dnv_cnt}</td>
	                        <td width="10%" style="color: red">${li.dth_dnv_cnt}</td>
	                        <td width="10%">${li.la_crd}</td>
	                        <td width="10%">${li.lo_crd}</td>
	                    </tr>
                    </c:forEach>
                </table>
            </div>
        </form>
        <br /><br />
    </div>
	
</body>
</html>