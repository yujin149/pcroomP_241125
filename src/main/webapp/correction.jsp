<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
<title>회원 정보 수정</title>
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

.form-container {
	background: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05);
	text-align: center;
	width: 100%;
	max-width: 400px;
}

.form-container h2 {
	margin-bottom: 20px;
	font-size: 24px;
	color: #333;
}

.form-group {
	margin-bottom: 15px;
	text-align: left;
}

.form-group label {
	display: block;
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

.form-group input[readonly] {
	background-color: #f4f4f4;
	border: 1px solid #ddd;
	cursor: not-allowed;
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

.form-group button:hover {
	background: #357d6f;
}
.form-group input:focus, .form-group select:focus {
	border: 2px solid #419992;
	outline: none; /* 기본 outline 제거 */
	box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05);
}

</style>
</head>
<body>
	<div class="form-container">
		<h2>회원 정보 수정</h2>
		<form action="correctionProcess.jsp" method="post">
			<div class="form-group">
				<label for="username">아이디</label> <input type="text" id="username"
					name="username" value="<%=session.getAttribute("username")%>"
					readonly>
			</div>
			<div class="form-group">
				<label for="regist_day">가입일</label> <input type="text"
					id="regist_day" name="regist_day"
					value="<%=session.getAttribute("regist_day")%>" readonly>
			</div>
			<div class="form-group">
				<label for="currentPassword">현재 비밀번호</label> <input type="password"
					id="currentPassword" name="currentPassword"
					placeholder="현재 비밀번호 입력" required>
			</div>
			<div class="form-group">
				<label for="newPassword">새 비밀번호</label> <input type="password"
					id="newPassword" name="newPassword" placeholder="새 비밀번호 입력">
			</div>
			<div class="form-group">
				<label for="phone">전화번호</label> <input type="tel" id="phone"
					name="phone" value="<%=session.getAttribute("tel")%>"
					pattern="\d{3}-\d{4}-\d{4}">
			</div>
			<div class="form-group">
				<label for="mail">이메일</label> <input type="email" id="mail"
					name="mail" value="<%=session.getAttribute("mail")%>">
			</div>
			<div class="form-group">
				<label for="gender">성별</label> <select id="gender" name="gender">
					<option value="male"
						<%="male".equalsIgnoreCase((String) session.getAttribute("gender")) ? "selected" : ""%>>남성</option>
					<option value="female"
						<%="female".equalsIgnoreCase((String) session.getAttribute("gender")) ? "selected" : ""%>>여성</option>
				</select>
			</div>
			
			<div class="form-group">
				<button type="submit">수정하기</button>
			</div>

		</form>
	</div>
</body>
</html>
