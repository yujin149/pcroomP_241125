<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    
    <style>
    @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css");
    *{
    font-family: 'pretendard', sans-serif;
    }
    </style>
</head>
<body>
    <form action="processFindPassword.jsp" method="post">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" placeholder="아이디를 입력하세요" required>
        <label for="mail">이메일:</label>
        <input type="email" id="mail" name="mail" placeholder="example@example.com" required>
        <button type="submit">비밀번호 찾기</button>
    </form>
</body>
</html>
