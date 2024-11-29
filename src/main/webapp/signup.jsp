<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <style>
    @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css");
        body {
            font-family: 'pretendard', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .signup-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05);
            width: 100%;
            max-width: 400px;
        }
        .signup-container h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            margin-bottom: 5px;
            font-size: 15px;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        .form-group button {
            width: 100%;
            padding: 10px;
            background: #419992;
            border: none;
            color: #fff;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
        }
         .form-group input:focus,
.form-group select:focus {
    border: 2px solid #419992; /* 테두리 두께를 2px로 설정 */
    outline: none; /* 기본 파란색 아웃라인 제거 */
     box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05); /* 선택 효과를 강조하는 그림자 추가 */
}

    </style>
</head>
<body>
    <div class="signup-container">
        <h2>회원가입</h2>
        <form action="signupProcess.jsp" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" placeholder="아이디를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="birthdate">생년월일</label>
                <input type="date" id="birthdate" name="birthdate" required>
            </div>
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" pattern="\d{3}-\d{4}-\d{4}" required>
            </div>
            <div class="form-group">
                <label for="mail">이메일</label>
                <input type="email" id="mail" name="mail" placeholder="example@example.com" required>
            </div>
            <div class="form-group">
                <label for="gender">성별</label>
                <select id="gender" name="gender" required>
                    <option value="male">남성</option>
                    <option value="female">여성</option>
                </select>
            </div>
            <div class="form-group">
                <button type="submit">회원가입</button>
            </div>
        </form>
    </div>
</body>
</html>
