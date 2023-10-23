<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://openlayers.org/en/v4.6.5/css/ol.css" type="text/css">
<!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
<script
	src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
<link rel="stylesheet" href="resources/css/user/scongestion.css" />
<script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<style>
#content {
	height: 100%;
}
</style>
	<h3>지하철 혼잡도</h3>
	<hr />


	<h5 style="color: gray;">지하철 시간별 혼잡정도를 색깔로 확인하세요.</h5>
	

		<div id="map" class="map"></div>
		<script>
      var layers = [
        new ol.layer.Tile({
          source: new ol.source.OSM()
        }),
        new ol.layer.Tile({

          source: new ol.source.TileWMS({
        	   url: 'http://localhost:8085/geoserver/subway_line2part/wms', 
        	  params: {'LAYERS': 'subway_line2part:subway_line2', 'TILED': true}, 
            serverType: 'geoserver',
            // Countries have transparency, so do not fade tiles:
            transition: 0
          })
        })
      ];
      var map = new ol.Map({
        layers: layers,
        target: 'map',
        view: new ol.View({
        	projection:"EPSG:4326",
          center: [126.952712, 37.48121],
          zoom: 14
        })
      });
    </script>
  
    <p>기본 설정 : 평일 오전 8시 기준</p>
    <div class="tb">
		<table class="tg" style="table-layout: fixed; width: 720px">
			<colgroup>
				<col style="width: 120px">
				<col style="width: 80px">
				<col style="width: 80px">
				<col style="width: 80px">
				<col style="width: 80px">
				<col style="width: 80px">
				<col style="width: 80px">
				<col style="width: 80px">
				<col style="width: 120px">

			</colgroup>
			<thead>
				<tr>
					<th>한가함</th>
					<th style="background-color:#fcf2c5"></th>
					<th style="background-color:#FFDE4A"></th>
					<th style="background-color:#4AFF75"></th>
					<th style="background-color:#FF8F33"></th>
					<th style="background-color:#5758FF"></th>
					<th style="background-color:#FF0015"></th>
					<th></th>
					<th>혼잡함</th>
				</tr>
			</thead>
		</table>
		<form action="scongestion"  class="sc">
			<select name="congesttime">
				<option value="time8" ${congesttime eq 'time8' ? 'selected' : ''}>오전8시</option>
				<option value="time9" ${congesttime eq 'time9' ? 'selected' : ''}>오전9시</option>
				<option value="time18"
					<c:if test ="${congesttime eq 'time18'}"> selected="selected"</c:if>>오후6시
				</option>
				<option value="time19" ${congesttime eq 'time19' ? 'selected' : ''}>오후7시</option>
			</select>
			<input type="submit" value="검색" />
		</form>
</body>
</html>