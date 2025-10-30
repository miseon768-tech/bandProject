<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 혹시 남아있는 세션이 있다면 무효화
    session.invalidate();
%>
<html>
<head>
    <title>회원탈퇴 완료</title>
    <link rel="stylesheet" href="/css/css.css"/>

</head>
<body>
<%@ include file="/template/header.jspf"%>
<div class="deletemessage">
<div class="container">
    <h2>회원탈퇴가 정상적으로 처리되었습니다.</h2>
    <p>그동안 이용해 주셔서 감사합니다.</p>
    <button class="btn" onclick="location.href='/main/index.jsp'">메인페이지로 돌아가기</button>
</div>
</div>
</body>
</html>
