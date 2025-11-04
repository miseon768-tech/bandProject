<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>BAND 메인화면</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css" />
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
                <button type="button" onclick="location.href='/community/edit'">밴드 수정</button>
                <button type="button" onclick="location.href='/community/delete'">밴드 삭제</button>
            </div>
        </div>
    </div>

    <!-- 본문 -->
    <div class="main">
        <!-- 좌측 사이드 -->
        <aside class="sidebar">
            <a class="avatar-link" href="${pageContext.request.contextPath}/community/edit-profile.jsp">
                이미지
            </a>
            <div>밴드네임</div>

            <!-- 일반 멤버(로그인 유저)가 있을 때만 승인 요청 버튼 -->
            <c:if test="${logonUser != null}">
                <form action="${pageContext.request.contextPath}/band/member" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="apply"/>
                    <input type="hidden" name="bandNo" value="${band.no}"/>
                    <input type="hidden" name="nickname" value="${logonUser.nickname}"/>
                    <button type="submit" class="side-btn blue">승인 요청</button>
                </form>
            </c:if>

            <!-- MASTER일 때 승인 관리 버튼  -->
            <c:if test="${band.role eq 'MASTER'}">
                <button class="side-btn gray" onclick="toggleApprovalList()">승인 관리</button>
            </c:if>


            <div id="approvalList" style="display:none; margin-top:10px; width:100%;">
                <h4>승인 대기 멤버</h4>
                <c:forEach var="m" items="${pendingMembers}">
                    <div class="pending-box">
                        <span>${m.nickname}</span>
                        <form action="${pageContext.request.contextPath}/band/member" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="approve"/>
                            <input type="hidden" name="bandNo" value="${m.bandNo}"/>
                            <input type="hidden" name="bandMemberNo" value="${m.no}"/>
                            <input type="hidden" name="approved" value="true"/>
                            <button type="submit" class="btn green">승인</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/band/member" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="approve"/>
                            <input type="hidden" name="bandNo" value="${m.bandNo}"/>
                            <input type="hidden" name="bandMemberNo" value="${m.no}"/>
                            <input type="hidden" name="approved" value="false"/>
                            <button type="submit" class="btn red">거절</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </aside>

        <!-- 중앙 -->
        <main class="center">
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

            <!-- 게시글 목록 -->
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

<script>
    // ----------------------------
    // [1] 설정 드롭다운
    // ----------------------------
    const toggleBtn = document.getElementById("toggleBtn");
    const dropdownMenu = document.getElementById("dropdownMenu");
    const approvalList = document.getElementById("approvalList");

    // 설정 버튼 클릭 → 드롭다운 표시
    toggleBtn.addEventListener("click", function (e) {
        e.stopPropagation();
        const isVisible = dropdownMenu.style.display === "block";
        dropdownMenu.style.display = isVisible ? "none" : "block";
    });

    // 화면 클릭 시 드롭다운 닫기
    document.addEventListener("click", function (e) {
        if (!toggleBtn.contains(e.target) && !dropdownMenu.contains(e.target)) {
            dropdownMenu.style.display = "none";
        }
    });

    // ----------------------------
    // [2] 승인 관리 슬라이드 애니메이션
    // ----------------------------
    function toggleApprovalList() {
        if (!approvalList) return;

        // 이미 열려 있으면 닫기
        if (approvalList.classList.contains("active")) {
            approvalList.classList.remove("active");
            setTimeout(() => {
                approvalList.style.display = "none";
            }, 300); // transition 시간과 동일하게
        }
        // 닫혀 있으면 열기
        else {
            approvalList.style.display = "block";
            setTimeout(() => {
                approvalList.classList.add("active");
            }, 10); // 약간의 delay로 transition 자연스럽게
        }
    }
</script>

</body>
</html>
