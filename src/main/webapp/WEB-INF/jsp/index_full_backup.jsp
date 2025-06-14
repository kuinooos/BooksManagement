<%--
  图书管理系统 - 现代化登录页面
  全新设计: 渐变背景、动画效果、响应式布局
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📚 智慧图书馆 - 现代化管理平台</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/js.cookie.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
            position: relative;
        }
        
        /* 动态背景动画 */
        .background-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2;
            background: linear-gradient(-45deg, #667eea, #764ba2, #f093fb, #f5576c, #4facfe, #00f2fe);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
        }
        
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            25% { background-position: 100% 50%; }
            50% { background-position: 100% 100%; }
            75% { background-position: 0% 100%; }
            100% { background-position: 0% 50%; }
        }
        
        /* 浮动粒子 */
        .floating-particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }
        
        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 20s infinite linear;
        }
        
        .particle:nth-child(1) { width: 20px; height: 20px; left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 15px; height: 15px; left: 20%; animation-delay: 2s; }
        .particle:nth-child(3) { width: 25px; height: 25px; left: 30%; animation-delay: 4s; }
        .particle:nth-child(4) { width: 18px; height: 18px; left: 40%; animation-delay: 6s; }
        .particle:nth-child(5) { width: 22px; height: 22px; left: 50%; animation-delay: 8s; }
        .particle:nth-child(6) { width: 16px; height: 16px; left: 60%; animation-delay: 10s; }
        .particle:nth-child(7) { width: 24px; height: 24px; left: 70%; animation-delay: 12s; }
        .particle:nth-child(8) { width: 19px; height: 19px; left: 80%; animation-delay: 14s; }
        
        @keyframes float {
            0% { transform: translateY(100vh) rotate(0deg); opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { transform: translateY(-100px) rotate(360deg); opacity: 0; }
        }
        
        /* 登录容器 */
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 50px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            animation: slideInUp 0.8s ease-out;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
        
        /* 登录头部 */
        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .login-header .logo {
            font-size: 3em;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: pulse 2s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .login-header h1 {
            color: #333;
            font-size: 2.2em;
            font-weight: 700;
            margin-bottom: 8px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .login-header p {
            color: #666;
            font-size: 1.1em;
            font-weight: 400;
        }
        
        /* 用户类型选择 */
        .user-type-selector {
            display: flex;
            margin-bottom: 35px;
            background: #f8f9fa;
            border-radius: 15px;
            padding: 6px;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .user-type-btn {
            flex: 1;
            padding: 15px;
            text-align: center;
            background: transparent;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            color: #666;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        
        .user-type-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }
        
        .user-type-btn:hover:before {
            left: 100%;
        }
        
        .user-type-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            transform: translateY(-2px);
        }
        
        .user-type-btn i {
            margin-right: 8px;
            font-size: 1.1em;
        }
        
        /* 表单样式 */
        .form-group {
            position: relative;
            margin-bottom: 25px;
        }
        
        .form-control {
            width: 100%;
            padding: 18px 25px 18px 55px;
            border: 2px solid #e1e8ed;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #fff;
            font-weight: 500;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
            transform: translateY(-2px);
        }
        
        .form-control::placeholder {
            color: #999;
            font-weight: 400;
        }
        
        .form-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 18px;
            z-index: 2;
        }
        
        /* 登录按钮 */
        .btn-login {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 25px;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }
        
        .btn-login:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
        }
        
        .btn-login:hover:before {
            left: 100%;
        }
        
        .btn-login:active {
            transform: translateY(-1px);
        }
        
        /* 错误提示 */
        .alert {
            border-radius: 12px;
            margin-bottom: 25px;
            border: none;
            padding: 15px 20px;
            animation: slideInDown 0.5s ease-out;
        }
        
        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border-left: 4px solid #dc3545;
        }
        
        .alert-info {
            background: rgba(0, 123, 255, 0.1);
            color: #007bff;
            border-left: 4px solid #007bff;
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .login-container {
                margin: 10px;
                padding: 30px;
            }
            
            .login-header h1 {
                font-size: 1.8em;
            }
            
            .login-header .logo {
                font-size: 2.5em;
            }
        }
    </style>
</head>
<body>
    <div class="background-animation"></div>
    <div class="floating-particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>
    
    <div class="login-container">
        <div class="login-header">
            <div class="logo">📚</div>
            <h1>智慧图书馆</h1>
            <p id="subtitle">现代化图书管理平台</p>
        </div>
        
        <c:if test="${!empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        
        <div id="message-area"></div>
        
        <div class="user-type-selector">
            <button type="button" class="user-type-btn active" onclick="switchUserType('reader')">
                <i class="fas fa-user"></i> 读者登录
            </button>
            <button type="button" class="user-type-btn" onclick="switchUserType('admin')">
                <i class="fas fa-user-shield"></i> 管理员
            </button>
        </div>
        
        <form id="loginForm">
            <div class="form-group">
                <i class="fas fa-id-card form-icon"></i>
                <input type="text" class="form-control" id="id" name="id" placeholder="请输入读者账号" required>
            </div>
            
            <div class="form-group">
                <i class="fas fa-lock form-icon"></i>
                <input type="password" class="form-control" id="passwd" name="passwd" placeholder="请输入密码" required>
            </div>
            
            <input type="hidden" name="userType" id="userType" value="reader">
            
            <button type="submit" class="btn-login" id="loginButton">
                <i class="fas fa-sign-in-alt"></i> 登录系统
            </button>
        </form>
    </div>
    
    <script>
        function switchUserType(type) {
            // 切换标签样式
            $('.user-type-btn').removeClass('active');
            event.target.classList.add('active');
            
            // 设置用户类型
            document.getElementById('userType').value = type;
            
            // 更新占位符文本和副标题
            if (type === 'admin') {
                document.getElementById('id').placeholder = '请输入管理员账号';
                document.getElementById('subtitle').textContent = '管理员后台 - 图书馆管理中心';
            } else {
                document.getElementById('id').placeholder = '请输入读者账号';
                document.getElementById('subtitle').textContent = '现代化图书管理平台';
            }
        }
        
        function showMessage(message, type = 'info') {
            const messageArea = document.getElementById('message-area');
            messageArea.innerHTML = `
                <div class="alert alert-${type}">
                    <i class="fas fa-${type === 'danger' ? 'exclamation-triangle' : 'info-circle'}"></i> ${message}
                </div>
            `;
            setTimeout(() => {
                messageArea.innerHTML = '';
            }, 5000);
        }
        
        // 表单验证和提交
        $(document).ready(function() {
            $('#loginForm').on('submit', function(e) {
                e.preventDefault();
                
                var id = $('#id').val().trim();
                var passwd = $('#passwd').val().trim();
                
                if (!id) {
                    showMessage('请输入账号！', 'danger');
                    return false;
                }
                
                if (!passwd) {
                    showMessage('请输入密码！', 'danger');
                    return false;
                }
                
                if (isNaN(id)) {
                    showMessage('账号必须为数字！', 'danger');
                    return false;
                }
                
                // 添加加载效果
                $('.btn-login').html('<i class="fas fa-spinner fa-spin"></i> 登录中...');
                $('.btn-login').prop('disabled', true);
                
                // 发送登录请求
                $.ajax({
                    type: "POST",
                    url: "/loginCheck",
                    data: {
                        id: id,
                        passwd: passwd
                    },
                    dataType: "json",
                    success: function(data) {
                        if (data.stateCode.trim() == "0") {
                            showMessage('账号或密码错误！', 'danger');
                        } else if (data.stateCode.trim() == "1") {
                            showMessage('管理员登录成功，正在跳转...', 'info');
                            setTimeout(function() {
                                window.location.href = "/admin_main.html";
                            }, 1500);
                        } else if (data.stateCode.trim() == "2") {
                            showMessage('读者登录成功，正在跳转...', 'info');
                            setTimeout(function() {
                                window.location.href = "/reader_main.html";
                            }, 1500);
                        }
                    },
                    error: function() {
                        showMessage('登录请求失败，请检查网络连接！', 'danger');
                    },
                    complete: function() {
                        // 恢复按钮状态
                        setTimeout(function() {
                            $('.btn-login').html('<i class="fas fa-sign-in-alt"></i> 登录系统');
                            $('.btn-login').prop('disabled', false);
                        }, 1000);
                    }
                });
            });
        });
    </script>
</body>
</html>
