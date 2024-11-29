<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>로그인</title>
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

.login-container {
	border-radius: 10px;
	 box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05);
	padding: 30px;
	width: 380px;
	text-align: center;
	background: #fff;
}

.login-container h2 {
	margin-bottom: 20px;
	font-size: 24px;
	color: #333;
}

.login-container label {
	display: block;
	text-align: left;
	margin-bottom: 5px;
	font-weight: bold;
}

.login-container input {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 3px;
	box-sizing: border-box;
}

.login-container input:focus {
	border: 2px solid #419992;
	outline: none; /* 기본 파란색 outline 제거 */
	 box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05); /* 약간의 그림자 추가 (선택사항) */
}

.login-container button {
	width: 100%;
	padding: 10px;
	border: none;
	background-color: #419992;
	color: white;
	font-size: 15px;
	border-radius: 5px;
	cursor: pointer;
	margin-bottom: 10px;
}

.login-container a {
	text-decoration: none;
	color: #007BFF;
	font-size: 15px;
}

.error-message {
	color: red;
	margin-top: 10px;
}

.graybutton {
	display: block; /* 블록 요소로 설정 */
	text-align: center;
	background: #eee;
	width: 100%; /* 로그인 버튼과 동일한 너비 */
	padding: 10px;
	border: none;
	font-size: 15px;
	border-radius: 5px;
	cursor: pointer;
}

.graybutton a {
	color: black; /* 텍스트 색상을 명시적으로 지정 */
	text-decoration: none;
	display: block; /* 버튼처럼 보이도록 블록 요소 설정 */
}

.find {
	width: 100%;
	padding: 10px;
	border: none;
	background-color: #419992;
	color: white;
	font-size: 15px;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
}

.find a {
	color: white;
}

.login-container .btnWrap .subBtn {
	display: flex;
	justify-content: center;
	align-items: center;
	list-style: none;
	padding: 0;
	margin:0;
}
.login-container .btnWrap .subBtn li a{font-size:13px; color: #888; font-weight: 600; padding: 5px 10px; position:relative;}
.login-container .btnWrap .subBtn li:first-child a:after{content:''; display:block; width:1px; height:10px; 
position:absolute; top:50%; right:0; transform:translateY(-50%); background:#888;}
</style>

</head>
<body>
	<div class="login-container">
		<h2>로그인</h2>
		<form action="loginProcess.jsp" method="post">
			<label for="username">아이디</label> <input type="text" id="username"
				name="username" placeholder="아이디를 입력하세요" required> <label
				for="password">비밀번호</label> <input type="password" id="password"
				name="password" placeholder="비밀번호를 입력하세요" required>


			<div class="btnWrap">
				<button type="submit">로그인</button>
				<ul class="subBtn">
					<li><a href="signup.jsp">회원가입</a></li>
					<li><a href="findId.jsp">계정 찾기</a></li>
				</ul>
				
			</div>
		</form>



		<!-- 에러 메시지 표시 -->
		<%
		String errorMessage = (String) request.getAttribute("errorMessage");
		if (errorMessage != null) {
		%>
		<p class="error-message"><%=errorMessage%></p>
		<%
		}
		%>
	</div>
</body>
</html>
