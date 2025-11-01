<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/article.css">
</head>
<body>

<%@ include file="/template/header.jspf" %>

<div class="wrap">
    <h2>${article.title}</h2>

    <div class="info">
        작성자: <strong>${article.writerId}</strong> |
        번호: ${article.no}
    </div>

    <div class="content">
        ${article.content}
    </div>

    <div class="btn-area">
        <a href="${pageContext.request.contextPath}/community" class="btn btn-list">목록으로</a>
        <a href="${pageContext.request.contextPath}/article/edit?no=${article.no}" class="btn btn-edit">수정</a>
        <a href="${pageContext.request.contextPath}/article/delete?no=${article.no}" class="btn btn-delete"
           onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
    </div>
</div>

</body>
</html>
