<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>정보수정</title>
    <style>
        :root{
            --white:#ffffff;
            --cream:#FFF7EA;
            --vanilla:#FFEDC1;
            --sunray:#FEB229;   /* 노란색 */
            --pink:#FF7FA9;     /* 분홍색 */
            --maroon:#470102;
            --ink:#3b2423;
            --line:#FFE0A6;
        }

        /* ====== 안정성 기본 리셋 ====== */
        *{ box-sizing:border-box }
        html, body{ height:100% }
        body{
            margin:0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            color:var(--ink);
            /* fallback 배경 */
            background: linear-gradient(180deg, var(--cream) 0%, var(--vanilla) 100%);
        }
        button,input,select,textarea{
            font: inherit;
            color: inherit;
        }
        button{
            appearance:none; -webkit-appearance:none; border:0; background:none; cursor:pointer;
        }
        a{ color:inherit; }

        /* ====== 레이아웃 ====== */
        .settings{
            max-width: 1080px;
            margin: 32px auto 80px;
            padding: 0 20px;
            display:grid;
            grid-template-columns: 240px 1fr;
            gap: 20px;
        }
        @media (max-width: 900px){
            .settings{ grid-template-columns: 1fr; }
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
        /* fallback hover 배경 */
        .nav-item:hover{ background:#FFF9E9; } /* vanilla 35% + white 근사치 */

        /* active fallback 배경 */
        .nav-item.-active{
            background:#FFF1D8; /* sunray 18% + white 근사치 */
            border:1px solid var(--line);
        }
        .nav-dot{
            width:8px;height:8px;border-radius:50%;
            background: var(--sunray);
            flex:0 0 8px;
        }

        /* ====== 카드 ====== */
        .card{
            background: var(--white);
            border:1px solid var(--line);
            border-radius: 16px;
        }
        .card-head{
            padding: 18px 22px;
            border-bottom:1px solid var(--line);
            display:flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            /* fallback */
            background:#FFFAF2; /* cream 60% + white 근사치 */
            border-top-left-radius: 16px;
            border-top-right-radius: 16px;
        }
        .card-head .title{
            margin:0;
            color:var(--maroon);
            font-weight:800;
            letter-spacing:-.2px;
        }
        .card-desc{
            margin: 0;
            color:#7a5a58;
            font-size: 14px;
        }
        .card-body{ padding: 24px; }

        /* ====== 폼 ====== */
        .form-grid{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px 18px;
        }
        @media (max-width: 720px){
            .form-grid{ grid-template-columns: 1fr; }
        }

        .field{ display:flex; flex-direction:column; gap:8px; }
        .label{ font-weight:800; color:var(--maroon); }
        .input{
            width:100%;
            padding: 12px 14px;
            border:1px solid var(--line);
            border-radius: 12px;
            background: #fff;
            transition: box-shadow .16s ease, border-color .16s ease, background-color .16s ease;
            font-size: 15px;
        }
        .input:hover{ border-color: var(--sunray); }
        .input:focus{
            outline:none;
            border-color: var(--sunray);
            background: #fff;
        }
        .hint{ color:#7a5a58; font-size: 12.5px; }

        /* ====== 액션 바 ====== */
        .actions{
            display:flex;
            gap:10px;
            justify-content:flex-end;
            padding: 16px 22px;
            border-top:1px solid var(--line);
            /* fallback */
            background:#FFFBF3; /* cream 55% + white 근사치 */
            border-bottom-left-radius: 16px;
            border-bottom-right-radius: 16px;
        }

        /* ====== 버튼 ====== */
        .btn{
            padding:11px 18px;
            border:none;
            border-radius:12px;
            font-weight:900;
            cursor:pointer;
            transition: transform .06s ease, box-shadow .16s ease, background-color .16s ease;
        }

        /* 저장 = 분홍 */
        .btn.-pink{
            background: lightpink; /* fallback */
            color: #fff;
        }
        .btn.-pink:hover{
            background: var(--pink);
            transform: translateY(-1px);
            box-shadow:0 10px 24px rgba(255,127,169,0.35);
        }

        /* 돌아가기 = 노랑 */
        .btn.-yellow{
            background: var(--vanilla); /* fallback */
            color:#3a1c00;
        }
        .btn.-yellow:hover{
            background:var(--sunray);
            transform: translateY(-1px);
            box-shadow:0 10px 24px rgba(254,178,41,0.32);
        }

        .section-label{
            margin: 4px 0 12px;
            font-size:12px;
            letter-spacing:.6px;
            color:#7a5a58;
            text-transform: uppercase;
            font-weight: 800;
        }

        /* ====== color-mix 지원 시 향상 처리 ====== */
        @supports (background: color-mix(in srgb, white, black)){
            .nav-item:hover{
                background: color-mix(in srgb, var(--vanilla) 35%, white);
            }
            .nav-item.-active{
                background: color-mix(in srgb, var(--sunray) 18%, white);
            }
            .card-head{
                background: color-mix(in srgb, var(--cream) 60%, white);
            }
            .actions{
                background: color-mix(in srgb, var(--cream) 55%, white);
            }
        }
    </style>
</head>
<body>

<c:if test="${empty sessionScope.logonUser}">
    <c:redirect url="${pageContext.request.contextPath}/login"/>
</c:if>

<%@ include file="/template/header.jspf" %>

<div class="settings">
    <!-- 왼쪽 -->
    <aside class="settings-nav">
        <h3>설정</h3>
        <nav class="nav-list">
            <a class="nav-item -active" href="${pageContext.request.contextPath}/member/editprofile">
                <span class="nav-dot"></span> 프로필
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/editPW">
                <span class="nav-dot" style="opacity:.3"></span> 비밀번호 변경
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/account/delete">
                <span class="nav-dot" style="opacity:.3"></span> 계정 삭제
            </a>
        </nav>
    </aside>

    <!-- 오른쪽 -->
    <section class="card">
        <header class="card-head">
            <div>
                <h2 class="title">프로필 설정</h2>
                <p class="card-desc">공개 프로필과 연락 정보를 관리하세요.</p>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/member/editprofile">
                <button class="btn -pink" type="submit">저장</button>
            </form>
        </header>

        <form class="card-body" method="post" action="${pageContext.request.contextPath}/member/editprofile">
            <div class="section-label">기본 정보</div>

            <div class="form-grid">
                <div class="field">
                    <label class="label" for="nickname">닉네임</label>
                    <input class="input" id="nickname" name="nickname" type="text"
                           value="<c:out value='${sessionScope.logonUser.nickname}' default=''/>" required>
                    <small class="hint">서비스에서 표시되는 이름입니다.</small>
                </div>

                <div class="field">
                    <label class="label" for="name">이름</label>
                    <input class="input" id="name" name="name" type="text"
                           value="<c:out value='${sessionScope.logonUser.name}' default=''/>" required>
                </div>

                <div class="field" style="grid-column: 1 / -1">
                    <label class="label" for="email">이메일</label>
                    <input class="input" id="email" name="email" type="email"
                           value="<c:out value='${sessionScope.logonUser.email}' default=''/>" required>
                    <small class="hint">로그인/알림에 사용될 이메일입니다.</small>
                </div>

                <div class="field" style="grid-column: 1 / -1">
                    <label class="label" for="interest">관심사</label>
                    <input class="input" id="interest" name="interest" type="text"
                           value="<c:out value='${sessionScope.logonUser.interest}' default=''/>">
                    <small class="hint">쉼표(,)로 여러 개 입력 가능 예) 음악, 여행, 게임</small>
                </div>
            </div>

            <div class="actions">
                <button class="btn -pink" type="submit">저장</button>
                <button class="btn -yellow" type="button"
                        onclick="location.href='${pageContext.request.contextPath}/band/index'">돌아가기</button>
            </div>
        </form>
    </section>
</div>
</body>
</html>
