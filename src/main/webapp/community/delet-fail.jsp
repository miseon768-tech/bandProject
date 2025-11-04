<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 11. 4.
  Time: 오전 9:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>밴드 삭제 실패</title>
</head>

<body>
<h2>⚠️ 밴드 삭제 확인</h2>
<p>정말 밴드을 삭제하시겠습니까?</p>

<form action="${pageContext.request.contextPath}/community/deletee" method="post">
    <input type="hidden" name="no" value="${param.no}">
    <button type="submit" class="btn">삭제하기</button>
    <a href="${pageContext.request.contextPath}/community" style="margin-left:10px;">취소</a>
</form>
</body>
</html>


