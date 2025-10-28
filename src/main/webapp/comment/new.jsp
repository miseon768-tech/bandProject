<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>댓글</title>
</head>
<body>
<h3>댓글</h3>

<c:forEach var="c" items="${comments}">
    <div style="border-bottom:1px solid #eee; padding:8px 0;">
        <b>${c.writerId}</b>
        <span style="font-size:12px;color:#777;">${c.commentedAt}</span>
        <div>${fn:escapeXml(c.content)}</div>
    </div>
</c:forEach>

<c:choose>
    <c:when test="${not empty logonUser}">
        <form method="post" action="/comment" style="margin-top:12px;">
            <input type="hidden" name="articleNo" value="${param.no}" />
            <textarea name="content" rows="3" style="width:100%;" placeholder="댓글을 입력하세요"></textarea>
            <button type="submit">등록</button>
        </form>
    </c:when>
    <c:otherwise>
        <div style="margin-top:12px;color:#666;">댓글을 쓰려면 <a href="/login">로그인</a>하세요.</div>
    </c:otherwise>
</c:choose>

</body>
</html>
