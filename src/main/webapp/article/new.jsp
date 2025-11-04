<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새 글 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
    <style>
        .write-wrapper { width:600px; margin:60px auto; background:var(--cream); border-radius:12px; padding:30px; box-shadow:0 4px 10px rgba(0,0,0,0.1); }
        .write-wrapper h2 { text-align:center; margin-bottom:20px; color:var(--maroon); }
        .write-wrapper label { display:block; margin-top:15px; font-weight:bold; }
        .write-wrapper input, .write-wrapper textarea, .write-wrapper select {
            width:100%; padding:10px; border:1px solid var(--line); border-radius:8px; font-size:15px;
        }
        .write-wrapper textarea { height:150px; resize:none; }
        .btn-row { display:flex; gap:10px; margin-top:20px; }
        .btn { flex:1; background:var(--sunray); border:none; color:var(--maroon); padding:12px 20px; font-size:16px; border-radius:8px; cursor:pointer; transition:.2s; }
        .btn:hover { background:var(--vanilla); }
        .btn.cancel { background:#eee; color:#333; }
        .btn.cancel:hover { background:#ddd; }
    </style>
</head>
<body>
<div class="write-wrapper">
    <h2>새 글 작성</h2>


    <form action="${pageContext.request.contextPath}/article/new" method="post" autocomplete="off">
        <!-- 주제 -->
        <label for="topic">주제</label>
        <select name="topic" id="topic" required>
            <option value="">-- 선택하세요 --</option>
            <option value="공지">공지</option>
            <option value="자유">자유</option>
            <option value="질문">질문</option>
        </select>

        <!-- 제목 -->
        <label for="title">제목</label>
        <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required/>

        <!-- 내용 -->
        <label for="content">내용</label>
        <textarea id="content" name="content" placeholder="내용을 입력하세요" required></textarea>



        <div class="btn-row">
            <button type="button" class="btn cancel" onclick="location.href='${pageContext.request.contextPath}/community'">취소</button>
            <button type="submit" class="btn">등록하기</button>
        </div>
    </form>
</div>
</body>
</html>
