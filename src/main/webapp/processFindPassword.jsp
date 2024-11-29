<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 결과</title>
    <link rel="stylesheet" as="style" crossorigin
        href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Pretendard', sans-serif;
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

        .result-container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
             box-shadow: 3px 5px 5px 0px rgba(55, 55, 55, 0.05);
            text-align: center;
            width: 380px;
        }

        .result-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }

        .result-container p {
            font-size: 16px;
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
        }

        .result-container a:hover {
            background-color: #357d6f;
        }
    </style>
</head>
<body>
    <div class="result-container">
<%
    String id = request.getParameter("id");
    String email = request.getParameter("mail");

    if (id == null || email == null || id.trim().isEmpty() || email.trim().isEmpty()) {
%>
        <h2>입력 오류</h2>
        <p>아이디 또는 이메일을 입력하지 않았습니다.</p>
        <a href="findPassword.jsp">다시 시도</a>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/pcroomproject";
        conn = DriverManager.getConnection(url, "root", "1234");

        String sql = "SELECT password FROM member WHERE LOWER(id) = LOWER(?) AND LOWER(mail) = LOWER(?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id.trim().toLowerCase());
        pstmt.setString(2, email.trim().toLowerCase());

        rs = pstmt.executeQuery();

        if (rs.next()) {
            String foundPassword = rs.getString("password");
%>
            <h2>비밀번호 찾기 결과</h2>
            <p>비밀번호: <b><%= foundPassword %></b></p>
            <a href="login.jsp">로그인 페이지로 돌아가기</a>
<%
        } else {
%>
            <h2>비밀번호 찾기 실패</h2>
            <p>아이디와 이메일이 일치하지 않습니다.</p>
            <a href="findId.jsp">다시 시도</a>
<%
        }
    } catch (Exception e) {
%>
        <h2>오류 발생</h2>
        <p><%= e.getMessage() %></p>
        <a href="findPassword.jsp">다시 시도</a>
<%
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
    </div>
</body>
</html>
