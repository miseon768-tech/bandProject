<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <title>BAND 메인화면</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css"/>
    <link rel="stylesheet" href="/css/index.css"/>
</head>
<body>
<%@ include file="/template/header.jspf" %>
<div class="band-wrapper">
    <!-- 상단바: 좌측 로고 / 우측 검색+버튼들 -->

    <!-- 본문 3분할 -->
    <div class="main">
        <!-- 좌측 사이드 -->
        <aside class="sidebar">
            <!-- 동그라미 이미지: 링크 가능 (프로필 이미지 업로드/수정 페이지로 연결) -->
            <a class="avatar-link">
                <img src=""/>
            </a>
            <p>
            <h2 style="margin : 2px 0;">${band.name}</h2>
            <p style="font-size: small; color : dimgray; margin : 2px 0;">
                ${band.description}
            </p>
            <c:choose>
                <c:when test="${bandRole == 'NOT_JOINED'}">
                    <button class="side-btn gray" onclick="openJoinModal()">가입하기</button>
                </c:when>
                <c:when test="${bandRole =='MEMBER_WAITING'}">
                    <button class="side-btn gray">가입 신청중</button>
                </c:when>
                <c:when test="${bandRole == 'MEMBER'}">
                    <button class="side-btn gray" onclick="focusWriteForm()">글쓰기</button>
                </c:when>
                <c:when test="${bandRole =='MASTER'}">
                    <button class="side-btn gray">멤버관리</button>
                </c:when>

            </c:choose>
            </p>

        </aside>

        <!-- 중앙 -->
        <main class="center">
            <!-- 새 글 작성하기 (그대로 유지) -->
            <form class="new-post" action="/article/new" method="post">
                <input type="hidden" name="bandNo" value="${band.no}"/>
                <h3>🖋 새 글 작성하기</h3>
                <div class="field">
                    <input class="input" type="text" maxlength="50" placeholder="제목을 입력하세요 (최대 50자)" id="title"
                           name="title"/>
                </div>
                <div class="field">
                    <textarea class="textarea" rows="3" maxlength="20" placeholder="내용(20자 이내로 작성해 주세요)"
                              name="content"></textarea>
                </div>
                <div class="actions" style="padding : 2px 0px; text-align: right">
                    <button class="btn blue" style="margin : 0">게시하기</button>
                </div>
            </form>
            <ul style="margin:0; padding:0;">
                <c:forEach var="one" items="${articleList}">
                    <li style="
            list-style:none;
            background:#fff;
            margin:12px 0;
            padding:14px 16px;
            border-radius:8px;
            box-shadow:0 2px 6px rgba(0,0,0,0.08);
            font-family:'맑은 고딕', sans-serif;
        ">

                        <!-- 상단: 제목 + 아이디 + 작성 시간 -->
                        <div style="display:flex; align-items:center; margin-bottom:8px;">
                            <div style="font-weight:bold; font-size:15px; margin-right:6px;">${one.title}</div>
                            <div style="color:#777; font-size:13px;">(${one.writerId})</div>
                            <div style="color:#aaa; font-size:12px; margin-left:8px;">${one.wroteAt}</div>
                            <div style="margin-left:auto; cursor:pointer; color:#bbb;">⋮</div>
                        </div>

                        <!-- 하단: 본문 -->
                        <div style="font-size:15px; line-height:1.6; color:#333; margin-left:2px;">
                                ${one.content}
                        </div>
                    </li>
                </c:forEach>
            </ul>

        </main>

        <!-- 우측 인기글 -->
        <aside class="right">
            <h4>인기글 (Top 5)</h4>
            <div class="top5-box">(보류 영역)</div>
        </aside>
    </div>
</div>

<!-- ✅ 모달 영역 -->
<div class="modal-backdrop" id="joinModal">
    <form class="modal" action="/band/member" method="post">
        <input type="hidden" name="bandNo" value="${band.no}"/>
        <input type="hidden" name="action" value="apply"/>
        <h3>밴드 가입 신청</h3>
        <p style="color: dimgray">
            밴드에서 사용할 닉네임을 설정해주세요.
        </p>
        <input type="text" name="nickname" placeholder="밴드에서 사용할 닉네임을 설정해주세요"
               value="${sessionScope.logonUser.nickname}"/>
        <div>
            <button id="submitJoin" style="width: 100%">확인</button>

        </div>
    </form>
</div>

<script>
    const toggleBtn = document.getElementById("toggleBtn");
    const dropdownMenu = document.getElementById("dropdownMenu");

    toggleBtn.addEventListener("click", function (e) {
        e.stopPropagation();
        dropdownMenu.style.display =
            (dropdownMenu.style.display === "none" || dropdownMenu.style.display === "") ? "block" : "none";
    });

    document.addEventListener("click", function (e) {
        if (!toggleBtn.contains(e.target) && !dropdownMenu.contains(e.target)) {
            dropdownMenu.style.display = "none";
        }
    });

    // ✅ 모달 토글 스크립트

    const joinModal = document.getElementById("joinModal");
    const closeModal = document.getElementById("closeModal");
    const submitJoin = document.getElementById("submitJoin");

    function openJoinModal() {
        joinModal.style.display = "flex";
    };

    function focusWriteForm() {
        document.getElementById("title").focus();
    }

    document.addEventListener("keydown", (e) => {
        if (e.key === "Escape" && joinModal.style.display === "flex") {
            joinModal.style.display = "none";
        }
    });

    // 바깥 클릭으로 닫기
    joinModal.addEventListener("click", (e) => {
        // 모달 외부 영역 클릭 시 닫기
        if (e.target === joinModal) {
            joinModal.style.display = "none";
        }
    });
</script>
</body>
</html>
