<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 처리 결과</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .result-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05);
            text-align: center;
            width: 100%;
            max-width: 400px;
        }
        .result-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: black;
        }
        .result-container p {
            font-size: 15px;
            margin-bottom: 20px;
            color: #333;
        }
        .result-container a {
            display: inline-block;
            text-decoration: none;
            background-color: #419992;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
            border: none;
        }
    </style>
</head>
<body>
    <div class="result-container">
<%
    String name = request.getParameter("name");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String birthdate = request.getParameter("birthdate");
    String phone = request.getParameter("phone");
    String mail = request.getParameter("mail");
    String gender = request.getParameter("gender");
    String registDay = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

    if (!password.equals(confirmPassword)) {
%>
        <h2>회원가입 실패</h2>
        <p>비밀번호가 일치하지 않습니다.</p>
        <a href="signup.jsp">다시 시도</a>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement checkStmt = null;
    PreparedStatement insertStmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/pcroomproject";
        String dbUser = "root";
        String dbPassword = "1234";
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // ID와 이메일 중복 확인
        String checkSql = "SELECT id, mail FROM Member WHERE id = ? OR mail = ?";
        checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, username);
        checkStmt.setString(2, mail);
        ResultSet rs = checkStmt.executeQuery();

        boolean isDuplicateId = false;
        boolean isDuplicateMail = false;

        while (rs.next()) {
            if (username.equals(rs.getString("id"))) {
                isDuplicateId = true;
            }
            if (mail.equals(rs.getString("mail"))) {
                isDuplicateMail = true;
            }
        }

        if (isDuplicateId) {
%>
            <h2>회원가입 실패</h2>
            <p>이미 존재하는 아이디입니다.</p>
            <a href="signup.jsp">다시 시도</a>
<%
            return;
        }

        if (isDuplicateMail) {
%>
            <h2>회원가입 실패</h2>
            <p>이미 존재하는 이메일입니다.</p>
            <a href="signup.jsp">다시 시도</a>
<%
            return;
        }

        // 중복이 없으면 회원가입 진행
        String insertSql = "INSERT INTO Member (id, password, name, gender, birth, mail, tel, regist_day) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        insertStmt = conn.prepareStatement(insertSql);
        insertStmt.setString(1, username);
        insertStmt.setString(2, password);
        insertStmt.setString(3, name);
        insertStmt.setString(4, gender);
        insertStmt.setString(5, birthdate);
        insertStmt.setString(6, mail);
        insertStmt.setString(7, phone);
        insertStmt.setString(8, registDay);

        int result = insertStmt.executeUpdate();

        if (result > 0) {
%>
            <h2>회원가입 성공</h2>
            <p>회원가입이 성공적으로 완료되었습니다!</p>
            <a href="login.jsp">로그인 페이지로 이동</a>
<%
        } else {
%>
            <h2>회원가입 실패</h2>
            <p>회원가입 중 오류가 발생했습니다. 다시 시도해주세요.</p>
            <a href="signup.jsp">다시 시도</a>
<%
        }
    } catch (Exception e) {
%>
        <h2>회원가입 실패</h2>
        <p>알 수 없는 오류가 발생했습니다: <%= e.getMessage() %></p>
        <a href="signup.jsp">다시 시도</a>
<%
    } finally {
        if (checkStmt != null) checkStmt.close();
        if (insertStmt != null) insertStmt.close();
        if (conn != null) conn.close();
    }
%>
    </div>
</body>
</html>
