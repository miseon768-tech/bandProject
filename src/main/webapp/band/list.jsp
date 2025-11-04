<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 31.
  Time: 오후 3:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<link rel="stylesheet" href="/css/index.css"/>



<body>
<%@ include file="/template/header.jspf" %>

<main class="wrap">
    <h2 class="page-title">다양한 밴드에 가입해보세요</h2>

    <div class="band-grid">
        <!-- 만들기 -->
        <a class="band-card create-card" href="${ctx}/band">
            <div class="create-icon">＋</div>
            <div class="create-text">밴드 만들기</div>
        </a>

        <!-- 밴드 카드들 -->

        <c:forEach var="b" items="${bandlist}">
            <a class="band-card" href="${ctx}/community?bandNo=${b.no}"> <!-- 각 밴드로 연결해둠-->
                <div class="band-cover">

                </div>
                <div class="band-info">
                    <div class="band-title"><c:out value="${b.name}"/></div>
                    <div class="band-meta">Info : <c:out value="${b.description}"/></div>
                </div>
            </a>
        </c:forEach>
        <!-- 비어있을 때 -->
        <c:if test="${empty bandlist}">
            <p class="empty-hint">아직 참여한 밴드가 없어요. ‘만들기’로 새 밴드를 시작해 보세요.</p>
        </c:if>
    </div>

    <!-- 조회수 top5 밴드/좋아요 top5 밴드 추가 가능-->

</main>
</body>
</html>