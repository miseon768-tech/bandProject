<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <title>정보수정</title>

</head>
<body>


<c:if test="${empty sessionScope.logonUser}">
    <c:redirect url="${pageContext.request.contextPath}/login"/>
</c:if>

<%@ include file="/template/header.jspf" %>

<div class="settings">
    <!-- 왼쪽 -->
    <aside class="settings-nav">
        <h3>설정</h3>
        <nav class="nav-list">
            <a class="nav-item -active" href="${pageContext.request.contextPath}/member/edit-profile.jsp">
                <span class="nav-dot"></span> 프로필
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/member/editPW.jsp">
                <span class="nav-dot" style="opacity:.3"></span> 비밀번호 변경
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/member/accountdelete.jsp">
                <span class="nav-dot" style="opacity:.3"></span> 계정 삭제
            </a>
        </nav>
    </aside>

    <!-- 오른쪽 -->
    <section class="card">
        <header class="card-head">
            <div>
                <h2 class="title">프로필 설정</h2>
                <p class="card-desc">공개 프로필과 연락 정보를 관리하세요.</p>
            </div>
            <!-- 상단 저장 버튼(선호 시 비활성화 가능) -->
            <form method="post" action="${pageContext.request.contextPath}/member/edit-profile">
                <button class="btn" type="submit">저장</button>
            </form>
        </header>

        <form class="card-body" method="post" action="${pageContext.request.contextPath}/member/edit-profile">
            <div class="section-label">기본 정보</div>

            <div class="form-grid">
                <div class="field">
                    <label class="label" for="nickname">닉네임</label>
                    <input class="input" id="nickname" name="nickname" type="text"
                           value="<c:out value='${sessionScope.logonUser.nickname}' default=''/>" required>
                    <small class="hint">서비스에서 표시되는 이름입니다.</small>
                </div>

                <div class="field">
                    <label class="label" for="name">이름</label>
                    <input class="input" id="name" name="name" type="text"
                           value="<c:out value='${sessionScope.logonUser.name}' default=''/>" required>
                </div>

                <div class="field" style="grid-column: 1 / -1">
                    <label class="label" for="email">이메일</label>
                    <input class="input" id="email" name="email" type="email"
                           value="<c:out value='${sessionScope.logonUser.email}' default=''/>" required>
                    <small class="hint">로그인/알림에 사용될 이메일입니다.</small>
                </div>

                <div class="field" style="grid-column: 1 / -1">
                    <label class="label" for="interest">관심사</label>
                    <input class="input" id="interest" name="interest" type="text"
                           value="<c:out value='${sessionScope.logonUser.interest}' default=''/>">
                    <small class="hint">쉼표(,)로 여러 개 입력 가능 예) 음악, 여행, 게임</small>
                </div>
            </div>

            <div class="actions">
                <button class="btn" type="submit">저장</button>
                <button class="btn -ghost" type="button"
                        onclick="location.href='${pageContext.request.contextPath}/member/edit-profile.jsp'">돌아가기</button>
            </div>
        </form>
    </section>
</div>

</body>
</html>
