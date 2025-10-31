<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오후 3:42
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 17.
  Time: 오후 4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="/css/css.css"/>

</head>
<body>
<%@ include file="/template/header.jspf"%>

<h2>회원가입</h2>

<!-- 회원가입 실패 시 에러 알림 -->

<div class="signup-wrap">
    <div class="signup">
        <a href="/">로고</a>
        <h2 class="text-center">밴드에 오신것을 환영합니다.</h2>
        <p class="text-center text-gray">
            다양한 취미들이 모여 하나의 즐거움이 되는 공간
        </p>

        <form class="signup-form" action="/signup" method="post">
            <div>
                <label for="id"><small>아이디</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="id" id="id"
                           placeholder="4~15자 이내로 입력해주세요"
                           value="${param.id}"/>
                </div>
            </div>

            <div>
                <label for="password"><small>비밀번호</small></label>
                <div class="mt-1">
                    <!-- type="password"로 노출 방지 -->
                    <input type="password" class="input" name="password" id="password"
                           placeholder="최소 6자 이상(알파벳, 숫자 필수)"/>
                </div>
            </div>

            <div>
                <label for="email"><small>이메일</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="email" id="email"
                           placeholder="test@test.com"
                           value="${fn:escapeXml(param.email)}"/>
                </div>
            </div>

            <div>
                <label for="name"><small>실명</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="name" id="name"
                           placeholder="홍길동"
                           value="${fn:escapeXml(param.name)}">
                </div>
            </div>

            <div>
                <label for="nickname"><small>닉네임</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="nickname" id="nickname"
                           placeholder="별명을 알파벳,한글,숫자 20자 이하로 입력해주세요."
                           value="${fn:escapeXml(param.nickname)}">
                </div>
            </div>

            <div>
                <label for="interest"><small>관심태그</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="interest" id="interest"
                           placeholder="여행, 스포츠, 예체능, 일상 ..."
                           value="${fn:escapeXml(param.interest)}">
                </div>
            </div>

            <div>
                <div style="display: flex; justify-content: space-between">
                    <label><small>이메일 수신동의</small></label>
                    <div>
                        <input type="checkbox" name="agree" value="true"
                               <c:if test="${param.agree == 'true'}">checked</c:if> />
                    </div>
                </div>
                <p class="text-gray mt-1">
                    밴드에서 주최하는 다양한 이벤트, 정보성 뉴스레터 및 광고 수신여부를 설정할 수 있습니다.
                </p>
            </div>

            <div>
                <button class="bt-submit">회원가입</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
