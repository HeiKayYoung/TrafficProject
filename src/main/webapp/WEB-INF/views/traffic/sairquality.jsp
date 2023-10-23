<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<h3>지하철 공기 질 측정 정보(2023.07.19)</h3>
<hr />
 
<style>
	
		#content{
			height: 100%;
		}
		
	</style>
	
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-sm-12">
				<canvas width="400" height="400" id="myChartOne"></canvas>
			</div>
			<div class="col-md-6 col-sm-12" >
				<canvas width="400" height="400" id="myChartTwo"></canvas>
			</div>
		</div>
	</div>

	<script>
	var jArray=new Array();
	var jArray2=new Array();
	jArray='${arr }';
	jArray2='${arrRow }';
	/* 파싱 */
	jArray=JSON.parse(jArray);
	airRow=JSON.parse(jArray2);
	/* alert(jArray[0].s_name);
	alert(airRow[0].s_name); */
	
		
		const ctx1 = document.getElementById('myChartOne').getContext('2d');
		const ctx2 = document.getElementById('myChartTwo').getContext('2d');
		const DATA_COUNT = 5;
		const NUMBER_CFG = {count: DATA_COUNT, min: 0, max: 1000};

		const labels = [ jArray[0].s_name, jArray[1].s_name,jArray[2].s_name,jArray[3].s_name,jArray[4].s_name ];
		const myChart1 = new Chart(ctx1, {
				  type: 'bar',
				  data: {
					  labels: labels,
					  datasets: [
					    {
					      label: '미세먼지',
					      data: [  jArray[0].s_pdust, jArray[1].s_pdust,jArray[2].s_pdust,jArray[3].s_pdust,jArray[4].s_pdust],
					    backgroundColor: 'rgba(255, 102, 102, 1.0)',
					    },
					    {
						      label: '일산화탄소',
						      data: [  jArray[0].s_co, jArray[1].s_co,jArray[2].s_co,jArray[3].s_co,jArray[4].s_co],
						         backgroundColor: 'rgba(51, 153, 255, 1.0)',
						    },
						    {
						      label: '폼알데하이드',
						      data: [  jArray[0].s_h2co, jArray[1].s_h2co,jArray[2].s_h2co,jArray[3].s_h2co,jArray[4].s_h2co],
						      backgroundColor: 'rgba(178,102,255,1.0)',
						    },
						    {
						      label: '이산화탄소',
						      data: [  jArray[0].s_co2, jArray[1].s_co2,jArray[2].s_co2,jArray[3].s_co2,jArray[4].s_co2],
						      backgroundColor: 'rgba(85,255,132,1.0)',
						    },
					    
					  ]
					},
				  options: {
				    plugins: {
				      title: {
				        display: true,
				        text: '공기 질 좋은 지하철역 1 ~ 5위'
				      },
				    },
				    responsive: true,
				    scales: {
				      x: {
				        stacked: true,
				      },
				      y: {
				        stacked: true
				      }
				    }
				  }
		});
		
		const myChart2 = new Chart(ctx2, {
				  type: 'bar',
				  data: {
					  labels: [ airRow[0].s_name, airRow[1].s_name,airRow[2].s_name,airRow[3].s_name,airRow[4].s_name ],
					  datasets: [
					    {
					      label: '미세먼지',
					      data: [  airRow[0].s_pdust, airRow[1].s_pdust,airRow[2].s_pdust,airRow[3].s_pdust,airRow[4].s_pdust],
					    backgroundColor: 'rgba(255, 102, 102, 1.0)',
					    },
					    {
						      label: '일산화탄소',
						      data: [  airRow[0].s_co, airRow[1].s_co, airRow[2].s_co,airRow[3].s_co,airRow[4].s_co],
						         backgroundColor: 'rgba(51, 153, 255, 1.0)',
						    },
						    {
						      label: '폼알데하이드',
						      data: [  airRow[0].s_h2co, airRow[1].s_h2co,airRow[2].s_h2co,airRow[3].s_h2co,airRow[4].s_h2co],
						      backgroundColor: 'rgba(178,102,255,1.0)',
						    },
						    {
						      label: '이산화탄소',
						      data: [  airRow[0].s_co2, airRow[1].s_co2,airRow[2].s_co2,airRow[3].s_co2,airRow[4].s_co2],
						      backgroundColor: 'rgba(85,255,132,1.0)',
						    },
					    
					  ]
					},
				  options: {
				    plugins: {
				      title: {
				        display: true,
				        text: '공기 질 개선 필요한 지하철역 1 ~ 5위'
				      },
				    },
				    responsive: true,
				    scales: {
				      x: {
				        stacked: true,
				      },
				      y: {
				        stacked: true
				      }
				    }
				  }
		});
		


	</script>
	<h5>자료 출처 : 서울교통공사</h5>
</body>
</html>
 