package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLConnect {
	private Connection connection;

    public SQLConnect()  {
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pcroomproject", "root", "1234");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("데이터베이스 연결 실패: " + e.getMessage()); // 추가적인 에러 메시지 출력
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("MySQL 드라이버 로드 실패: " + e.getMessage()); // 드라이버 로딩 실패 처리
        }
    }

    public Connection getConnection() {
        return connection;
    }
    // 연결 종료 메서드 추가
    public void close() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}



