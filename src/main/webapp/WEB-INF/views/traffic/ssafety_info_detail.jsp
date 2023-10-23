<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/user/subway_safety_info_detail.css" />

</head>


<body>
	<div id="ttb">
		<div id="tto">
			<h1>지하철 안전정보</h1>
			<h4 style="color: gray;">지하철의 안전 관련 소식들과 유용한 정보들을 한곳에서 확인하세요.</h4>
		</div>
		<div>
			<table class="tg" style="width: 900px">
				<colgroup>
					<col style="width: 126px">
					<col style="width: 900px">
				</colgroup>
				<thead>
					<tr>
						<td class="tg-b3sw">제목</td>
						<td class="tg-0lax">${ssL.ssafety_title }</td>
					</tr>
				</thead>
				<tbody>
					
					<tr>
						<td class="tg-b3sw">작성일</td>
						<td class="tg-0lax">${ssL.ssafety_date }</td>
					</tr>
					
					<tr>
						<td class="tg-cyim" colspan="2"><textarea name="textarea"
								id="textarea" readonly="readonly">${ssL.ssafety_con }</textarea></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btt">
			
			<a href="ssafety_info"><input type="button" id="pl" value="목록" /></a>
		</div>
		<hr />
	</div>



</body>
</html>