<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글 삭제</title>
    <style>
        body {
            font-family: "맑은 고딕", serif; margin: 40px auto; width: 60%; text-align: center; }
        .btn { background: #dc3545; color: white; padding: 8px 15px; border: none; border-radius: 5px; }
        .btn:hover { background: #b52b37; }
    </style>
</head>
<body>
<h2>⚠️ 글 삭제 확인</h2>
<p>정말 이 글을 삭제하시겠습니까?</p>

<form action="${pageContext.request.contextPath}/article/delete" method="post">
    <input type="hidden" name="no" value="${param.no}">
    <button type="submit" class="btn">삭제하기</button>
    <a href="${pageContext.request.contextPath}/article/list" style="margin-left:10px;">취소</a>
</form>
</body>
</html>
