<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴 완료</title>

    <style>
        :root {
            --white: #ffffff;
            --cream: #FFF7EA;
            --vanilla: #FFEDC1;
            --sunray: #FEB229;
            --maroon: #470102;
            --ink: #3b2423;
            --line: #FFE0A6;
        }

        body {
            margin: 0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            color: var(--ink);
            background: linear-gradient(180deg, var(--cream) 0%, var(--vanilla) 100%);
            text-align: center;
        }

        .container {
            max-width: 560px;
            margin: 120px auto;
            background: var(--white);
            border: 1px solid var(--line);
            border-radius: 16px;
            padding: 40px 32px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        h2 {
            color: var(--maroon);
            font-size: 24px;
            margin-bottom: 16px;
        }

        p {
            margin-bottom: 24px;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            background: var(--sunray);
            color: var(--maroon);
            font-weight: bold;
            text-decoration: none;
            transition: 0.2s;
        }

        .btn:hover {
            background: var(--vanilla);
        }
    </style>
</head>
<body>

<%@ include file="/template/header.jspf" %>

<main>
    <div class="container">
        <h2>회원 탈퇴가 완료되었습니다</h2>
        <p>
            그동안 이용해주셔서 감사합니다.<br>
            언제든 다시 찾아주시면 따뜻하게 맞이하겠습니다
        </p>

        <a href="${pageContext.request.contextPath}/index" class="btn">메인 페이지로 돌아가기</a>
    </div>
</main>

</body>
</html>
