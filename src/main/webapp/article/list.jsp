<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 목록</title>

</head>
<body>
<%@ include file="/template/header.jspf"%>
<h2>📋 카테고리</h2>

<div style="text-align:right; margin-bottom:10px;">
    <a href="${pageContext.request.contextPath}/article/new" class="btn">✏️ 새 글쓰기</a>
</div>

<table>
    <thead>
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>좋아요</th>
        <th>등록일</th>

    </tr>
    </thead>
    <tbody>
    <c:choose>
        <c:when test="${not empty articles}">
            <c:forEach var="a" items="${articles}">
                <tr>
                    <td>${a.no}</td>
                    <td style="text-align:left;">
                        <a href="${pageContext.request.contextPath}/article/list?no=${a.no}">
                                ${a.title}
                        </a>
                    </td>
                    <td>${a.writerId}</td>
                    <td>${a.viewCnt}</td>
                    <td>${a.regDate}</td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr><td colspan="5">등록된 게시글이 없습니다.</td></tr>
            <button onclick="location.href='/band/member'">승인요청</button>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>
</body>
</html>
