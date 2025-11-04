<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밴드 정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bandEdit.css">
</head>
<body>

<div class="main">
    <div style="flex:1"></div>

    <div style="flex:4">
        <h2>🎸 밴드 정보 수정</h2>
        <p style="color:#777; font-size:14px;">밴드의 정보를 수정한 후 저장을 눌러주세요.</p>

        <!-- ✅ 수정 폼 -->
        <form class="band-edit-form"
              action="${pageContext.request.contextPath}/community/edit?bandNo=${band.no}"
              method="post">

            <!-- ✅ 밴드 번호 (숨김값) -->
            <input type="hidden" name="bandNo" value="${band.no}"/>

            <!-- ✅ 밴드 이름 -->
            <div class="field">
                <label for="name"><small>이름 설정</small></label>
                <input type="text" id="name" name="name"
                       class="input"
                       value="${band.name}"
                       maxlength="50" required/>
            </div>
            <!-- ✅ 밴드 닉네임 -->
            <div class="field">
                <label for="name"><small>닉네임 설정</small></label>
                <input type="text" id="nickname" name="nickname"
                       class="input"
                       value="${band.nickname}"
                       maxlength="50" required/>
            </div>

            <!-- ✅ 밴드 설명 -->
            <div class="field">
                <label for="description"><small>밴드 설명</small></label>
                <textarea id="description" name="description" rows="4"
                          class="textarea"
                          maxlength="200">${band.description}</textarea>
            </div>

            <!-- ✅ 버튼 영역 -->
            <div class="btn-area">
                <button type="submit" class="btn blue">💾 저장하기</button>
                <button type="button" class="btn gray"
                        onclick="location.href='${pageContext.request.contextPath}/community/edit?bandNo=${band.no}'">
                    ← 취소
                </button>
            </div>
        </form>
    </div>

    <div style="flex:1"></div>
</div>

</body>
</html>
