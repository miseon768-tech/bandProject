<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴</title>
    <style>
        /* ========== 팔레트 & 기본 ========== */
        :root{
            --white:#ffffff;
            --cream:#FFF7EA;
            --vanilla:#FFEDC1;
            --sunray:#FEB229;
            --maroon:#470102;
            --ink:#3b2423;
            --line:#FFE0A6;
            --danger:#c80000;   /* 🔴 추가: hover 시 사용할 빨강 */
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
            grid-template-columns: 260px 1fr;
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
        .nav-item:hover{ background:#FFF9E9; }
        .nav-item.-active{
            background:#FFF1D8;
            border:1px solid var(--line);
        }
        .nav-dot{
            width:8px;height:8px;border-radius:50%;
            background: var(--sunray);
            flex:0 0 8px;
        }

        /* --- Right Content Card --- */
        .card{
            width: 500px;
            background: var(--white);
            border:1px solid var(--line);
            border-radius: 16px;
            box-shadow:0 8px 22px rgba(71,1,2,0.06);
            overflow: hidden;
            justify-self: center;
            margin-left: -150px;
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
        .card-body{padding: 24px;}
        .card-desc{
            margin:0;
            color:#7a5a58;
            font-size:14px;
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
            outline:none;
        }
        .input:focus{
            border-color: var(--sunray);
            box-shadow: 0 0 0 3px color-mix(in srgb, var(--sunray) 35%, transparent);
        }

        /* --- 버튼 --- */
        .btn{
            display:inline-block;
            text-align:center;
            padding:12px 14px;
            border:1px solid var(--line);
            border-radius:12px;
            background: color-mix(in srgb, var(--sunray) 30%, white);
            color: var(--maroon);
            font-weight:700;
            cursor:pointer;
            text-decoration:none;
            transition: background .15s ease, transform .05s ease, color .15s ease;
        }
        .btn:hover{ background:#FFD351; }
        .btn:active{ transform:translateY(1px); }

        /* 기본 탈퇴 버튼 스타일 */
        .btn.-danger{
            background:#ffcc73;
            color:var(--maroon);
        }

        /* 탈퇴 버튼 hover 시 빨강으로 변경 */
        .btn.-danger:hover{
            background: var(--danger);
            color: #fff;
            border-color: #a00000;
            box-shadow: 0 0 0 3px rgba(200,0,0,0.15);
            transform: translateY(-1px);
            transition: all 0.2s ease;
        }

        @media (max-width: 820px){
            .settings{
                grid-template-columns: 1fr;
            }
            .card{ margin:0 auto; width:100%; }
        }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="settings">
    <aside class="settings-nav">
        <h3>설정</h3>
        <nav class="nav-list">
            <a class="nav-item" href="${pageContext.request.contextPath}/member/edit-profile">
                <span class="nav-dot" style="opacity:.3"></span> 프로필
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/editPW">
                <span class="nav-dot" style="opacity:.3"></span> 비밀번호 변경
            </a>
            <a class="nav-item -active" href="${pageContext.request.contextPath}/account/delete">
                <span class="nav-dot"></span> 계정 삭제
            </a>
        </nav>
    </aside>

    <main>
        <div class="card">
            <div class="card-head">
                <h2 class="title">회원 탈퇴</h2>
            </div>
            <div class="card-body">
                <p style="margin-bottom:24px;">
                    탈퇴하시면 계정과 관련된 데이터가 삭제됩니다. 진행하시겠습니까?
                </p>

                <form method="post" action="${pageContext.request.contextPath}/account/delete" id="deleteForm">
                    <div class="field">
                        <label for="password">비밀번호 확인</label>
                        <input class="input" id="password" name="password" type="password" placeholder="비밀번호 입력" required>
                    </div>

                    <div style="margin-bottom:16px;">
                        <label style="user-select:none;">
                            <input type="checkbox" id="agreeChk" required>
                            (필수) 탈퇴 시 계정이 삭제됨을 이해했습니다.
                        </label>
                    </div>

                    <div style="display:flex; gap:8px;">
                        <button type="submit" class="btn -danger">탈퇴하기</button>
                        <a href="${pageContext.request.contextPath}/index" class="btn">취소하고 메인으로</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<script>
    // 중복 제출 방지
    document.getElementById('deleteForm').addEventListener('submit', function(e){
        const btns = this.querySelectorAll('button, a');
        btns.forEach(el => el.disabled = true);
    });
</script>
</body>
</html>
