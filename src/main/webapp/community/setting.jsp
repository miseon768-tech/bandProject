<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밴드 설정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bandSetting.css">
</head>
<body>
<div class="setting-wrapper">
    <h2>⚙ 밴드 설정</h2>
    <div class="desc">밴드 관리 기능을 선택하세요.</div>

    <div class="btn-area">
        <!-- ❗수정: 편집 화면으로 이동만 (예: /band/band.jsp 를 편집폼으로 사용) -->
        <button type="button" class="btn edit"
                onclick="location.href='../band/band.jsp'">
            🛠 밴드 수정
        </button>

        <!-- ❗삭제: 동일 엔드포인트 community?bandNo=" + bandNo 으로 POST + action=delete -->
        <form method="post"
              action="${pageContext.request.contextPath}/community?bandNo=" + bandNo"
              onsubmit="return confirm('정말 밴드를 삭제하시겠습니까?');">
            <input type="hidden" name="action" value="delete">
            <button type="submit" class="btn delete">🗑 밴드 삭제</button>
        </form>

        <button type="button" class="btn back"
                onclick="location.href='${pageContext.request.contextPath}/band/list'">← 목록으로
        </button>
    </div>
</div>
</body>
</html>
