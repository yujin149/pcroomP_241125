<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 처리 결과</title>
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
            margin: 5px;
        }
       
       #graybtn{
       		background-color: #eee;
       		border-radius: 5px;
       		color : black;
       }
       #dakrGreen{
       		background-color: #419992;
       		border-radius: 5px;
       		color : white;
       }
        
    </style>
</head>
<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/pcroomproject";
        conn = DriverManager.getConnection(url, "root", "1234");

        String sql = "SELECT * FROM member WHERE id = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("username", username);
            session.setAttribute("name", rs.getString("name")); // name 필드 추가
            session.setAttribute("regist_day", rs.getString("regist_day")); // 가입일 저장
            session.setAttribute("tel",rs.getString("tel"));
            session.setAttribute("mail",rs.getString("mail"));
            session.setAttribute("gender", rs.getString("gender"));
            response.sendRedirect("main.jsp"); 
            return;
        } else {
%>
    <div class="result-container">
    <h2>로그인 실패</h2>
    <p>아이디 또는 비밀번호가 잘못되었습니다.</p>
    
    <a href="findId.jsp" id="darkGreen">계정 찾기</a>
    <a href="login.jsp" id="graybtn">다시 시도</a><br>
    
    
    
</div>
    
<%
        }
    } catch (Exception e) {
%>
    <div class="result-container">
        <h2>오류 발생</h2>
        <p><%= e.getMessage() %></p>
        <a href="login.jsp">로그인 페이지 돌아가기</a>
        
    </div>
<%
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
