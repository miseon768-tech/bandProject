<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오후 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원탈퇴 실패</title>
    <link rel="stylesheet" href="/css/css.css">
</head>
<body>
<%@ include file="/template/header.jspf" %>
<div class="deletemessagefail">
<div class="container">
    <h2 class="msg">회원탈퇴에 실패하였습니다.</h2>
    <p>처리 중 오류가 발생했습니다.<br>잠시 후 다시 시도해 주세요.</p>
    <button class="btn" type="button" onclick="location.href='/setting/profile.jsp'">돌아가기</button>
</div>
</div>
</body>
</html>
</html>