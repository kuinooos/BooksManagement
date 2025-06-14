<%--
  管理员主页 - 现代化仪表板设计
  特色: 卡片式布局、数据可视化、响应式设计
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📊 管理员仪表板 - 智慧图书馆</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        /* 现代化导航栏 */
        .modern-navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: none;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }
        
        .navbar-brand {
            font-size: 1.5em;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .navbar-nav > li > a {
            color: #333 !important;
            font-weight: 500;
            padding: 12px 20px !important;
            border-radius: 8px;
            margin: 0 5px;
            transition: all 0.3s ease;
        }
        
        .navbar-nav > li > a:hover {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white !important;
            transform: translateY(-2px);
        }
        
        .dropdown-menu {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            backdrop-filter: blur(20px);
            background: rgba(255, 255, 255, 0.95);
            margin-top: 10px;
        }
        
        .dropdown-menu > li > a {
            padding: 12px 20px;
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 5px;
        }
        
        .dropdown-menu > li > a:hover {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        
        /* 主要内容区域 */
        .main-content {
            margin-top: 100px;
            padding: 30px;
        }
        
        /* 欢迎横幅 */
        .welcome-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 40px;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .welcome-banner::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(50px, -50px);
        }
        
        .welcome-banner h1 {
            font-size: 2.5em;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .welcome-banner p {
            font-size: 1.2em;
            opacity: 0.9;
        }
        
        /* 统计卡片 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }
        
        .stat-icon {
            font-size: 3em;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .stat-number {
            font-size: 2.5em;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 1.1em;
            font-weight: 500;
        }
        
        /* 快速操作区域 */
        .quick-actions {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .quick-actions h3 {
            color: #333;
            margin-bottom: 25px;
            font-weight: 600;
        }
        
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .action-btn {
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            font-weight: 600;
        }
        
        .action-btn:hover {
            color: white;
            text-decoration: none;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        .action-btn i {
            display: block;
            font-size: 2em;
            margin-bottom: 10px;
        }
        
        /* 最近活动 */
        .recent-activity {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .recent-activity h3 {
            color: #333;
            margin-bottom: 25px;
            font-weight: 600;
        }
        
        .activity-item {
            padding: 15px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }
        
        .activity-content {
            flex: 1;
        }
        
        .activity-text {
            font-weight: 500;
            color: #333;
        }
        
        .activity-time {
            color: #666;
            font-size: 0.9em;
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .main-content {
                padding: 15px;
            }
            
            .welcome-banner {
                padding: 25px;
            }
            
            .welcome-banner h1 {
                font-size: 2em;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- 现代化导航栏 -->
    <nav class="navbar navbar-default modern-navbar" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="admin_main.html">
                    <i class="fas fa-book"></i> 智慧图书馆
                </a>
            </div>
            <div class="collapse navbar-collapse" id="navbar-collapse">
                <ul class="nav navbar-nav navbar-left">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-book"></i> 图书管理 <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="allbooks.html"><i class="fas fa-list"></i> 全部图书</a></li>
                            <li class="divider"></li>
                            <li><a href="book_add.html"><i class="fas fa-plus"></i> 增加图书</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-users"></i> 读者管理 <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="allreaders.html"><i class="fas fa-list"></i> 全部读者</a></li>
                            <li class="divider"></li>
                            <li><a href="reader_add.html"><i class="fas fa-plus"></i> 增加读者</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-exchange-alt"></i> 借还管理 <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="lendlist.html"><i class="fas fa-history"></i> 借还日志</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="admin_repasswd.html">
                            <i class="fas fa-key"></i> 密码修改
                        </a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="reader_info.html">
                            <i class="fas fa-user"></i> ${admin.adminId}，已登录
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

    <!-- 主要内容 -->
    <div class="main-content">
        <!-- 欢迎横幅 -->
        <div class="welcome-banner">
            <h1><i class="fas fa-tachometer-alt"></i> 管理员仪表板</h1>
            <p>欢迎回来，${admin.adminId}！今天又是充满活力的一天</p>
        </div>

        <!-- 统计卡片 -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-book"></i>
                </div>
                <div class="stat-number" id="total-books">1,234</div>
                <div class="stat-label">图书总数</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-number" id="total-readers">567</div>
                <div class="stat-label">注册读者</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-book-reader"></i>
                </div>
                <div class="stat-number" id="borrowed-books">89</div>
                <div class="stat-label">当前借出</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-number" id="today-activities">23</div>
                <div class="stat-label">今日活动</div>
            </div>
        </div>

        <!-- 快速操作 -->
        <div class="quick-actions">
            <h3><i class="fas fa-rocket"></i> 快速操作</h3>
            <div class="action-buttons">
                <a href="book_add.html" class="action-btn">
                    <i class="fas fa-plus"></i>
                    添加新图书
                </a>
                <a href="reader_add.html" class="action-btn">
                    <i class="fas fa-user-plus"></i>
                    添加新读者
                </a>
                <a href="allbooks.html" class="action-btn">
                    <i class="fas fa-search"></i>
                    查看所有图书
                </a>
                <a href="lendlist.html" class="action-btn">
                    <i class="fas fa-history"></i>
                    借还记录
                </a>
            </div>
        </div>

        <!-- 最近活动 -->
        <div class="recent-activity">
            <h3><i class="fas fa-clock"></i> 最近活动</h3>
            <div class="activity-item">
                <div class="activity-icon">
                    <i class="fas fa-book"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-text">新增图书《JavaScript高级程序设计》</div>
                    <div class="activity-time">2分钟前</div>
                </div>
            </div>
            <div class="activity-item">
                <div class="activity-icon">
                    <i class="fas fa-user"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-text">读者 张三 归还了《数据结构与算法》</div>
                    <div class="activity-time">15分钟前</div>
                </div>
            </div>
            <div class="activity-item">
                <div class="activity-icon">
                    <i class="fas fa-book-reader"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-text">读者 李四 借阅了《计算机网络》</div>
                    <div class="activity-time">1小时前</div>
                </div>
            </div>
            <div class="activity-item">
                <div class="activity-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-text">新注册读者 王五</div>
                    <div class="activity-time">2小时前</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 数字动画效果
        function animateNumber(element, target) {
            let current = 0;
            const increment = target / 50;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    current = target;
                    clearInterval(timer);
                }
                document.getElementById(element).textContent = Math.floor(current).toLocaleString();
            }, 30);
        }
        
        // 页面加载完成后启动动画
        $(document).ready(function() {
            setTimeout(() => {
                animateNumber('total-books', 1234);
                animateNumber('total-readers', 567);
                animateNumber('borrowed-books', 89);
                animateNumber('today-activities', 23);
            }, 500);
        });
    </script>
</body>
</html>
