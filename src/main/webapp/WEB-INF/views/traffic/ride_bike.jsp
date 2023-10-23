<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>따릉따릉따릉이</title>
</head>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" /> -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="../resources/css/user/ride_bike.css" />
<style>
#content {
	height: 100%;
}

#bikeimg {
	width: 500px;
	hegith: 300px;
	text-align: center;
	margin-top:40px;
	margin-bottom:30px;
}
#dto_title{
	font-size: 32px;
	font-weight : bold;
	text-align: center;
	padding-bottom: 20px;
}
#dto_content{
	font-size: 16px;
	border-bottom: 2px solid black;
    text-align: center;
    padding: 10px; 
}
#table{
	margin-right:auto;
	margin-left:auto;
}
#table tr:last-child td{
    border-bottom: none;
}
</style>

<body>
	<div id="title">자전거 안전하게 타는 법</div>

	<div>
		<table id="table">
			<c:forEach items="${dto }" var="dto">
				<tr>
					<td style="text-align: center;">
					<img src="../resources/img/${dto.bikeimg }.png" alt="${dto.bikeimg }" id="bikeimg"/>
					</td>
				</tr>
				<tr>
					<td id="dto_title">${dto.no}. ${dto.title }</td>
				</tr>
				<tr>
					<td id="dto_content">${fn:replace(dto.howride, '.', '.<br>')}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

</body>


</html>
