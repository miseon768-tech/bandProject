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
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 80px;
        }
        .container {
            display: inline-block;
            border: 1px solid #ddd;
            padding: 40px 60px;
            border-radius: 10px;
            background-color: #f8f8f8;
        }
        .btn {
            margin-top: 20px;
            display: inline-block;
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            background-color: #d6d6d6;
            color: white;
            font-size: 14px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #757575;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>회원탈퇴가 정상적으로 처리되었습니다.</h2>
    <p>그동안 이용해 주셔서 감사합니다.</p>
    <button class="btn" onclick="location.href='/main/index.jsp'">메인페이지로 돌아가기</button>
</div>
</div>
</body>
</html>
