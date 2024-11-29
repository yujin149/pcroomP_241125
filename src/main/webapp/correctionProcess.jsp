<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정보 수정 처리 결과</title>
    <style>
        body {
            font-family: 'Pretendard', sans-serif;
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
            color: #333;
        }
        .result-container p {
            font-size: 15px;
            margin-bottom: 20px;
            color: #555;
        }
        .result-container a {
            display: inline-block;
            text-decoration: none;
            background-color: #419992;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
            margin: 5px;
            transition: background-color 0.3s ease;
        }
        .result-container a:hover {
            background-color: #357d6f;
        }
        .result-container .gray-btn {
            background-color: #eee;
            color: black;
            border: 1px solid #ddd;
        }
        .result-container .gray-btn:hover {
            background-color: #ddd;
        }
    </style>
</head>

<body>
    <div class="result-container">
<%
    String username = request.getParameter("username");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String phone = request.getParameter("phone");
    String mail = request.getParameter("mail");
    String gender = request.getParameter("gender");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/pcroomproject";
        conn = DriverManager.getConnection(url, "root", "1234");

        // 현재 비밀번호 확인
        String checkPasswordSql = "SELECT * FROM member WHERE id = ?";
        pstmt = conn.prepareStatement(checkPasswordSql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String dbPassword = rs.getString("password");
            String currentPhone = rs.getString("tel");
            String currentMail = rs.getString("mail");
            String currentGender = rs.getString("gender");

            if (!dbPassword.equals(currentPassword)) {
%>
                <h2>수정 실패</h2>
                <p>현재 비밀번호가 일치하지 않습니다.</p>
                <a href="correction.jsp" class="gray-btn">다시 시도</a>
<%
                return;
            }

            // 입력값이 비어 있다면 기존 값을 유지
            phone = (phone == null || phone.isEmpty()) ? currentPhone : phone;
            mail = (mail == null || mail.isEmpty()) ? currentMail : mail;
            gender = (gender == null || gender.isEmpty()) ? currentGender : gender;
            newPassword = (newPassword == null || newPassword.isEmpty()) ? currentPassword : newPassword;

            // 업데이트 쿼리 작성
            String updateSql = "UPDATE member SET password = ?, tel = ?, mail = ?, gender = ? WHERE id = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, newPassword);
            pstmt.setString(2, phone);
            pstmt.setString(3, mail);
            pstmt.setString(4, gender);
            pstmt.setString(5, username);

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
%>
                <h2>수정 성공</h2>
                <p>정보가 성공적으로 수정되었습니다.</p>
                <a href="login.jsp">로그인 페이지로 이동</a>
<%
            } else {
%>
                <h2>수정 실패</h2>
                <p>정보 수정에 실패했습니다.</p>
                <a href="correction.jsp" class="gray-btn">다시 시도</a>
<%
            }
        } else {
%>
            <h2>수정 실패</h2>
            <p>사용자를 찾을 수 없습니다.</p>
            <a href="login.jsp">로그인 페이지로 이동</a>
<%
        }

    } catch (Exception e) {
%>
        <h2>오류 발생</h2>
        <p><%= e.getMessage() %></p>
        <a href="correction.jsp" class="gray-btn">다시 시도</a>
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
