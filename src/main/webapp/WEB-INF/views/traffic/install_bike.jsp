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
<style>
#content {
	height: auto;
}

.row {
	width: 1000px;
}

.drop_down {
	margin-left: 72px;
	margin-top: 20px;
	font-size: 24px;
}

#yearSelect {
	width: 110px;
	height: 40px;
	font-size: 18px;
}
#box{
	display : inline-flex;	
}
#text p{
	display: inline-block;
	margin-top: 40px;
	margin-left: 500px;
}
</style>

<body>
	<div id="title">공공자전거 대여소 설치 현황</div>
	<div id="box">
	<div class="drop_down">
		<label for="yearSelect">연도 :</label> <select name="yearSelect"
			id="yearSelect">
			<option value="2021">2021년</option>
			<option value="2022">2022년</option>
			<option value="2023" selected>2023년</option>
		</select>
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
	var myChart1;

	$(document).ready(function() {
		$("#yearSelect").change(function() {
			var selectedYear = $(this).val();
			console.log(selectedYear);
			$.ajax({url : "${pageContext.request.contextPath}/refresh/year?yearSelect="+selectedYear,
					type : "get",
					dataType : "json",
					data : {"year" : selectedYear},
					success : function(data) {
					// AJAX 성공 시, 데이터 업데이트 및 차트 다시 렌더링
					console.log("here?");
					updateChart(data);
					},
					error : function() {
					console.log('실패');
					}
				});
			});
		});

	function updateChart(data) {
		myChart1.data.datasets[0].data = data.map(function(item) {
			return item.Count;
		});
		myChart1.update();
	}

	var jArray = JSON.parse('${arr}');

	const ctx1 = document.getElementById('myChartOne').getContext('2d');

	myChart1 = new Chart(ctx1, {
		type : 'bar',
		data : {
			labels : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
					'10월', '11월', '12월' ],
			datasets : [ {
				label : '대여소 설치 수',
				data : jArray.map(function(item) {
					return item.Count;
				}),
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
