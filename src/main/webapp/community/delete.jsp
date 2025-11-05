<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밴드 삭제</title>

    <!-- ✅ 외부 CSS 파일 연결 -->
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

        <!-- ✅ bandNo 값 디버그용 표시 -->
        <div class="debug">
            (디버그) 현재 bandNo: <strong>${bandNo}</strong>
        </div>

        <!-- ✅ 삭제 확인 폼 -->
        <form class="btn-area"
              action="${pageContext.request.contextPath}/community/delete?bandNo=${bandNo}"
              method="post">

            <!-- ✅ 삭제할 밴드 번호 전달 -->
            <input type="hidden" name="bandNo" value="${bandNo}" />

            <button type="button" class="btn cancel" onclick="history.back()">취소하기</button>
            <button type="submit" class="btn delete">예, 삭제하겠습니다</button>
        </form>

        <!-- ✅ 삭제 완료 메시지 -->
        <div id="successMsg" class="success-message">
            ✅ 밴드가 성공적으로 삭제되었습니다.
        </div>
    </div>
</div>

<!-- ✅ 삭제 성공 시 메시지 표시 스크립트 -->
<script>
    window.addEventListener("DOMContentLoaded", () => {
        const params = new URLSearchParams(window.location.search);
        if (params.get("deleted") === "success") {
            const msg = document.getElementById("successMsg");
            if (msg) msg.style.display = "block";
        }
    });
</script>

</body>
</html>
