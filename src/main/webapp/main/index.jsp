<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>

    <title>로그인 / 회원가입</title>
    <link rel="stylesheet" href="/css/css.css"/>

</head>

<body>
<%@ include file="/template/header.jspf"%>
<div class="btn-wrap">
    <button class="login-btn" onclick="location.href='/login'">로그인</button>
    <button class="signup-btn" onclick="location.href='/signup'">회원가입</button>
</div>
</body>
</html>
