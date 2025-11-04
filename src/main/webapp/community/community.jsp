<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>BAND 메인화면</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css" />
</head>
<body>


<div class="band-wrapper">
    <!-- 상단바: 좌측 로고 / 우측 검색+버튼들 -->
    <div class="header">
        <div class="brand">BAND</div>
        <div class="header-right">
            <div class="search-bar">
                🔍 <input type="text" placeholder="검색" />
            </div>
            <button class="top-btn" onclick="location.href='../member/logout.jsp'">로그아웃</button>

            <!-- community.jsp 상단 “설정” 버튼 -->
            <button class="top-btn" id="toggleBtn">설정</button>

            <div id="dropdownMenu">
                <button type="button" onclick="location.href='/community/edit'">밴드 수정</button>
                <button type="button" onclick="location.href='/community/delete'">밴드 삭제</button>
            </div>


        </div>
    </div>

    <!-- 본문 3분할 -->
    <div class="main">
        <!-- 좌측 사이드 -->
        <aside class="sidebar">
            <!-- 동그라미 이미지: 링크 가능 (프로필 이미지 업로드/수정 페이지로 연결) -->
            <a class="avatar-link" href="${pageContext.request.contextPath}/community/edit-profile.jsp" title="프로필 이미지 변경">
                이미지
            </a>
            밴드네임
            <button class="side-btn gray"
                    onclick="location.href='${pageContext.request.contextPath}/community?action=approve&memberId=${logonUser.id}'">
                승인
            </button>
            좋아요

        </aside>

        <!-- 중앙 -->
        <main class="center">
            <!-- 새 글 작성하기 (그대로 유지) -->
            <section class="new-post">
                <h3>🖋 새 글 작성하기</h3>
                <div class="field">
                    <input class="input" type="text" maxlength="50" placeholder="제목을 입력하세요 (최대 50자)" />
                </div>
                <div class="field">
                    <textarea class="textarea" rows="3" maxlength="20" placeholder="내용(20자 이내로 작성해 주세요)"></textarea>
                </div>
                <div class="actions">

                    <button class="btn blue">게시하기</button>
                </div>
            </section>

            <!-- 피드 텍스트 상자들 -->
            <article class="feed-card">
                <div class="feed-meta">닉네임 · 1시간 전</div>
                <div class="feed-title">제목</div>
                <div class="feed-body">내용</div>
            </article>

            <article class="feed-card">
                <div class="feed-meta">닉네임 · 2시간 전</div>
                <div class="feed-title">제목</div>
                <div class="feed-body">내용</div>
            </article>

            <article class="feed-card">
                <div class="feed-meta">닉네임 · 3시간 전</div>
                <div class="feed-title">제목</div>
                <div class="feed-body">내용</div>
            </article>
        </main>

        <!-- 우측 인기글 -->
        <aside class="right">
            <h4>인기글 (Top 5)</h4>
            <div class="top5-box">(보류 영역)</div>
        </aside>
    </div>
</div>
</body>
</html>
