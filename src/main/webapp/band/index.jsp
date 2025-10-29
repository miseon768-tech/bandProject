<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오후 2:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인</title>
    <link rel="stylesheet" href="/css/css.css"/>

    <style>

        /* 중앙 카드 버튼 */
        .card-btn {
            width: 330px;
            height: 330px;
            border: 3px solid #666;
            border-radius: 28px;
            background: #fafafa;
            text-decoration: none;
            color: #222;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            /* ★ hover 애니메이션 추가 */
            transition: transform 0.15s ease-out, box-shadow 0.2s ease-out;
        }

        /* ★ 마우스 올렸을 때 살짝 위로 + 그림자 강조 */
        .card-btn:hover {
            transform: translateY(-6px);
            box-shadow: 0 10px 24px rgba(0,0,0,0.12);
        }

        .card-title {
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            line-height: 1.4;
            margin-bottom: 20px;
        }

        .plus-wrap {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 3px solid #666;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 38px;
            font-weight: 700;
        }
    </style>
</head>

<body>

<main class="center">
    <a href="/band/create" class="card-btn">
        <div class="card-title">밴드<br>만들기</div>
        <div class="plus-wrap">+</div>
    </a>
</main>
</body>
</html>
