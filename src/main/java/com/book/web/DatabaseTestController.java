package com.book.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class DatabaseTestController {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private DataSource dataSource;

    @RequestMapping("/test-database-connection")
    @ResponseBody
    public Object testDatabaseConnection() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 测试数据源连接
            Connection conn = dataSource.getConnection();
            result.put("status", "success");
            result.put("message", "数据库连接成功");
            result.put("url", conn.getMetaData().getURL());
            result.put("username", conn.getMetaData().getUserName());
            conn.close();
            
            // 测试查询
            try {
                int count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM admin", Integer.class);
                result.put("adminCount", count);
                result.put("tableStatus", "admin表存在，记录数: " + count);
            } catch (Exception e) {
                result.put("tableStatus", "admin表不存在或查询失败: " + e.getMessage());
            }
            
        } catch (SQLException e) {
            result.put("status", "error");
            result.put("message", "数据库连接失败");
            result.put("error", e.getMessage());
            result.put("sqlState", e.getSQLState());
            result.put("errorCode", e.getErrorCode());
        }
        
        return result;
    }
    
    @RequestMapping("/database-info")
    @ResponseBody
    public Object getDatabaseInfo() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Connection conn = dataSource.getConnection();
            result.put("databaseProductName", conn.getMetaData().getDatabaseProductName());
            result.put("databaseProductVersion", conn.getMetaData().getDatabaseProductVersion());
            result.put("driverName", conn.getMetaData().getDriverName());
            result.put("driverVersion", conn.getMetaData().getDriverVersion());
            result.put("url", conn.getMetaData().getURL());
            result.put("username", conn.getMetaData().getUserName());
            conn.close();
            result.put("status", "success");
        } catch (SQLException e) {
            result.put("status", "error");
            result.put("error", e.getMessage());
        }
        
        return result;
    }
}
