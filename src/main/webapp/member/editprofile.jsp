<%--
  Created by IntelliJ IDEA.
  User: summer
  Date: 25. 10. 28.
  Time: 오전 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>정보수정</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 720px; margin: 40px auto; }
        h2 { margin-bottom: 16px; }
        .form-row { margin: 12px 0; }
        .form-row label { display: inline-block; width: 110px; color: #444; }
        .form-row input[type="text"],
        .form-row input[type="email"] {
            width: 320px; padding: 8px 10px; border: 1px solid #ccc; border-radius: 6px;
        }
        .actions { margin-top: 20px; }
        .btn {
            padding: 10px 18px; border: none; border-radius: 8px; cursor: pointer;
            background: #b7b4e4; color: #fff; font-weight: 600;
        }
        .btn:hover { background: #6154f1; }
        .link-btn {
            margin-left: 8px; background: #eee; color: #333;
        }
        small.hint { color: #777; display: block; margin-top: 6px; }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>
<h2>정보수정</h2>

<form method="post" action="/setting/profile">
    <!-- 서버에서는 세션의 logonUser.getId()를 사용하여 p.setId(logonUser.getId()) 처리 -->
    <div class="form-row">
        <label for="nickname">닉네임</label>
        <input id="nickname" name="nickname" type="text"
               value="<%= logonUser.getNickname() == null ? "" : logonUser.getNickname() %>" required>
    </div>

    <div class="form-row">
        <label for="name">이름</label>
        <input id="name" name="name" type="text"
               value="<%= logonUser.getName() == null ? "" : logonUser.getName() %>" required>
    </div>

    <div class="form-row">
        <label for="email">이메일</label>
        <input id="email" name="email" type="email"
               value="<%= logonUser.getEmail() == null ? "" : logonUser.getEmail() %>" required>
        <small class="hint">로그인/알림에 사용될 이메일입니다.</small>
    </div>

    <div class="form-row">
        <label for="interest">관심사</label>
        <input id="interest" name="interest" type="text"
               value="<%= logonUser.getInterest() == null ? "" : logonUser.getInterest() %>">
        <small class="hint">쉼표(,)로 여러 개 입력 가능 예) 음악, 여행, 게임</small>
    </div>

    <div class="actions">
        <button class="btn" type="submit">저장</button>
        <button class="btn link-btn" type="button" onclick="location.href='/member/editProfile.jsp'">돌아가기</button>
    </div>
</form>

</body>
</html>