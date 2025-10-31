<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 29.
  Time: 오후 5:12
  To change this template use File | Settings | File Templates.
--%>
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
<%@ include file="/template/header.jspf" %>

<div class="wrap">
    <h2>밴드에 가입하기</h2>

    <form class="card" method="post" action="${pageContext.request.contextPath}/band" id="bandForm">

        <!-- 닉네임 입력 -->
        <div class="field">
            <label class="label" for="Nickname">닉네임 설정</label>
            <input class="input" id="Nickname" name="Nickname" type="text"
                   placeholder="닉네임 입력"
                   value="<c:out value='${not empty Nickname ? Nickname : ""}'/>"
                   required>
            <small class="hint">닉네임을 입력해주세요.</small>
        </div>

        <!-- 가입 인사 -->
        <div class="field">
            <label class="label" for="description">가입 인사글</label>
            <textarea class="textarea" id="description" name="description"
                      placeholder="안녕하세요!"></textarea>
        </div>


        <!-- 버튼 -->
        <div class="actions">
            <button type="button" class="btn" onclick="history.back()">이전</button>
            <button type="submit" class="btn btn-primary">가입하기</button>
        </div>

        <!-- 가입 결과 메시지 -->
        <c:if test="${not empty success}">
            <p class="msg">✅ <c:out value="${success}"/></p>
        </c:if>
        <c:if test="${not empty error}">
            <p class="error">⚠ <c:out value="${error}"/></p>
        </c:if>
    </form>
</div>

<script>
    // 간단 클라이언트 검증(닉네임 최소 2자)
    document.getElementById('bandForm').addEventListener('submit', function (e) {
        const nm = document.getElementById('nickname').value.trim();

        if (nm.length < 2) {
            alert('닉네임을 2자 이상 입력해 주세요.');
            e.preventDefault();
            return;
        }

    });
</script>
</body>
</html>
