<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:33
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:33
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath(); // 필요시 폼 action 등에 사용
%>
<html>
<head>
    <title>밴드</title>
    <link rel="stylesheet" href="/css/css.css"/>
</head>
<body>
<div class="signup-wrap">
    <div class="signup">
        <a href="<%=ctx%>/">로고</a>
        <h2 class="text-center">밴드에 오신것을 환영합니다.</h2>
        <p class="text-center text-gray">
            다양한 취미들이 모여 하나의 즐거움이 되는 공간
        </p>

        <form class="signup-form" action="<%=ctx%>/login" method="post">
            <div>
                <label for="id"><small>아이디</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="id" id="id" onkeyup="updateButtonState()"/>
                </div>
            </div>

            <div>
                <label for="password"><small>비밀번호</small></label>
                <div class="mt-1">
                    <input type="password" class="input" name="password" id="password" onkeyup="updateButtonState()"/>
                </div>

                <div class="mt-1 row-between">
                    <label for="keepLogin"><small>로그인 상태 유지</small></label>
                    <input type="checkbox" name="keepLogin" id="keepLogin" onchange="keepLoginConfirm();"/>
                </div>

                <div>
                    <button id="loginBt" class="bt-submit" disabled>로그인</button>
                </div>
            </div>
        </form>

        <p class="text-center text-small">
            아직 회원이 아니신가요?
            <a class="link-small" href="<%=ctx%>/signup">회원가입</a>
        </p>
    </div>
</div>

<script>
    function keepLoginConfirm() {
        const box = document.getElementById("keepLogin");
        if (box.checked) {
            if (!window.confirm("공용 PC에서는 보안상의 문제가 발생할 수 있습니다. 계속하시겠습니까?")) {
                box.checked = false;
            }
        }
    }

    function updateButtonState() {
        const idValue = document.getElementById("id").value.trim();
        const passValue = document.getElementById("password").value.trim();
        document.getElementById("loginBt").disabled = !(idValue && passValue);
    }
</script>
</body>
</html>
