<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="resources/css/user/subway_safety_info_list.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<style>
#content {
	height: 100%;
}
</style>
<h3>지하철 안전정보 

<span><button type="button" onclick="location.href='ssafety_info' " >한국어</button></span>
<span><button type="button" onclick="location.href='ssafety_info_en' " >English</button></span>
<span><button type="button" onclick="location.href='ssafety_info_cn' "  >汉语</button></span>

</h3>
<hr />


<h5 style="color: gray;">지하철의 안전 관련 소식들과 유용한 정보들을 한곳에서 확인하세요.</h5>
	<div class="tb">
		<table class="tg" style="table-layout: fixed; width: 1000px">
			<colgroup>
				<col style="width: 67px">
				<col style="width: 612px">
				<col style="width: 97px">
				<col style="width: 101px">
				<col style="width: 56px">
				
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목 </th>
					
					<th>작성일</th>
					<th>조회수</th>
				</tr>           
			</thead>
			<tbody>
				
				<c:forEach items="${ssafetyL }" var="ssl">
					<tr>
						<td>${ssl.ssafety_no }</td>
						<td><a href="ssafety_info_detail?ssafety_no=${ssl.ssafety_no }">${ssl.ssafety_title }</a></td>
						
						<td>${ssl.ssafety_date }</td>
						<td>${ssl.ssafety_count }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	<div>
		
	</div>
	</div>
</body>
</html>
 