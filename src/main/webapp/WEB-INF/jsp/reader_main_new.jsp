<%--
  现代化图书管理系统 - 读者主页
  全新设计: 现代化界面、响应式布局
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📚 ${readercard.name}的图书馆</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            border: none;
            border-radius: 0;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5em;
            color: #667eea !important;
        }
        
        .navbar-nav > li > a {
            font-weight: 500;
            color: #333 !important;
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 0 5px;
        }
        
        .navbar-nav > li > a:hover,
        .navbar-nav > li.active > a {
            color: white !important;
            background: linear-gradient(135deg, #667eea, #764ba2) !important;
        }
        
        .main-content {
            margin-top: 80px;
            padding: 40px 20px;
        }
        
        .welcome-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .welcome-section h1 {
            color: #667eea;
            font-size: 2.5em;
            margin-bottom: 15px;
            font-weight: 700;
        }
        
        .welcome-section p {
            color: #666;
            font-size: 1.2em;
            margin-bottom: 30px;
        }
        
        .user-info {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            border-top: 4px solid transparent;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
        }
        
        .feature-card.search {
            border-top-color: #667eea;
        }
        
        .feature-card.info {
            border-top-color: #764ba2;
        }
        
        .feature-card.lend {
            border-top-color: #f093fb;
        }
        
        .feature-card.password {
            border-top-color: #f5576c;
        }
        
        .feature-icon {
            font-size: 3em;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .feature-title {
            font-size: 1.5em;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        
        .feature-description {
            color: #666;
            font-size: 1em;
            margin-bottom: 20px;
        }
        
        .feature-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        .feature-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            color: white;
            text-decoration: none;
        }
        
        .stats-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
            border-radius: 12px;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
        }
        
        .stat-number {
            font-size: 2.5em;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 1em;
            font-weight: 500;
        }
        
        @media (max-width: 768px) {
            .welcome-section h1 {
                font-size: 2em;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="reader_main.html">
                    <i class="fas fa-book-reader"></i> 我的图书馆
                </a>
            </div>
            <div class="collapse navbar-collapse" id="navbar-collapse">
                <ul class="nav navbar-nav navbar-left">
                    <li class="active">
                        <a href="reader_querybook.html">
                            <i class="fas fa-search"></i> 图书查询
                        </a>
                    </li>
                    <li>
                        <a href="reader_info.html">
                            <i class="fas fa-user"></i> 个人信息
                        </a>
                    </li>
                    <li>
                        <a href="mylend.html">
                            <i class="fas fa-book"></i> 我的借还
                        </a>
                    </li>
                    <li>
                        <a href="reader_repasswd.html">
                            <i class="fas fa-key"></i> 密码修改
                        </a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#">
                            <i class="fas fa-user-circle"></i> ${readercard.name}
                        </a>
                    </li>
                    <li>
                        <a href="logout.html">
                            <i class="fas fa-sign-out-alt"></i> 退出
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="main-content">
        <div class="welcome-section">
            <h1><i class="fas fa-book-reader"></i> 欢迎来到智慧图书馆</h1>
            <p>探索知识的海洋，发现阅读的乐趣</p>
            
            <div class="user-info">
                <h3><i class="fas fa-user"></i> ${readercard.name}</h3>
                <p>读者编号: ${readercard.readerId} | 状态: 正常</p>
            </div>
        </div>

        <div class="features-grid">
            <div class="feature-card search">
                <div class="feature-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3 class="feature-title">图书查询</h3>
                <p class="feature-description">搜索您感兴趣的图书，查看详细信息和借阅状态</p>
                <a href="reader_querybook.html" class="feature-btn">开始搜索</a>
            </div>

            <div class="feature-card info">
                <div class="feature-icon">
                    <i class="fas fa-user-edit"></i>
                </div>
                <h3 class="feature-title">个人信息</h3>
                <p class="feature-description">查看和编辑您的个人资料信息</p>
                <a href="reader_info.html" class="feature-btn">查看信息</a>
            </div>

            <div class="feature-card lend">
                <div class="feature-icon">
                    <i class="fas fa-book"></i>
                </div>
                <h3 class="feature-title">我的借还</h3>
                <p class="feature-description">查看您的借书记录和归还状态</p>
                <a href="mylend.html" class="feature-btn">查看记录</a>
            </div>

            <div class="feature-card password">
                <div class="feature-icon">
                    <i class="fas fa-key"></i>
                </div>
                <h3 class="feature-title">密码修改</h3>
                <p class="feature-description">为了账户安全，定期更改您的登录密码</p>
                <a href="reader_repasswd.html" class="feature-btn">修改密码</a>
            </div>
        </div>

        <div class="stats-section">
            <h3><i class="fas fa-chart-bar"></i> 我的统计</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">15</div>
                    <div class="stat-label">已借图书</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">48</div>
                    <div class="stat-label">历史借阅</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">3</div>
                    <div class="stat-label">待归还</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">12</div>
                    <div class="stat-label">本月借阅</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // 添加页面加载动画
            $('.feature-card').each(function(index) {
                $(this).delay(index * 100).animate({
                    opacity: 1
                }, 500);
            });
        });
    </script>
</body>
</html>
