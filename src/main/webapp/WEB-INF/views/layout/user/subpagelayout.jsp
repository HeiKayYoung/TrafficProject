<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html>
<head>

	<meta charset="UTF-8">
	<%-- <title>
		<tiles:insertAttribute name="title"/>
	</title> --%>
	
	<!-- webapp 폴더 -> resource 폴더 -> layout 폴더 -> tile_css 폴더 -> subpagestyle.css 파일 참조 -->
	<!-- <link rel="stylesheet" href="resources/layout/tile_css/subpagestyle.css" /> -->
	
</head>
<body>

		<style>
		
				#container{
							
				    width: 100%;
				    height: 100%;
				    margin: 0px auto;
				    text-align: center;
				    border: 0px solid #bcbcbc;
				    
				}
				 
				#header{
				    padding: 5px;
				    margin-bottom: 5px;
				    border: 0px solid #bcbcbc;
				}
				
				#sidebar-left{
					
				    width: 0px;
				    height: 700px; /* 肄섑뀗痢� 湲몄씠 */
				    margin: 50px 0 0 80px;
				    float: left;
				    background-color: white;
				    border: 0px solid #bcbcbc;
				    text-align: center;
				}
				 
				#content{
					width: 1200px;
					margin-left : 400px;
				    margin-top: 100px;
				    border: 0px solid #bcbcbc;
				    overflow: hidden;
				    text-align: left;
				}
				 
				#footer{
				    clear: both;
				    padding: 5px;
				    border: 0px solid #bcbcbc;
				}
		
		</style>

		<!-- 최상단 메뉴 -->
		<div id="container">
				<tiles:insertAttribute name="header"/>
		</div>
		
		<!-- 사이드 추가 -->
		<div id="sidebar-left">
				<tiles:insertAttribute name="side"/>
		</div>
		
		<!-- 내용 -->
		<div id="content">
				<tiles:insertAttribute name="content"/>
		</div>
		
		<!-- 하단 -->
		<%-- <div id="footer">
				<tiles:insertAttribute name="footer"/>
		</div>
	 --%>
</body>
</html>