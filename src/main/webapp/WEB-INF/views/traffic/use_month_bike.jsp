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
<link rel="stylesheet" href="../resources/css/user/use_bike.css" />
<style>
#content {
	height: auto;
}

.row {
	width: 1000px;
}

</style>

<body>
	<div id="title">공공자전거 이용 현황</div>
	<div id="box">
		<div id="years">
		<a href="use_year_bike" class="year">연도별</a> 
		<a href="use_month_bike" class="year" id="selectedYear">월별</a> 
		</div>
		<div class="drop_down">
			<label for="yearSelect">연도 :</label> 
			<select name="yearSelect" id="yearSelect">
				<option value="2021">2021</option>
				<option value="2022">2022</option>
				<option value="2023" selected>2023</option>
			</select>
			<label for="monthSelect">월 :</label> 
			<select name="monthSelect" id="monthSelect">
				<option value="1">1월</option>
				<option value="2">2월</option>
				<option value="3">3월</option>
				<option value="4">4월</option>
				<option value="5">5월</option>
				<option value="6" selected>6월</option>
				<option value="7">7월</option>
				<option value="8">8월</option>
				<option value="9">9월</option>
				<option value="10">10월</option>
				<option value="11">11월</option>
				<option value="12">12월</option>
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

document.getElementById('selectedYear').addEventListener('click', function(event) {
    event.preventDefault(); 
    });
	var myChart1;

	
	$(document).ready(function() {
		$("#monthSelect, #yearSelect").change(function() {
			var selectedYear = $("#yearSelect").val();
			var selectedMonth = $("#monthSelect").val();
			$.ajax({url : "${pageContext.request.contextPath}/refresh/use_month?yearSelect="+selectedYear+"&monthSelect="+selectedMonth,
					type : "get",
					dataType : "json",
					data : {"year" : selectedYear,
							"month" : selectedMonth},
					success : function(data) {
					// AJAX 성공 시, 데이터 업데이트 및 차트 다시 렌더링
					updateChart(data);
					console.log(data);
					},
					error : function() {
					console.log('실패');
					}
				});
			});
		});

	function updateChart(data) {
		myChart1.data.labels = data.map(function(item) {
		    return item.Date+"일";
		});
		myChart1.data.datasets[0].data = data.map(function(item) {
			return item.Num;	
		});
		myChart1.update();
	}

	var jArray = JSON.parse('${arr}');

	const ctx1 = document.getElementById('myChartOne').getContext('2d');


	myChart1 = new Chart(ctx1, {
		type : 'line',
		data : {
			labels : jArray.map(function(item) {
	            return item.Date+"일";
	        }),
			datasets : [ {
				label : '일별 이용자 수',
				data : jArray.map(function(item) {
					return item.Num;
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
