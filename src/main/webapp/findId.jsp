<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>계정 찾기</title>
    <link rel="stylesheet" as="style" crossorigin
        href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <style>
    @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css");
        * {
            box-sizing: border-box;
            font-family: 'pretendard', sans-serif;
            font-size: 15px;
        }

        body {
            margin: 0;
            padding: 0;
            background: #eee;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .find-container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
             box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05);
            text-align: center;
            width: 380px;
        }

        .find-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }

        .find-container form {
            margin-bottom: 20px;
        }

        .find-container label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .find-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        .find-container input:focus {
            border: 2px solid #419992;
            outline: none;
             box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05);
        }

        .find-container button {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #419992;
            color: white;
            font-size: 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .find-container button:hover {
            background-color: #357d6f;
        }
    </style>
</head>
<body>
    <div class="find-container">
        <h2>계정 찾기</h2>
        <form action="processFindId.jsp" method="post">
            <label for="mail">등록된 이메일:</label>
            <input type="email" id="mail" name="mail" placeholder="이메일을 입력하세요" required>
            <button type="submit">아이디 찾기</button>
        </form>

        <form action="processFindPassword.jsp" method="post">
            <label for="id">아이디:</label>
            <input type="text" id="id" name="id" placeholder="아이디를 입력하세요" required>
            <label for="mail">이메일:</label>
            <input type="email" id="mail" name="mail" placeholder="example@example.com" required>
            <button type="submit">비밀번호 찾기</button>
        </form>
    </div>
</body>
</html>
