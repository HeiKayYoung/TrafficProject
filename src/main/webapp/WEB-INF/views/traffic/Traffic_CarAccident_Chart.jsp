<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
	
	<style>

        #form{
            width: 1200px;
        }
		#datalist{
			list-style: none;
            padding-left: 0;
        }
		#datalist li{
			float: left;
            
            padding-right: 100px;
		}
		#first_table, #second_table{
		
			height: 200px;
		
		}
        #first_table, #second_table, #first_table tr td, #second_table tr td{
            border: 1px solid black;
            border-collapse: collapse;
        }
        .top_col{
        	text-align: center;
        	font-size: 25px;
        	height: 20px;
        }
        .first_col{
            width: 280px;
            padding-left: 10px;
            font-size: 15px;
        }
        .second_col{
        	width: 100px;
            text-align: center;
            font-size: 15px;
        }
        
        @font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		#searchYearCd, #sido, #gugun, .button {
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
    
    <!-- ChartJS -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
	
	
</head>
<body>

	<script>
		
		
	
	</script>
	
	<h1>지자체별 사고 통계</h1>
    <br>
    <div id="form">
        <form action="">
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
        </form>
        <div>
       	 	<br /><br /><br />
        	<div>
        		<ul id="datalist">
        			<li>
        				<div>
        					<h2>법규위반 사고건수</h2>
        				</div>
        				<br />
        				<div>
        					<table id="first_table">
	        					<tr>
			        				<td class="top_col">법규위반 사고유형</td>
			        				<td class="top_col">건수</td>
			        			</tr>
			        			<tr>
			        				<td class="first_col" id="data1">과속</td>
			        				<td class="second_col"  id="value1"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data2">중앙선 침범</td>
			        				<td class="second_col" id="value2"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data3">신호위반</td>
			        				<td class="second_col" id="value3"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data4">안전거리 미확보</td>
			        				<td class="second_col" id="value4"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data5">안전운전 의무 불이행</td>
			        				<td class="second_col" id="value5"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data6">보행자 보호의무 위반</td>
			        				<td class="second_col" id="value6"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data7">기타</td>
			        				<td class="second_col" id="value7"></td>
			        			</tr>
			        		</table>
        				</div>
        				<br /><br />
		        		<div class="col-md-6" style="width: 400px; height: 400px;">
							<canvas id="myChart"></canvas>
						</div>
        			</li>
        			<li>
        				<div>
        					<h2>교통사고 유형</h2>
        				</div>
        				<br />
		        		<div>
		        			<table id="second_table">
		        				<tr>
			        				<td class="top_col">사고유형</td>
			        				<td class="top_col">건수</td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data11">차대사람</td>
			        				<td class="second_col" id="value11"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data12">차대차</td>
			        				<td class="second_col" id="value12"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col" id="data13">차량단독</td>
			        				<td class="second_col" id="value13"></td>
			        			</tr>
			        			<tr>
			        				<td class="first_col"  id="data14">철길건널목</td>
			        				<td class="second_col" id="value14"></td>
			        			</tr>
			        		</table>
		        		</div>
		        		<br /><br />
		        		<div class="col-md-6" style="width: 400px; height: 400px;">
							<canvas id="myChart2"></canvas>
						</div>
						<br /><br />
        			</li>
        		</ul>
        	</div>
			
		</div>
    </div>
    <script>
	
	    function firstConditionChanged(){
			   
	        var sido = $("select[name=sido]").val();
	
	        $.ajax({
	            type : "GET",
	            url : "caraccident_chart_typechanged?sido="+sido,
	            success : function(result){
	            	
	            	$("select#gugun option").remove();
	            	
	            	for(var i = 0; i<result.length; i++){
	            		$("select#gugun").append("<option value='" + result[i].subcode + "'>" + result[i].subcodename + "</option>");
	            	}
	            	
	            }
	        });
		};
    	
		var jsonfile = new Array();
	    jsonfile = '${list}'
	    jsonfile = JSON.parse(jsonfile);
		
		var colorArray = new Array();

        for (let index = 0; index < 7; index++) {
			// 112 ~ 225
            var r = Math.floor(Math.random() * (255-112)) + 112; 
            var g = Math.floor(Math.random()  * (255-112)) + 112;
            var b = Math.floor(Math.random() * (255-112)) + 112;
            colorArray[index] = "rgba(" + r + "," + g + "," + b + ",0.7)";

            $("#data" + (index + 1)).css("backgroundColor", colorArray[index]);
            $("#value" + (index + 1)).html(jsonfile[index].first_data + ' 건');
        }
		
		const ctx = document.getElementById("myChart").getContext('2d');
		const myChart = new Chart(ctx, {
			
			type:'pie', 
			data:{
				labels:['과속', '중앙선 침범', '신호위반', '안전거리 미확보', '안전운전 의무 불이행', '보행자 보호의무 위반', '기타'],
				datasets:[{
					labels: '# Votes',
					data:[
						jsonfile[0].first_data,
						jsonfile[1].first_data,
						jsonfile[2].first_data,
						jsonfile[3].first_data,
						jsonfile[4].first_data,
						jsonfile[5].first_data,
						jsonfile[6].first_data,
					],
					backgroundColor:[
						colorArray[0],
						colorArray[1],
                        colorArray[2],
                        colorArray[3],
                        colorArray[4],
                        colorArray[5],
                        colorArray[6]
					],
					borderColor:[
						colorArray[0],
						colorArray[1],
                        colorArray[2],
                        colorArray[3],
                        colorArray[4],
                        colorArray[5],
                        colorArray[6]
					]
				}]
			},
			options:{
                maintainAspectRatio :false,//그래프의 비율 유지 
                plugins:{
                    legend: {
                        display: false
                    }
                }
            }
		});
		
		for (let index = 0; index < 4; index++) {

            var r = Math.floor(Math.random() * (255-112)) + 112;
            var g = Math.floor(Math.random() * (255-112)) + 112;
            var b = Math.floor(Math.random() * (255-112)) + 112;
            colorArray[index] = "rgba(" + r + "," + g + "," + b + ",0.7)";

            $("#data" + (index + 11)).css("backgroundColor", colorArray[index]);
            $("#value" + (index + 11)).html(jsonfile[index+7].second_data + ' 건');
        }
		
		const ctx2 = document.getElementById("myChart2").getContext('2d');
		const myChart2 = new Chart(ctx2, {
			
			type:'pie', 
			data:{
				labels:['차대사람', '차대차', '차량단독', '철길건널목'],
				datasets:[{
					labels: '# Votes',
					data:[
						jsonfile[7].second_data,
						jsonfile[8].second_data,
						jsonfile[9].second_data,
						jsonfile[10].second_data
					],
					backgroundColor:[
						colorArray[0],
						colorArray[1],
                        colorArray[2],
                        colorArray[3]
					],
					borderColor:[
						colorArray[0],
						colorArray[1],
                        colorArray[2],
                        colorArray[3]
					]
				}]
			},
			options:{
                maintainAspectRatio :false,//그래프의 비율 유지 
                plugins:{
                    legend: {
                        display: false
                    },
                },
                
            }
		});
	</script>
	
    
</body>
</html>