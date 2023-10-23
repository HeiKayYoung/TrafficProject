<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/user/notice/style.css" />
<style>
#update {
	display: inline-block;
    min-width: 100px;
    padding: 10px;
    border: 1px solid black;
    border-radius: 2px;
    background: black;
    color: #fff;
    font-size: 20px;
}

#update:hover {
	color: gray;
}

a:hover {
	color: orange; 
}
</style>

</head>
<body>
<form action="n_review_update">
 <div class="board_wrap">
        <div class="board_title">
            <strong>후기 수정</strong>
        </div>
    </div>
    <div class="board_write_wrap">
        <div class="board_write">
        <input type="hidden" name="n_no" id="n_no" value="${n_review_content.n_no }" />
           <div class="title">
                <dl>
                    <dt>제목</dt>
                    <dd><input type="text" id="n_title" name="n_title"autocomplete="off" value="${n_review_content.n_title }"></dd>
                </dl>
           </div>
            <div class="cont">
                <textarea id="n_content" name="n_content">${n_review_content.n_content }</textarea>
            </div>
        </div>
        <div class="bt_wrap">
        	<input type="submit" value="수정하기" id="update"/>
            <a href="n_review_list">취소</a>
        </div>
    </div>
</form>
</body>
</html>