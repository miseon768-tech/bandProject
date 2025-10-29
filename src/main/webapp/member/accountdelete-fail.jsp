<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오후 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>회원탈퇴 실패</title>
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
            background-color: #fff5f5; /* 실패 느낌 살짝 연분홍 */
        }
        .msg {
            color: #d9534f;
            font-weight: bold;
        }
        .btn {
            margin-top: 20px;
            display: inline-block;
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            background-color: #e3e3e3;
            color: white;
            font-size: 14px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #a6a6a6;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="msg">회원탈퇴에 실패하였습니다.</h2>
    <p>처리 중 오류가 발생했습니다.<br>잠시 후 다시 시도해 주세요.</p>
    <button class="btn-back" onclick="location.href='/member/editProfile.jsp'">돌아가기</button>
</div>
</body>
</html>