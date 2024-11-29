<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 결과</title>
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
    String email = request.getParameter("mail");
    if (email != null) email = email.trim().toLowerCase();

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/pcroomproject";
        conn = DriverManager.getConnection(url, "root", "1234");

        String sql = "SELECT id FROM member WHERE LOWER(mail) = LOWER(?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            String foundId = rs.getString("id");
%>
            <h2>아이디 찾기 결과</h2>
            <p>아이디: <b><%= foundId %></b></p>
            <a href="login.jsp">로그인 페이지로 돌아가기</a>
<%
        } else {
%>
            <h2>아이디 찾기 실패</h2>
            <p>입력하신 이메일로 등록된 아이디가 없습니다.</p>
            <a href="findId.jsp">다시 시도</a>
<%
        }
    } catch (Exception e) {
%>
        <h2>오류 발생</h2>
        <p><%= e.getMessage() %></p>
        <a href="findId.jsp">다시 시도</a>
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
