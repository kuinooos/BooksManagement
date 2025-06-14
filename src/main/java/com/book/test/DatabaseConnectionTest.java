package com.book.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnectionTest {
    
    // 修复后的连接字符串 - 使用utf8而非utf8mb4
    private static final String URL = "jdbc:mysql://localhost:3306/library?useSSL=false&allowPublicKeyRetrieval=true&createDatabaseIfNotExist=true&characterEncoding=utf8&useUnicode=true&serverTimezone=Asia/Shanghai&autoReconnect=true&useAffectedRows=true";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "chen20040421";
    
    public static void main(String[] args) {
        testConnection();
        testChineseCharacters();
    }
    
    public static void testConnection() {
        System.out.println("=== 数据库连接测试 ===");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
            System.out.println("✅ 数据库连接成功！");
            System.out.println("连接信息：" + conn.toString());
            
            // 测试字符集设置
            java.sql.Statement stmt = conn.createStatement();
            java.sql.ResultSet rs = stmt.executeQuery("SELECT @@character_set_database, @@collation_database, @@character_set_connection");
            
            if (rs.next()) {
                System.out.println("数据库字符集：" + rs.getString(1));
                System.out.println("数据库排序规则：" + rs.getString(2));
                System.out.println("连接字符集：" + rs.getString(3));
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL JDBC驱动未找到：" + e.getMessage());
        } catch (SQLException e) {
            System.out.println("❌ 数据库连接失败：" + e.getMessage());
            System.out.println("错误代码：" + e.getErrorCode());
            System.out.println("SQL状态：" + e.getSQLState());
        }
    }
    
    public static void testChineseCharacters() {
        System.out.println("\n=== 中文字符测试 ===");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
            // 测试中文字符的插入和查询
            java.sql.Statement stmt = conn.createStatement();
            
            // 查询现有的中文图书
            java.sql.ResultSet rs = stmt.executeQuery("SELECT book_name, author FROM book_info WHERE book_name LIKE '%雪%' OR author LIKE '%东野%' LIMIT 5");
            
            System.out.println("现有中文图书：");
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                System.out.println("书名：" + rs.getString("book_name"));
                System.out.println("作者：" + rs.getString("author"));
                System.out.println("---");
            }
            
            if (!hasData) {
                System.out.println("未找到中文图书数据，请检查数据是否已正确导入");
            }
            
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            System.out.println("❌ 中文字符测试失败：" + e.getMessage());
        }
    }
}
