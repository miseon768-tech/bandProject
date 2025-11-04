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
    <style>
        :root {
            --white: #ffffff;
            --cream: #fff7ea;
            --vanilla: #ffedc1;
            --sunray: #feb229;
            --maroon: #470102;
            --ink: #3b2423;
        }

        /* 기본 설정 */
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: "맑은 고딕", system-ui, sans-serif;
            background: linear-gradient(180deg, var(--cream), var(--vanilla));
            color: var(--ink);
        }

        /* 메인 카드 배치 */
        .cards {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 48px;
            min-height: 80vh;
            flex-wrap: wrap;
        }

        /* 카드 버튼 공통 스타일 */
        .card-btn {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-decoration: none;
            background: var(--white);
            border: 2px solid var(--line, #ffe0a6);
            border-radius: 20px;
            box-shadow: 0 6px 18px rgba(71, 1, 2, 0.15);
            width: 220px;
            height: 220px;
            transition: all 0.25s ease;
            color: var(--maroon);
            text-align: center;
            position: relative;
        }

        /* 카드 타이틀 */
        .card-title {
            font-size: 1.4rem;
            font-weight: 600;
            line-height: 1.4;
            margin-bottom: 12px;
        }

        /* 아이콘 원형 */
        .icon-circle {
            width: 60px;
            height: 60px;
            background: var(--sunray);
            color: var(--white);
            font-size: 2rem;
            font-weight: bold;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 8px rgba(71, 1, 2, 0.2);
            transition: all 0.3s ease;
        }

        /* Hover 효과 */

        .card-btn:hover {
            transform: translateY(-4px); /* 살짝만 위로 */
            box-shadow: 0 8px 16px rgba(71, 1, 2, 0.18); /* 부드럽게 */
        }

        .card-btn:hover .icon-circle {
            background: var(--maroon);
            color: var(--vanilla);
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(71, 1, 2, 0.25);
        }


    </style>


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
