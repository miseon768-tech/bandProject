<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>BAND 메인화면</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css" />
    <style>
        /* 가운데 피드 카드 스타일 (필요 시 community.css로 이동) */
        .content { padding: 16px; }
        .feed-title { margin: 0 0 12px; color: var(--maroon); }
        .article-list { display: flex; flex-direction: column; gap: 18px; }
        .article-card {
            background: var(--cream);
            border: 1px solid var(--vanilla);
            border-radius: 10px;
            padding: 16px 18px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            transition: transform .15s;
        }
        .article-card:hover { transform: translateY(-3px); }
        .article-title a { color: var(--maroon); text-decoration: none; font-weight: 700; font-size: 1.05rem; }
        .article-meta { color:#666; font-size:.9rem; margin-top:6px; }
        .article-content { margin-top:10px; color: var(--ink); white-space: pre-wrap; }
        .empty { text-align:center; color:#aaa; padding:28px 0; }
        .write-btn {
            display:inline-block; margin: 0 0 14px; padding:10px 16px;
            border:none; border-radius:8px; font-weight:700; cursor:pointer;
            background: var(--sunray); color: var(--maroon);
        }
        .write-btn:hover { background: color-mix(in srgb, var(--sunray) 90%, white); }

        /* 3분할 레이아웃이 이미 있다면 건드릴 필요 없음. 없을 때 대비 기본 배치 */
        .main { display:grid; grid-template-columns: 260px 1fr 280px; gap:16px; }
        .sidebar, .right { padding:16px; }
        .top5-list { display:flex; flex-direction:column; gap:10px; margin-top:10px; }
        .top5-item { font-size:.95rem; }
        .top5-item a { color: var(--maroon); text-decoration:none; }
        .brand { font-weight: 900; }
        #dropdownMenu { display:none; position:absolute; right:0; top:40px; background:var(--cream); border:1px solid var(--vanilla); border-radius:10px; overflow:hidden; }
        #dropdownMenu button { display:block; width:100%; padding:10px 12px; border:none; background:transparent; cursor:pointer; text-align:left; }
        #dropdownMenu button:hover { background: var(--vanilla); }
    </style>
</head>
<body>
<div class="band-wrapper">
    <!-- 상단바 -->
    <div class="header">
        <div class="brand">BAND</div>
        <div class="header-right">
            <div class="search-bar">
                🔍 <input type="text" placeholder="검색" />
            </div>
            <button class="top-btn" onclick="location.href='../member/logout.jsp'">로그아웃</button>

            <button type="button" id="toggleBtn">설정</button>

            <div id="dropdownMenu">
                <button type="button" onclick="location.href='/community/edit?bandNo=${band.no}'">밴드 수정</button>
                <button type="button" onclick="location.href='community/delete'">밴드 삭제</button>
            </div>
        </div>
    </div>

    <!-- 본문 3분할 -->
    <div class="main">
        <!-- 좌측 사이드 -->
        <aside class="sidebar">
            <!-- 프로필 이미지 -->
            <a class="avatar-link" href="${pageContext.request.contextPath}/community/edit-profile.jsp" title="프로필 이미지 변경">
                이미지
            </a>

            <!-- 밴드 이름 -->
            <div style="margin:10px 0 14px; font-weight:700;">${band.name}</div>

            <!-- 승인 버튼 -->
            <button class="side-btn gray"
                    onclick="location.href='${pageContext.request.contextPath}/community?action=approve&memberId=${logonUser.id}'">
                승인
            </button>

            <!-- 게시물 작성 버튼 -->
            <button class="side-btn blue"
                    onclick="location.href='${pageContext.request.contextPath}/article/new.jsp'">
                게시물 작성
            </button>

            좋아요
        </aside>

        <!-- 가운데 피드 -->
        <section class="content">
            <h3 class="feed-title">커뮤니티 게시글</h3>
            <button class="write-btn" onclick="location.href='${pageContext.request.contextPath}/article/new.jsp'">✏️ 새 글 작성하기</button>

            <div class="article-list">
                <c:choose>
                    <c:when test="${not empty articles}">
                        <c:forEach var="a" items="${articles}">
                            <div class="article-card">
                                <div class="article-title">
                                    <a href="${pageContext.request.contextPath}/article?no=${a.no}">
                                        <c:out value="${a.title}" />
                                    </a>
                                </div>
                                <div class="article-meta">
                                    작성자: <c:out value="${a.writerId}" />
                                    &nbsp;|&nbsp; 조회수: <c:out value="${a.views}" />
                                    &nbsp;|&nbsp; 좋아요: <c:out value="${a.likes}" />
                                    &nbsp;|&nbsp; <c:out value="${a.createdAt}" />
                                </div>
                                <div class="article-content">
                                    <c:out value="${a.content}" />
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty">아직 게시물이 없습니다</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- 우측 인기글 -->
        <aside class="right">
            <h4>인기글 (Top 5)</h4>
            <div class="top5-box">
                <c:choose>
                    <c:when test="${not empty top5Likes}">
                        <div class="top5-list">
                            <c:forEach var="p" items="${top5Likes}">
                                <div class="top5-item">
                                    • <a href="${pageContext.request.contextPath}/article?no=${p.no}">
                                    <c:out value="${p.title}" />
                                </a>
                                    <span style="color:#777;">(좋아요 <c:out value='${p.likes}'/>)</span>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty" style="padding:10px 0;">표시할 인기글이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </aside>
    </div>
</div>

<script>
    const toggleBtn = document.getElementById("toggleBtn");
    const dropdownMenu = document.getElementById("dropdownMenu");

    toggleBtn.addEventListener("click", function(e) {
        e.stopPropagation();
        dropdownMenu.style.display =
            (dropdownMenu.style.display === "none" || dropdownMenu.style.display === "") ? "block" : "none";
    });

    document.addEventListener("click", function(e) {
        if (!toggleBtn.contains(e.target) && !dropdownMenu.contains(e.target)) {
            dropdownMenu.style.display = "none";
        }
    });
</script>
</body>
</html>
