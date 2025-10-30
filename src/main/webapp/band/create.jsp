<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밴드 생성</title>
    <style>
        :root{
            --bg:#f6f6f7;
            --card:#ffffff;
            --ink:#2b2b2b;
            --muted:#8d8d92;
            --line:#dcdce1;
            --accent:#6b63ff;
            --accent-dark:#5149ff;
        }
        *{box-sizing:border-box}
        body{
            font-family: "맑은 고딕", system-ui, -apple-system, Segoe UI, Roboto, sans-serif;
            background: var(--bg);
            margin: 0;
            padding: 48px 16px;
            color: var(--ink);
        }
        .wrap{
            max-width: 720px;
            margin: 0 auto;
        }
        h2{
            text-align:center;
            margin: 0 0 22px;
            font-weight: 800;
            letter-spacing: -.2px;
        }
        .card{
            background: var(--card);
            border-radius: 22px;
            padding: 28px;
            box-shadow: 0 8px 28px rgba(0,0,0,.06);
            border: 1px solid var(--line);
        }

        .field{ margin-bottom: 18px; }
        .label{
            display:block;
            font-weight: 800;
            margin: 6px 2px 8px;
        }
        .hint{
            display:block;
            color: var(--muted);
            font-size: 12px;
            margin-top: 6px;
        }

        .input, .textarea{
            width: 100%;
            border: 1.5px solid var(--line);
            border-radius: 12px;
            background: #fff;
            padding: 12px 14px;
            font-size: 15px;
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }
        .input:focus, .textarea:focus{
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(107,99,255,.12);
        }
        .textarea{
            min-height: 140px;
            resize: vertical;
        }
        .row{
            display:flex; gap: 14px; align-items:center; flex-wrap:wrap;
        }
        .radios{
            display:flex; gap:22px; align-items:center; padding: 10px 0 2px;
        }
        .radio{
            display:inline-flex; gap:10px; align-items:center; cursor:pointer;
        }
        .radio input{ accent-color: var(--accent); width:18px; height:18px; }

        .actions{
            display:flex; justify-content:space-between; align-items:center; margin-top: 8px;
        }
        .btn{
            border: 1.5px solid var(--line);
            background:#fff;
            color: var(--ink);
            border-radius: 14px;
            padding: 12px 18px;
            font-weight: 700;
            cursor:pointer;
            transition: transform .08s ease, box-shadow .12s ease, border-color .12s ease;
        }
        .btn:hover{ box-shadow: 0 6px 16px rgba(0,0,0,.08); }
        .btn:active{ transform: translateY(1px); }

        .btn-primary{
            background: var(--accent);
            color:#fff;
            border-color: var(--accent);
            padding: 12px 24px;
        }
        .btn-primary:hover{ background: var(--accent-dark); border-color: var(--accent-dark); }

        .msg{ text-align:center; color:#14863d; margin-top:16px; font-weight:700; }
        .error{ text-align:center; color:#c02626; margin-top:16px; font-weight:700; }

        /* 작은 화면 */
        @media (max-width: 540px){
            .card{ padding:20px; border-radius:18px; }
        }
    </style>
</head>
<body>
<div class="wrap">
    <h2>🎵 새 밴드 만들기</h2>

    <form class="card" method="post" action="${pageContext.request.contextPath}/band/create" id="bandForm">
        <!-- 밴드 이름 -->
        <div class="field">
            <label class="label" for="name">밴드이름</label>
            <input class="input" id="name" name="name" type="text"
                   placeholder="밴드 이름 입력" maxlength="50" required>
            <small class="hint">최대 50자 • 중복 이름은 피해주세요.</small>
        </div>

        <!-- 밴드 마스터 닉네임 -->
        <div class="field">
            <label class="label" for="masterNickname">밴드 마스터 닉네임</label>
            <input class="input" id="masterNickname" name="masterNickname" type="text"
                   placeholder="닉네임 입력"
                   value="<c:out value='${adminNickname != null ? adminNickname : (admin != null ? admin.nickname : "")}'/>"
                   required>
            <small class="hint">생성자의 표시 이름이에요. 필요하면 수정해도 돼요.</small>
        </div>

        <!-- 설명 -->
        <div class="field">
            <label class="label" for="description">생성하는 밴드를 설명해주세요</label>
            <textarea class="textarea" id="description" name="description"
                      placeholder="밴드를 설명해 주세요"></textarea>
        </div>

        <!-- 공개/비공개 -->
        <div class="field">
            <span class="label">밴드 공개/비공개 설정</span>
            <div class="radios">
                <label class="radio">
                    <input type="radio" name="visibility" value="PUBLIC" checked>
                    <span>공개</span>
                </label>
                <label class="radio">
                    <input type="radio" name="visibility" value="PRIVATE">
                    <span>비공개</span>
                </label>
            </div>
            <small class="hint">공개: 누구나 검색/가입 요청 가능 • 비공개: 초대만 가입</small>
        </div>

        <!-- 버튼 -->
        <div class="actions">
            <button type="button" class="btn" onclick="history.back()">이전</button>
            <button type="submit" class="btn btn-primary">생성하기</button>
        </div>

        <!-- 생성 결과 메시지 -->
        <c:if test="${not empty success}">
            <p class="msg">✅ <c:out value="${success}"/></p>
        </c:if>
        <c:if test="${not empty error}">
            <p class="error">⚠ <c:out value="${error}"/></p>
        </c:if>
    </form>
</div>

<script>
    // 간단 클라이언트 검증(이름 최소 2자)
    document.getElementById('bandForm').addEventListener('submit', function(e){
        const nm = document.getElementById('name').value.trim();
        const master = document.getElementById('masterNickname').value.trim();
        if(nm.length < 2){
            alert('밴드 이름을 2자 이상 입력해 주세요.');
            e.preventDefault();
            return;
        }
        if(master.length < 2){
            alert('마스터 닉네임을 2자 이상 입력해 주세요.');
            e.preventDefault();
        }
    });
</script>
</body>
</html>
