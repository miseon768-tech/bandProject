<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:35
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 / 회원가입</title>

    <style>
        /* ===== 색상 팔레트 ===== */
        :root {
            --white: #ffffff;
            --cream: #FFF7EA;
            --vanilla: #FFEDC1;
            --sunray: #FEB229;
            --maroon: #470102;
            --ink: #3b2423;
            --line: #FFE0A6;
        }

        html, body {
            height: 100%;
            margin: 0;
        }

        /* 버튼 컨테이너 가운데 정렬 */
        .btn-wrap {
            width: 320px;
            margin: 120px auto 0;
            display: flex;
            flex-direction: column;
            gap: 16px;
            text-align: center;
        }

        /* ===== 버튼 공통 ===== */
        .btn-wrap button {
            padding: 14px 36px;
            border: none;
            border-radius: 10px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.25s ease;
        }

        /* ===== 각 버튼 색상 ===== */
        .login-btn {
            background-color: var(--sunray);
            color: var(--maroon);
        }

        .signup-btn {
            background-color: var(--maroon);
            color: var(--cream);
        }

        .bandlist-btn {
            background-color: var(--ink);
            color: var(--vanilla);
        }

        /* ===== hover 효과 ===== */
        .btn-wrap button:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>

<body>
<%@ include file="/template/header.jspf" %>

<div class="btn-wrap">
    <!-- 로그인 여부에 따라 로그인/로그아웃 전환 -->
    <c:choose>
        <c:when test="${auth}">
            <button class="login-btn" onclick="location.href='/logout'">로그아웃</button>
        </c:when>
        <c:otherwise>
            <button class="login-btn" onclick="location.href='/login'">로그인</button>
        </c:otherwise>
    </c:choose>

    <button class="signup-btn" onclick="location.href='/signup'">회원가입</button>
    <button class="bandlist-btn" onclick="location.href='/band/list'">밴드리스트로 이동</button>
</div>
</body>
</html>
