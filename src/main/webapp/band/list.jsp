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
        <!-- 만들기 카드 -->
        <a class="band-card create-card" href="${ctx}/band">
            <div class="create-icon">＋</div>
            <div class="create-text">만들기</div>
        </a>

        <!-- 밴드 카드들 -->
        <c:forEach var="b" items="${myBands}">
            <a class="band-card" href="${ctx}/band/${b.no}">
                <div class="band-cover">
                    <c:choose>
                        <c:when test="${not empty b.coverUrl}">

                        </c:when>
                        <c:otherwise>
                            <div class="band-cover placeholder">No Image</div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="band-info">
                    <div class="band-title"><c:out value="${b.name}"/></div>
                    <div class="band-meta">멤버 <c:out value="${b.memberCount}"/>명</div>
                </div>
            </a>
        </c:forEach>
    </div>


    <!-- 저장된 밴드 카드들 -->
    <c:forEach var="b" items="${bands}">
        <a class="band-card" href="${ctx}/band/${b.no}">
            <div class="band-cover">
                <!-- 커버 이미지가 있다면 보여주고, 없으면 플레이스홀더 -->
                <c:choose>
                    <c:when test="${not empty b.coverUrl}">
                        <img src="${b.coverUrl}" alt="${b.name} 커버">
                    </c:when>
                    <c:otherwise>No Image</c:otherwise>
                </c:choose>
            </div>
            <div class="band-info">
                <div class="band-title"><c:out value="${b.name}"/></div>
                <div class="band-meta">
                    no: <c:out value="${b.no}"/> · 마스터: <c:out value="${b.nickname}"/>
                </div>
                <c:if test="${not empty b.description}">
                    <div class="band-desc"><c:out value="${b.description}"/></div>
                </c:if>
                <div class="band-meta">
                    <fmt:formatDate value="${b.createdAt}" pattern="yyyy.MM.dd HH:mm" />
                </div>
            </div>
        </a>
    </c:forEach>
    </div>

    <!-- 비어있을 때 -->
    <c:if test="${empty myBands}">
        <p class="empty-hint">아직 참여한 밴드가 없어요. ‘만들기’로 새 밴드를 시작해 보세요.</p>
    </c:if>
</main>
</body>
</html>