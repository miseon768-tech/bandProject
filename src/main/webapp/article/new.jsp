<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새 글 작성</title>
    <style>
        body {
            font-family: "맑은 고딕", serif; margin: 40px auto; width: 80%;
        }
        textarea, input {
            width: 100%; padding: 10px; margin-bottom: 15px;
        }
        button {
            background: #007bff; color: white;
            border: none; padding: 8px 15px;
            border-radius: 5px; cursor: pointer;
        }
        button:hover { background: #0056b3; }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf"%>
<h2>✏️ 새 글 작성</h2>

<form method="post" action="${pageContext.request.contextPath}/article/new">
    <p><input type="text" name="title" placeholder="제목을 입력하세요" required></p>
    <p><textarea name="content" rows="10" placeholder="내용을 입력하세요" required></textarea></p>
    <div style="text-align:center;">
        <button type="submit">등록하기</button>
        <a href="${pageContext.request.contextPath}/article/list" style="margin-left:10px;">목록으로</a>
    </div>
</form>

</body>
</html>
