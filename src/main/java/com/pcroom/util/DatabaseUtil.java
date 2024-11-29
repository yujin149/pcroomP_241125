package com.pcroom.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
    public static Connection getConnection() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/pcroomproject?serverTimezone=UTC&characterEncoding=UTF-8";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
