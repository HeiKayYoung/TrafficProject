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

        #form, #header_menu{
            width: 1200px;
        }
        #header_menu{
        	text-align: center;
        	font-size: 25px;
        	background: #42444e;
        	color: white;
        	border-collapse: collapse;
        	border: 1px solid black;
        }
        #header_menu tr td{
        	border-collapse: collapse;
        	border: 1px solid black;
        	cursor: pointer;
        }
		#datalist{
			list-style: none;
            margin: 0px;
        }
        #container{
        	margin: 0px;
        	padding: 0px;
        }
		#datalist li{
			float: left;
            margin: 0px;
            padding-right: 100px;
		}
		#first_table {
		  	border-collapse: separate;
		  	border-spacing: 0;
		  	width: 100%;
		}
		#first_table tr th, #first_table tr td {
		  	padding: 6px 15px;
		}
		#first_table tr th {
		  	background: #42444e;
		  	color: #fff;
		}
		#first_table tr:first-child th:first-child {
		  	border-top-left-radius: 6px;
		}
		#first_table tr:first-child th:last-child {
		  	border-top-right-radius: 6px;
		}
		#first_table tr td {
		  	border-right: 1px solid #c6c9cc;
		  	border-bottom: 1px solid #c6c9cc;
		}
		#first_table tr td:first-child {
		  	border-left: 1px solid #c6c9cc;
		}
		#first_table tr:nth-child(even) td {
		  	background: #eaeaed;
		}
		#first_table tr:last-child td:first-child {
		  	border-bottom-left-radius: 6px;
		}
		#first_table tr:last-child td:last-child {
		  	border-bottom-right-radius: 6px;
		}
        .top_col{
        	text-align: center;
        	font-weight: normal;
        	font-size: 20px;
        	height: 40px;
        }
        .field{
        	text-align: center;
        }
        .data{
        	text-align: right;
        	padding-right: 10px;
        }
        
        @font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		#searchYearCd, #searchAgeCd, #sido, #gugun, .button {
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
		function topmenu_click(gubun){
			
			if(gubun == 'year'){
				location.replace("caraccident_percnt?searchType=year&searchYearCd=2022")
			}
			else{
				location.replace("caraccident_percnt?searchType=age&searchAgeCd=12세이하")
			}
		}
		
		function year_search(){
			var searchYearCd = document.getElementById("searchYearCd").value;
			location.replace("caraccident_percnt?searchType=year&searchYearCd=" + searchYearCd);
		}
	
		function age_search(){
			var searchAgeCd = document.getElementById("searchAgeCd").value;
			location.replace("caraccident_percnt?searchType=age&searchAgeCd=" + searchAgeCd);
		}
		
	</script>
	
    <div id="form">
        <h1>최근 6개년 교통사고 부상자 / 사상자 / 사망자 수 조회</h1>
        <br />
        <div>
        	<table id="header_menu">
        		<tr>
        			<c:if test="${searchType != 'year'}">
        				<td style="background: gray" onclick="topmenu_click('year')">연도별 조회</td>
        			</c:if>
        			<c:if test="${searchType == 'year'}">
        				<td onclick="topmenu_click('year')">연도별 조회</td>
        			</c:if>
        			<c:if test="${searchType != 'age'}">
        				<td style="background: gray" onclick="topmenu_click('age')">나이별 조회</td>
        			</c:if>
        			<c:if test="${searchType == 'age'}">
        				<td onclick="topmenu_click('age')">나이별 조회</td>
        			</c:if>
        		</tr>
        	</table>
        </div>
       	 	<br />
       	 	<c:if test="${searchType == 'year'}">
       	 		<div>
	     			<br />
	     				<div>
	     					<span>
			            		<select name="searchYearCd" id="searchYearCd">
			                    	<c:forEach items="${searchYear}" var="li">
			                    		<c:if test="${ searchYearCd == li.year }">
			                        		<option value="${li.year}" selected>${li.year}</option>
			                        	</c:if>
										<c:if test="${ searchYearCd != li.year }">
			                        		<option value="${li.year}">${li.year}</option>
			                        	</c:if>
			                    	</c:forEach>
			                    </select>
			            	</span>
			            	<span>
			                    <input type="button" class="button" value="검색" onclick="year_search()">
			                </span>
	     				</div>
	     				<br />
	     				<div>
	     					<table id="first_table">
	     						<tr>
				        			<th class="top_col">연령별</th>
				        			<th class="top_col">부상자수</th>
				        			<th class="top_col">사상자수</th>
				        			<th class="top_col">사망자수</th>
				        		</tr>
	     						<c:forEach items="${firstList}" var="li">
	     							<tr>
				        				<td class="field">${li.age}</td>
				        				<td class="data" style="color: green;">${li.injured_cnt}</td>
				        				<td class="data" style="color: blue;">${li.casualties_cnt}</td>
				        				<td class="data" style="color: red;">${li.dead_cnt}</td>
				        			</tr>
	     						</c:forEach>
			        		</table>
	     				</div>
	        	</div>
       	 	</c:if>
       	 	<c:if test="${searchType == 'age'}">
       	 		<div>
	     			<br />
	     				<div>
	     					<span>
			            		<select name="searchAgeCd" id="searchAgeCd">
			                    	<c:forEach items="${searchAge}" var="li">
			                    		<c:if test="${ searchAgeCd == li.age }">
			                        		<option value="${li.age}" selected>${li.age}</option>
			                        	</c:if>
										<c:if test="${ searchAgeCd != li.age }">
			                        		<option value="${li.age}">${li.age}</option>
			                        	</c:if>
			                    	</c:forEach>
			                    </select>
			            	</span>
			            	<span>
			                    <input type="button" class="button" value="검색" onclick="age_search()">
			                </span>
	     				</div>
	     				<br />
	     				<div>
	     					<table id="first_table">
	     						<tr>
				        			<th class="top_col">연령별</th>
				        			<th class="top_col">부상자수</th>
				        			<th class="top_col">사상자수</th>
				        			<th class="top_col">사망자수</th>
				        		</tr>
	     						<c:forEach items="${secondList}" var="li">
	     							<tr>
				        				<td class="field">${li.year}</td>
				        				<td class="data" style="color: green;">${li.injured_cnt}</td>
				        				<td class="data" style="color: blue;">${li.casualties_cnt}</td>
				        				<td class="data" style="color: red;">${li.dead_cnt}</td>
				        			</tr>
	     						</c:forEach>
			        		</table>
	     				</div>
	        	</div>
       	 	</c:if>
		</div>
    
</body>
</html>