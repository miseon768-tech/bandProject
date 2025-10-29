<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>밴드 생성</title>
    <style>
        body {
            font-family: "맑은 고딕", sans-serif;
            margin: 50px auto;
            width: 60%;
            background-color: #fafafa;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        button {
            background: #0066cc;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            margin-top: 15px;
            cursor: pointer;
        }
        button:hover {
            background: #004999;
        }
        .msg {
            text-align: center;
            color: green;
            margin-top: 20px;
        }
        .error {
            text-align: center;
            color: red;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>🎵 새 밴드 만들기</h2>

<form method="post" action="${pageContext.request.contextPath}/band/create">
    <label>밴드 이름</label>
    <input type="text" name="name" placeholder="밴드 이름을 입력하세요" required>

    <label>밴드 설명</label>
    <textarea name="description" rows="5" placeholder="밴드 소개를 입력하세요"></textarea>

    <label>
        <input type="checkbox" name="is_public"> 공개 밴드로 설정
    </label>

    <div style="text-align:center;">
        <button type="submit">밴드 생성</button>
    </div>
</form>

<!-- 생성 결과 메시지 출력 -->
<c:if test="${not empty success}">
    <p class="msg">✅ ${success}</p>
</c:if>

<c:if test="${not empty error}">
    <p class="error">⚠ ${error}</p>
</c:if>

</body>
</html>
