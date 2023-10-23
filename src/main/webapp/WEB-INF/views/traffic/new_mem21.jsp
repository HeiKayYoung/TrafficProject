<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>따릉따릉따릉이</title>
</head>
<!-- <link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" /> -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="../resources/css/user/new_member.css" />
<style>
#content {
	height: auto;
}
.row{
	width:1000px;
}
</style>

<body>
	<div id="title">공공자전거 신규등록자 현황</div>
<div id="box">
	<div id="years">
		<a href="new_mem21" class="year" id="selectedYear">2021년</a> 
		<a href="new_mem22" class="year">2022년</a> 
		<a href="new_mem23" class="year">2023년</a>
	</div>
	<div id="text">
		<p>※ 수치가 0이면 데이터가 없음을 의미합니다.</p>
	</div>
</div>

	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<canvas id="myChartOne"></canvas>
			</div>
		</div>
	</div>



</body>
<script>

document.getElementById('selectedYear').addEventListener('click', function(event) {
    event.preventDefault(); 
    });

	const ctx1 = document.getElementById('myChartOne').getContext('2d');
	 const monthlyData = [
		 ${month[0]}, ${month[1]}, ${month[2]}, ${month[3]}, ${month[4]}, ${month[5]},
		 ${month[6]}, ${month[7]}, ${month[8]}, ${month[9]}, ${month[10]}, ${month[11]}];
	
	const myChart1 = new Chart(ctx1, {
		type : 'line',
		data : {
			labels : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			datasets : [ {
				label : '신규 가입자',
				data : monthlyData,
				backgroundColor : [ 'rgba(1,19,67,1)' ],
				borderColor : [ 'rgba(1,19,67,1)' ],
				borderWidth : 3
			} ]
		},
		options : {
			scale : {
				y : {
					beginAtZero : true
				}
			},
			plugins : {
				legend : {
					display : false
				}
			}
		}
	});

</script>

</html>
