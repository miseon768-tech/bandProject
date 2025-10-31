<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
    <style>
        body {
            font-family: "맑은 고딕", serif; margin: 40px auto; width: 80%; }
        textarea, input { width: 100%; padding: 10px; margin-bottom: 15px; }
        button { background: #28a745; color: white; padding: 8px 15px; border: none; border-radius: 5px; }
        button:hover { background: #218838; }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf"%>
<h2>✏️ 글 수정</h2>

<form method="post" action="${pageContext.request.contextPath}/article/edit">
    <input type="hidden" name="no" value="${article.no}">
    <p><input type="text" name="title" value="${article.title}" required></p>
    <p><textarea name="content" rows="10" required>${article.content}</textarea></p>
    <button type="submit">수정 완료</button>
    <a href="${pageContext.request.contextPath}/article/list" style="margin-left:10px;">목록으로</a>
</form>
</body>
</html>
