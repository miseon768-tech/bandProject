<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밴드 삭제</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bandDelete.css">
</head>
<body>

<div class="delete-overlay">
    <div class="delete-modal">
        <h2>⚠️ 밴드 삭제 안내</h2>
        <p>
            밴드를 삭제하면 되돌릴 수 없습니다.<br>
            삭제 시, 밴드의 <strong>모든 게시글 / 멤버 / 이미지 / 설정 정보</strong>가<br>
            <strong class="warn">영구적으로 삭제</strong>됩니다.<br><br>
            정말 삭제하시겠습니까?
        </p>

        <form class="btn-area"
              action="${pageContext.request.contextPath}/community/delete?bandNo=${band.no}"
              method="post" >

            <!-- ✅ 삭제할 밴드 번호 함께 전달 -->
            <input type="hidden" name="bandNo" value="${band.no}"/>

            <button type="button" class="btn cancel" onclick="history.back()">취소하기</button>
            <button type="submit" class="btn delete">예, 삭제하겠습니다</button>
        </form>
    </div>
</div>

</body>
</html>
