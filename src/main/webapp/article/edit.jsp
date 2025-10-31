<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>

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
