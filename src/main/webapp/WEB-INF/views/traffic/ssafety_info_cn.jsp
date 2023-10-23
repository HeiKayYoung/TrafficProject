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
<h3>地铁安全信息

<span><button type="button" onclick="location.href='ssafety_info' " >한국어</button></span>
<span><button type="button" onclick="location.href='ssafety_info_en' " >English</button></span>
<span><button type="button" onclick="location.href='ssafety_info_cn' "  >汉语</button></span>


</h3>
<hr />


<h5 style="color: gray;">有关地铁安全的信息，和坐地铁的提示。</h5>
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
					<th>数</th>
					<th>标题 </th>
					
					<th>发表于</th>
					<th>阅读次数</th>
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
 