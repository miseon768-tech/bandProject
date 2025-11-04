<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 11. 4.
  Time: 오전 9:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>밴드수정</title>
</head>
<body>
<div class="main">
    <div style="flex:1">

    </div>
    <div style="flex : 4">
        <h3>회원정보</h3>
        <form class="signup-form" action="/community/edit" method="post">
            <div>
                <label for="email"><small>이메일</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="email" id="email" value="${member.email}"
                           placeholder="test@test.com"/>
                </div>
            </div>
            <div>
                <label for="name"><small>실명</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="name" id="name" value="${member.name}"
                           placeholder="홍길동">
                </div>
            </div>
            <div>
                <label for="nickname"><small>닉네임</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="nickname" id="nickname"
                           value="${member.nickname}"
                           placeholder="별명을 알파벳,한글,숫자 20자 이하로 입력해주세요.">
                </div>
            </div>
            <div>
                <label for="interest"><small>관심태그</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="interest" id="interest"
                           placeholder="백엔드,프론트엔드,모바일,취업,신기술,,," value="${member.interest}">
                </div>
            </div>
            <div>
                <div style="display: flex; justify-content: space-between">
                    <label><small>이메일 수신동의</small></label>
                    <div>
                        <input type="checkbox" name="agree" value="true"
                        ${member.agree ? 'checked' : ''}/>
                    </div>
                </div>
                <div class="text-gray mt-1">
                    가제에서 주최하는 다양한 이벤트, 정보성 뉴스레터 및 광고 수신여부를 설정할 수 있습니다
                </div>
            </div>
            <div>
                <button class="bt-submit">저장</button>
            </div>
        </form>
    </div>
    <div style="flex:1">

    </div>
</div>
</body>
</html>

</body>
</html>
