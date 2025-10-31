<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오후 2:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인</title>

    <link rel="stylesheet" href="/css/index.css"/>


</head>

<body>
<%@ include file="/template/header.jspf" %>


<main class="cards">

    <a href="${pageContext.request.contextPath}/band" class="card-btn" aria-label="밴드 생성하기">
        <div class="card-title">밴드<br>생성하기</div>
        <div class="icon-circle">+</div>
    </a>

    <a href="${pageContext.request.contextPath}/band/list" class="card-btn" aria-label="밴드 참여하기">
        <div class="card-title">밴드<br>참여하기</div>
        <div class="icon-circle">➔</div>
    </a>
</main>
</body>
</html>
