<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밴드 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bandEdit.css">
</head>
<body>

<div class="main">
    <div style="flex:1"></div>

    <div style="flex:4">
        <h2>🎸 밴드 정보 수정</h2>
        <p style="color:#777; font-size:14px;">밴드의 정보를 수정한 후 저장을 눌러주세요.</p>

        <!-- ✅ 밴드 수정 폼 -->
        <form class="band-edit-form" action="${pageContext.request.contextPath}/community/edit" method="post" enctype="multipart/form-data">
            <!-- 밴드 이름 -->
            <div class="field">
                <label for="bandName"><small>밴드 이름</small></label>
                <input type="text" class="input" id="bandName" name="bandName"
                       value="${band.name}" placeholder="밴드 이름을 입력하세요 (최대 50자)" maxlength="50" required>
            </div>

            <!-- 밴드 설명 -->
            <div class="field">
                <label for="bandDesc"><small>밴드 설명</small></label>
                <textarea class="textarea" id="bandDesc" name="description" rows="4"
                          placeholder="밴드에 대한 소개를 입력하세요 (최대 200자)"
                          maxlength="200">${band.description}</textarea>
            </div>



            <!-- 태그 (선택) -->
            <div class="field">
                <label for="bandTag"><small>밴드 태그</small></label>
                <input type="text" class="input" id="bandTag" name="tag"
                       value="${band.tag}" placeholder="예: 음악, 스터디, 개발, 여행 등">
            </div>

            <!-- 수정 버튼 -->
            <div class="btn-area">
                <button type="submit" class="btn blue">💾 저장하기</button>
                <button type="button" class="btn gray"
                        onclick="location.href='${pageContext.request.contextPath}/community'">← 취소</button>
            </div>
        </form>
    </div>

    <div style="flex:1"></div>
</div>

</body>
</html>
