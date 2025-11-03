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
    <h2>밴드 생성하기</h2>

    <form class="card" method="post" action="${pageContext.request.contextPath}/band" id="bandForm">

        <div class="field">
            <label class="label" for="name">이름 설정</label>
            <input class="input" id="name" name="name" type="text"
                   placeholder="이름 입력"
                   value="<c:out value='${not empty name ? name : ""}'/>"
                   required>

        <!-- 닉네임 입력 -->
        <div class="field">
            <label class="label" for="nickname">닉네임 설정</label>
            <input class="input" id="nickname" name="nickname" type="text"
                   placeholder="닉네임 입력"
                   value="<c:out value='${not empty nickname ? nickname : ""}'/>"
                   required>

        </div>

        <!--  밴드 설명  -->
        <div class="field">
            <label class="label" for="description">밴드 설명</label>
            <textarea class="textarea" id="description" name="description"
                      placeholder="생성할 밴드의 설명을 입력해주세요"></textarea>
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

</body>
</html>
