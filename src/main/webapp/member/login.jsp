<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:33
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:33
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath(); // 필요시 폼 action 등에 사용
%>
<html>
<head>
    <title>커뮤니티</title>

    <!-- JSP 버전: 내부에 스타일 포함 -->
    <style>
        /* === Color Tokens === */
        :root{
            --bg: #F2F3F7;          /* 라이트 그레이 */
            --card: #FFFFFF;        /* 화이트 */
            --border: #E7E8EC;      /* 카드 테두리 */
            --text: #444444;        /* 기본 텍스트 */
            --muted: #6F6F6F;       /* 보조 텍스트 */
            --lilac: #A79ECD;       /* 연보라 포인트 */
            --lilac-dark:#968AC9;   /* hover용 */
            --lilac-dim:#C8C3DC;    /* 비활성 */
            --input:#FAFAFC;        /* 인풋 배경 */
            --focus: rgba(167,158,205,.20);
        }

        /* 전체 배경/폰트 */
        html, body {
            height: 100%;
        }
        body {
            margin: 0;
            font-family: 'Segoe UI', system-ui, -apple-system, Roboto, "Noto Sans KR", Arial, sans-serif;
            background: var(--bg);
            color: var(--text);
        }

        /* 중앙 정렬 래퍼 */
        .signup-wrap {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100%;
            padding: 24px;
        }

        /* 카드 */
        .signup {
            width: 360px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 40px 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,.05);
        }

        /* 로고/헤더 */
        .signup a {
            display: inline-block;
            margin-bottom: 6px;
            font-size: 28px;
            font-weight: 700;
            text-decoration: none;
            color: var(--lilac);
            letter-spacing: .2px;
        }
        .text-center { text-align: center; }
        .text-gray { color: var(--muted); }
        .mt-1 { margin-top: 8px; }

        /* 라벨 */
        label small {
            font-size: 12px;
            color: #666;
        }

        /* 폼/인풋 */
        .signup-form { margin-top: 18px; }
        .input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #D3D3E5;
            border-radius: 8px;
            background: var(--input);
            outline: none;
            box-sizing: border-box;
            transition: border .2s, box-shadow .2s, background .2s;
        }
        .input:hover {
            background: #F6F6FB;
        }
        .input:focus {
            border-color: var(--lilac);
            box-shadow: 0 0 0 3px var(--focus);
            background: #FFFFFF;
        }

        /* 버튼 */
        .bt-submit {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            border: none;
            border-radius: 8px;
            background: #C8C8D2; /* 기본 = 연회색(중립) */
            color: #fff;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s, transform .15s, box-shadow .2s;
        }

        /* 비활성 */
        .bt-submit:disabled {
            background: #D6D6E0;   /* 더 옅은 회색 */
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }

        /* hover시 연보라색 */
        .bt-submit:not(:disabled):hover {
            background: var(--lilac);      /* 연보라 */
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,.08);
        }

        .bt-submit:disabled {
            background: var(--lilac-dim);
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }
        .bt-submit:not(:disabled):hover {
            background: var(--lilac-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,.08);
        }
        .bt-submit:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(0,0,0,.06);
        }

        /* 보조 링크 */
        .link {
            color: rgba(0,144,249, .8);
            text-decoration: none;
        }
        .link:hover { text-decoration: underline; }

        /* 체크박스 행 */
        .row-between {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 8px;
        }
        .text-small {
            font-size: 12px;
            color: #777; /* 살짝 연한 회색 */
            margin-top: 14px;
        }

        .link-small {
            font-size: 6.2px;
            color: var(--lilac);
            text-decoration: none;
        }
        .link-small:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
<div class="signup-wrap">
    <div class="signup">
        <a href="<%=ctx%>/">로고</a>
        <h2 class="text-center">밴드에 오신것을 환영합니다.</h2>
        <p class="text-center text-gray">
            다양한 취미들이 모여 하나의 즐거움이 되는 공간
        </p>

        <form class="signup-form" action="<%=ctx%>/login" method="post">
            <div>
                <label for="id"><small>아이디</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="id" id="id" onkeyup="updateButtonState()"/>
                </div>
            </div>

            <div>
                <label for="password"><small>비밀번호</small></label>
                <div class="mt-1">
                    <input type="password" class="input" name="password" id="password" onkeyup="updateButtonState()"/>
                </div>

                <div class="mt-1 row-between">
                    <label for="keepLogin"><small>로그인 상태 유지</small></label>
                    <input type="checkbox" name="keepLogin" id="keepLogin" onchange="keepLoginConfirm();"/>
                </div>

                <div>
                    <button id="loginBt" class="bt-submit" disabled>로그인</button>
                </div>
            </div>
        </form>

        <p class="text-center text-small">
            아직 회원이 아니신가요?
            <a class="link-small" href="<%=ctx%>/signup">회원가입</a>
        </p>
    </div>
</div>

<script>
    function keepLoginConfirm() {
        const box = document.getElementById("keepLogin");
        if (box.checked) {
            if (!window.confirm("공용 PC에서는 보안상의 문제가 발생할 수 있습니다. 계속하시겠습니까?")) {
                box.checked = false;
            }
        }
    }

    function updateButtonState() {
        const idValue = document.getElementById("id").value.trim();
        const passValue = document.getElementById("password").value.trim();
        document.getElementById("loginBt").disabled = !(idValue && passValue);
    }
</script>
</body>
</html>
