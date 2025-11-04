<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 11. 4.
  Time: 오전 9:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>밴드삭제</title>
</head>
<body>

<div class="signup-wrap">
    <div class="signup">
        <a href="/">로고</a>
        <h2>밴드 탈퇴 시 아래와 같이 처리됩니다.</h2>
        <p style="width: 400px;">
            밴드 탈퇴일로부터 밴드 닉네임을 포함한 모든것이
            완전히 삭제되며 더 이상 밴드에 복구할 수 없게 됩니다.
        </p>
        <form action="/community/delete" method="post">
            <button type="button">취소</button>
            <button type="submit">예 탈퇴하겠습니다.</button>
        </form>
    </div>
</div>
</body>
</html>
