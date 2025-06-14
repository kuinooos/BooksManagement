package com.book.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class TestController {

    @Autowired
    private JdbcTemplate jdbcTemplate;    @RequestMapping("/test-db")
    @ResponseBody
    public Object testDatabase() {
        Map<String, Object> result = new HashMap<>();
        try {
            // 测试数据库连接
            int count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM admin", Integer.class);
            result.put("status", "success");
            result.put("message", "数据库连接成功");
            result.put("adminCount", count);
            return result;
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", "数据库连接失败: " + e.getMessage());
            return result;
        }
    }

    @RequestMapping("/test-login-api")
    @ResponseBody
    public Object testLoginAPI() {
        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("message", "API端点正常");
        result.put("timestamp", System.currentTimeMillis());
        return result;
    }
}
