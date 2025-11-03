<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴</title>
    <link rel="stylesheet" href="/css/css.css"/>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<main class="center" style="max-width:640px; margin:48px auto; padding:24px;">
    <h2 style="margin-bottom:16px;">회원 탈퇴</h2>
    <p style="margin-bottom:24px;">
        탈퇴 시 계정과 관련된 정보가 모두 삭제됩니다. 정말 진행하시겠습니까?
    </p>

    <form method="post" action="${pageContext.request.contextPath}/account/delete" id="deleteForm">
        <!-- 비밀번호 확인 -->
        <div class="field" style="margin-bottom:16px;">
            <label class="label" for="password">비밀번호 확인</label>
            <input class="input" id="password" name="password" type="password" placeholder="비밀번호 입력">
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
</main>

<!-- 비밀번호 미입력 시 경고 메시지 -->
<script>
    document.getElementById('deleteForm').addEventListener('submit', function (e) {
        const password = document.getElementById('password').value.trim();
        const agree = document.getElementById('agreeChk').checked;

        if (password === '') {
            alert('비밀번호를 입력해야 탈퇴할 수 있습니다.');
            e.preventDefault(); // 폼 제출 중단
            return;
        }

        if (!agree) {
            alert('탈퇴 안내에 동의해야 합니다.');
            e.preventDefault();
        }
    });
</script>

</body>
</html>
