# MySQL数据库配置问题解决方案

## 🔍 问题诊断
根据错误信息 `Access denied for user 'root'@'localhost' (using password: YES)`，问题是：
1. MySQL服务已安装但处于停止状态
2. 需要启动MySQL服务才能连接

## 🚀 解决步骤

### 方案1：启动MySQL服务（推荐）
1. **右键点击** `启动MySQL服务.bat` 文件
2. **选择** "以管理员身份运行"
3. 等待服务启动成功

### 方案2：手动启动MySQL服务
1. 按 `Win + R`，输入 `services.msc`
2. 找到 `MySQL80` 服务
3. 右键选择 "启动"

### 方案3：使用命令行（需要管理员权限）
```cmd
# 以管理员身份打开命令提示符
net start mysql80
```

### 方案4：检查MySQL安装位置
如果上述方法都不行，可能需要：
1. 重新安装MySQL
2. 检查MySQL配置文件
3. 重置MySQL root密码

## 🔧 配置文件说明
当前Spring配置 (`book-context.xml`)：
- 数据库：library
- 用户名：root  
- 密码：0000
- 端口：3306

## 📋 启动后的操作
1. MySQL服务启动成功后
2. 运行 `数据库修复工具.bat` 检查数据库
3. 重新启动图书管理系统
4. 尝试登录

## 🎯 测试账号
- 管理员：20170001 / 111111
- （需要先导入library.sql数据）

## ⚠️ 注意事项
- 如果密码不是0000，可能需要修改配置文件
- 确保library数据库和数据表已创建
- 首次使用需要导入library.sql文件
