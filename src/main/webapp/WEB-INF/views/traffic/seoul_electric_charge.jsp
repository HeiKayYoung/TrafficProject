<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body>
	
	<style>
	
		#content{
			height: auto;
			width: 1200px;
			margin-left: auto;
			margin-right: auto;
		}
		
		table {
			padding: 5px;
			width: 1200px;
			height: auto;
			font-size: 14px;
			border-bottom: 1px solid #f3f3f3;
			margin-top: 10px;
			text-align: center;
			margin-left: auto;
			margin-right: auto;
		}
		tr:first-child {
			height: 90px;
			font-size: 20px;
			font-style: bold;
			background-color: #f5f5f5;
			border-top-color: black;
			color: #525252;
		}
		
		td {
			border-right: 1px solid black;
			border-bottom: 1px solid grey;
			padding-top: 5px;
			padding-bottom: 5px;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		
		td:last-child {
			border-right-style: none;
		}
		
		.title {
			margin-top: 5px;
			margin-bottom: 5px;
			font-size: 28px;
			text-align: center;
		}
		
		#paging {
			text-align: center;
			margin-bottom: 5px;
			font-size: 18px;
		}
		
		#search {
			text-align: center;
		}
		hr {
			margin: 0 0 0 0;
			width: 1200px;
		}
		#searchForm {
	        padding: 10px; 
	        border-radius: 5px;
	    }
	
	    #searchType {
	        margin-right: 10px; 
	        padding: 5px;
	    }
	
	    #keyword {
	        padding: 5px; 
	    }
	
	    #searchbtn {
	        background-color: #f5f5f5;
	        color: #525252;
	        border: 1px solid grey; 
	        padding: 5px 10px; 
	        border-radius: 5px; 
	    }
	    a {
	    	text-decoration: none;
	    }
	    a:hover {
	    	text-decoration: underline;
	    }
	    #list-box table {
	    	margin-top: 10px;
	    	margin-bottom: 10px;
	    	width: 1200px;
	    	height: 20px;
	    }
	    #list-box table td {
	    	border: 1px solid grey;
	    }
	    #list-box table td a{
	    	text-decoration: none;
	    	cursor: pointer;
	    }
	    #list-box table td a:hover{
	    	text-decoration: underline;
	    }
	    tr:first-child {
			font-size: 20px;
			font-style: bold;
			background-color: #f5f5f5;
			border-top-color: black;
			color: #525252;
		}
	    td {
			padding-top: 15px;
			padding-bottom: 15px;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		#search_nothing {
	    	font-size: 20px;
	    	text-align: center;
	    	height: auto;
	    }
	</style>
	
	<script>
		document.getElementById("searchForm").addEventListener("submit", function(event) {
		    event.preventDefault();
	
		    var searchType = document.getElementById("searchType").value;
		    var keyword = document.getElementById("keyword").value;
	
		    sendToService(searchType, keyword);
		});
	</script>

	<div style="text-align: center;">
		<hr />
 			<div class="title">서울시 전기차 충전소</div>
 		<hr />	
	</div>
 	
 	<div id="list-box">
		<table>
			<tr>
				<td><a href="parking">서울시 공영주차장</a></td>
				<td><a href="electric_charge">서울시 전기차 충전소</a></td>
			</tr>
		</table>
	</div>
	
	    <div style="color : gray; text-align: right;">
	        전체 페이지 : ${vo.totPage } / 현재 페이지 : ${vo.page } <br />
	        * 본 게시판은 서울시에서 운영하는 충전소만 조회된 결과입니다.
	    </div>
	
 		<table>
	 		<tr>
				<td>시설구분</td>
				<td>충전소</td>
				<td>충전기 갯수</td>
				<td>충전기 타입</td>
				<td>충전 용량</td>
				<td>이용가능 시간</td>
	 		</tr>
		 	
		 	<c:if test="${not empty ec_charge }">
		 		<c:forEach items="${ec_charge }" var="ec">
			 		<input type="hidden" name="title" value="${ec.ec_charge }" />
			 		<tr>
						<td>${ec.ec_charge_parking }</td>
						<td style="text-align: left;"><a href="ec_view?title=${ec.ec_charge}">${ec.ec_charge }</a></td>
						<td>${ec.ec_charge_id }개</td>
						<td>${ec.ec_charge_type }</td>
						<td>${ec.ec_kw }</td>
						<td>${ec.ec_time }</td>
			 		</tr>
		 		</c:forEach>
		 	</c:if>	
		 	
		 	<c:if test="${empty ec_charge }">
		 		<tr>
		 			<td colspan="6" id="search_nothing">검색 결과가 없습니다.</td>
		 		</tr>
		 	</c:if>
	 	</table>
	 	
	 	<div id="paging">
       		<c:if test="${vo.page>1}">
				<a href="electric_charge?page=1&searchType=${searchType }&keyword=${keyword}"><i class="fa-solid fa-angles-left"></i></a>
				<a href="electric_charge?page=${vo.page-1 }&searchType=${searchType }&keyword=${keyword}"><i class="fa-solid fa-circle-chevron-left"></i></a>
			</c:if>
				
			<c:forEach begin="${vo.pageStart}" end="${vo.pageEnd }" var="i">
				<c:choose>
					<c:when test="${i ne param.page}">
						<a href="electric_charge?page=${i}&searchType=${searchType }&keyword=${keyword}">${i}</a>
					</c:when>
					<c:otherwise>
						<span>${i}</span>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${vo.page < vo.totPage }">
				<a href="electric_charge?page=${vo.page+1 }&searchType=${searchType }&keyword=${keyword}"><i class="fa-solid fa-circle-chevron-right"></i></a>
				<a href="electric_charge?page=${vo.totPage }&searchType=${searchType }&keyword=${keyword}"><i class="fa-solid fa-angles-right"></i></a>
			</c:if>
       	</div>
	 	
	 	<form action="electric_charge" id="searchForm">
	 		<input type="hidden" name="page" value="1" />
		 		<div id="search">
			 		<c:choose>
			 			<c:when test="${empty searchType }">
			 				<select name="searchType" id="searchType">
						 		<option value="1" selected>주소</option>
						 		<option value="2">시설구분</option>
						 	</select>
			 			</c:when>
			 			<c:when test="${searchType eq 1}">
			 				<select name="searchType" id="searchType">
						 		<option value="1" selected>주소</option>
						 		<option value="2">시설구분</option>
						 	</select>
			 			</c:when>
			 			<c:otherwise>
			 				<select name="searchType" id="searchType">
						 		<option value="1">주소</option>
						 		<option value="2" selected>시설구분</option>
						 	</select>
			 			</c:otherwise>
			 		</c:choose>
			 		
			 		<c:choose>
			 			<c:when test="${keyword ne ''}">
			 				<input type="text" name="keyword" id="keyword" value="${keyword }" autocomplete=off;/>
			 			</c:when>
			 			<c:otherwise>
			 				<input type="text" name="keyword" id="keyword"/>
			 			</c:otherwise>
			 		</c:choose>
			 		
				 	<button type="submit" id="searchbtn">검색</button>
		 		</div>
	 	</form>
	 	
</body>
</html>
 