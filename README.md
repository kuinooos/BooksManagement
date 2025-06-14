# 图书管理系统
#### 基于Spring+Spring MVC(Maven方式构建)
[![Build Status](https://travis-ci.org/withstars/Books-Management-System.svg?branch=master)](https://travis-ci.org/withstars/Books-Management-System)
[![Hex.pm](https://img.shields.io/hexpm/l/plug.svg)](https://github.com/withstars/Books-Management-System)
### 项目简介
本图书管理系统基于spring,spring mvc,数据库为mysql。前端使用了Bootstrap。 
### 系统功能
该系统实现读者和管理员登陆，图书的增删改查，读者的增删改查，借还图书，密码修改，卡号挂失，超期提醒等功能。
### 如何使用（2025年6月更新版）
**重要：本项目已完成关键修复，支持MySQL 5.7和8.0版本**

#### 🚀 快速启动步骤：
```bash
# 1. 导入数据库（使用多版本兼容的library.sql）
# 方式一：使用导入工具（推荐）
MySQL版本兼容数据库导入工具.bat

# 方式二：手动导入
mysql -u root -p < library.sql

# 2. 进入项目目录
cd Books-Management-System

# 3. 标准Maven构建和启动流程
mvn clean compile
mvn clean package  
mvn clean install
mvn jetty:run

# 4. 访问系统
http://localhost:9000
```

#### 🛠️ 一键启动（Windows）：
```bash
# 自动检测MySQL版本并启动（推荐）
标准启动流程.bat

# 手动切换MySQL配置（可选）
MySQL版本配置切换工具.bat
```

#### 📋 MySQL版本支持：
- ✅ **MySQL 5.7.x** - 完全兼容（自动移除serverTimezone参数）
- ✅ **MySQL 8.0.x** - 完全支持（包含时区优化）
- ✅ **MariaDB 10.x** - 兼容支持

#### 🔧 系统特性：
- ✅ 支持长ISBN（20位）
- ✅ 支持中文字符完美显示
- ✅ 扩展的用户信息字段
- ✅ 修复HTTP 400/500错误
- ✅ 改进的用户体验（错误时不跳转页面）
- ✅ JDBC兼容性修复
- ✅ 多MySQL版本自动适配

#### 🔑 默认登录信息：
- **管理员**：admin_id: 20170001, password: 111111
- **读者**：reader_id: 1501014101, password: 111111

#### ⚠️ 故障排除：
如果遇到连接问题：
1. 运行`MySQL版本配置切换工具.bat`选择正确的MySQL版本
2. 确保MySQL服务正在运行
3. 检查用户名密码是否正确
4. 对于MySQL 5.7，确保没有时区相关错误
### 说明<br/>
1. 如果使用该项目出现问题，请联系我 withstars@126.com
2. 如果该项目对您有帮助,请star鼓励我
### 下一步:整合MyBatis 个人博客系统<br/>
*https://github.com/withstars/Blog-System*
### 本项目截图<br/>
<img src="https://github.com/ValueStar/Books-Management-System/blob/master/preview/1.PNG">
<img src="https://github.com/ValueStar/Books-Management-System/blob/master/preview/2.PNG">
<img src="https://github.com/ValueStar/Books-Management-System/blob/master/preview/3.PNG">
<img src="https://github.com/ValueStar/Books-Management-System/blob/master/preview/4.PNG">
<img src="https://github.com/ValueStar/Books-Management-System/blob/master/preview/5.PNG">
<img src="https://github.com/ValueStar/Books-Management-System/blob/master/preview/6.PNG">
