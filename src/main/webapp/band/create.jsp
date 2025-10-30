<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밴드 생성</title>
    <link rel="stylesheet" href="/css/css.css"/>

</head>

<body>
<%@ include file="/template/header.jspf"%>

<div class="wrap">
    <h2>새 밴드 만들기</h2>

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
    document.getElementById('bandForm').addEventListener('submit', function (e) {
        const nm = document.getElementById('name').value.trim();
        const master = document.getElementById('masterNickname').value.trim();
        if (nm.length < 2) {
            alert('밴드 이름을 2자 이상 입력해 주세요.');
            e.preventDefault();
            return;
        }
        if (master.length < 2) {
            alert('마스터 닉네임을 2자 이상 입력해 주세요.');
            e.preventDefault();
        }
    });
</script>
</body>
</html>
