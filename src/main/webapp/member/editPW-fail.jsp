
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <title>비밀번호 변경</title>
    <style>
        /* ========== 팔레트 & 기본 ========== */
        :root{
            --white:#ffffff;
            --cream:#FFF7EA;
            --vanilla:#FFEDC1;
            --sunray:#FEB229;   /* 노란색 포인트 */
            --maroon:#470102;   /* 진한 레터링 */
            --ink:#3b2423;      /* 본문색 */
            --line:#FFE0A6;     /* 연한 보더 */
        }
        html, body{height:100%}
        body{
            margin:0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            color:var(--ink);
            background:linear-gradient(180deg, var(--cream) 0%, var(--vanilla) 100%);
        }

        /* ========== 레이아웃 ========== */
        .settings{
            max-width: 1080px;
            margin: 32px auto;
            padding: 0 16px;
            display: grid;
            grid-template-columns: 260px 1fr;   /* ← 기존 유지 */
            gap: 24px;
            justify-content: center;
        }
        /* ====== 좌측 네비 ====== */
        .settings-nav{
            background: var(--white);
            border:1px solid var(--line);
            border-radius: 16px;
            box-shadow:0 8px 22px rgba(71,1,2,0.06);
            position: sticky;
            top: 16px;
            height: fit-content;
        }
        .settings-nav h3{
            margin: 14px 16px 6px;
            font-size: 14px;
            letter-spacing: .2px;
            color: #7a5a58;
        }
        .nav-list{
            display:flex;
            flex-direction:column;
            padding: 6px;
        }
        .nav-item{
            display:flex;
            align-items:center;
            gap:10px;
            border-radius: 12px;
            padding: 10px 12px;
            cursor:pointer;
            color: var(--maroon);
            text-decoration:none;
            transition: background-color .15s ease, transform .05s ease;
        }
        .nav-item:hover{ background:#FFF9E9; } /* fallback hover */
        .nav-item.-active{
            background:#FFF1D8; /* active */
            border:1px solid var(--line);
        }
        .nav-dot{
            width:8px;height:8px;border-radius:50%;
            background: var(--sunray);
            flex:0 0 8px;
        }

        /* --- Right Content Card --- */
        .card{
            width: 420px;
            background: var(--white);
            border:1px solid var(--line);
            border-radius: 16px;
            box-shadow:0 8px 22px rgba(71,1,2,0.06);
            overflow: hidden;
            justify-self: center;
            margin-left: -150px;  /* ← 카드 약간 왼쪽으로 이동 (유지) */
        }
        .card-head{
            padding: 18px 22px;
            border-bottom:1px solid var(--line);
            display:flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            background: color-mix(in srgb, var(--cream) 60%, white);
        }
        .card-head .title{
            margin:0;
            color:var(--maroon);
            font-weight:900;
            letter-spacing:-.2px;
            font-size: 20px;
        }
        .card-desc{
            margin: 0;
            color:#7a5a58;
            font-size: 14px;
        }
        .card-body{
            padding: 24px;
        }

        /* --- 폼 공통 --- */
        .field{margin-bottom:16px;}
        label small{color:#7a5a58}
        .input{
            width:100%;
            box-sizing: border-box;
            padding: 12px 14px;
            border:1px solid var(--line);
            border-radius: 10px;
            background:#fff;
            font-size:14px;
            outline: none;
        }
        .input:focus{
            border-color: var(--sunray);
            box-shadow: 0 0 0 3px color-mix(in srgb, var(--sunray) 35%, transparent);
        }
        .bt-submit{
            width:100%;
            padding:12px 14px;
            border:1px solid var(--line);
            border-radius:12px;
            background: color-mix(in srgb, var(--sunray) 30%, white);
            color: var(--maroon);
            font-weight:700;
            cursor:pointer;
            transition: transform .05s ease, background .15s ease;
        }
        .bt-submit:hover{
            background-color:#FFD351; /* 선명한 진한 노란색 */
        }
        .bt-submit:active{
            transform: translateY(1px);
        }

        /* --- 에러 알럿 --- */
        .alert{
            padding:12px 14px;
            border-radius:10px;
            margin-bottom:16px;
            border:1px solid var(--line);
            font-size:14px;
        }
        .alert.-error{
            background: color-mix(in srgb, #FF5A5A 15%, white);
            color:#6b1616;
            border-color: color-mix(in srgb, #FF5A5A 35%, var(--line));
        }

        /* --- 반응형 --- */
        @media (max-width: 820px) {
            .settings { grid-template-columns: 1fr; }
            .card { margin-left: 0; } /* 모바일에서는 가운데 정렬 */
        }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<main class="settings">
    <!-- 왼쪽 네비 -->
    <aside class="settings-nav">
        <h3>설정</h3>
        <nav class="nav-list">
            <a class="nav-item" href="${pageContext.request.contextPath}/member/edit-profile">
                <span class="nav-dot" style="opacity:.3"></span> 프로필
            </a>
            <a class="nav-item -active" href="${pageContext.request.contextPath}/editPW">
                <span class="nav-dot"></span> 비밀번호 변경
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/account/delete">
                <span class="nav-dot" style="opacity:.3"></span> 계정 삭제
            </a>
        </nav>
    </aside>

    <!-- 오른쪽 컨텐츠 카드 -->
    <section class="card">
        <header class="card-head">
            <h2 class="title">비밀번호 변경</h2>
            <p class="card-desc">현재 비밀번호와 새 비밀번호를 입력하세요.</p>
        </header>

        <div class="card-body">
            <!-- ⬇ 실패 메시지 표시 영역 -->
            <c:if test="${not empty error}">
                <div class="alert -error">
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/editPW" method="post">
                <div class="field">
                    <label for="password"><small>현재 비밀번호</small></label>
                    <input type="password" class="input" name="password" id="password" required />
                </div>
                <div class="field">
                    <label for="newPassword"><small>신규 비밀번호</small></label>
                    <input type="password" class="input" name="newPassword" id="newPassword" required />
                </div>
                <div class="field">
                    <label for="newPasswordConfirm"><small>신규 비밀번호 확인</small></label>
                    <input type="password" class="input" name="newPasswordConfirm" id="newPasswordConfirm" required />
                </div>
                <button type="submit" class="bt-submit">비밀번호 변경</button>
            </form>
        </div>
    </section>
</main>
</body>
</html>
