<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        탈퇴하시면 계정과 관련 데이터가 삭제됩니다. 진행하시겠습니까?
    </p>

    <form method="post" action="${pageContext.request.contextPath}/account/delete" id="deleteForm">

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

<script>
    // 간단한 예외 방지: 중복 클릭 방지
    document.getElementById('deleteForm').addEventListener('submit', function(e){
        const btns = this.querySelectorAll('button, a');
        btns.forEach(el => el.disabled = true);
    });
</script>
</body>
</html>
