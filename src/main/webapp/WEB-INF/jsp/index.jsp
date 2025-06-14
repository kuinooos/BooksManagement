<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📚 智慧图书馆 - 现代化管理平台</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        
        .background-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2;
            background: linear-gradient(-45deg, #667eea, #764ba2, #f093fb, #f5576c);
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
        }
        
        .login-header h1 {
            color: #333;
            font-size: 2.2em;
            font-weight: 700;
            margin-bottom: 8px;
        }
        
        .login-header p {
            color: #666;
            font-size: 1.1em;
            font-weight: 400;
        }
        
        .user-type-selector {
            display: flex;
            margin-bottom: 35px;
            background: #f8f9fa;
            border-radius: 15px;
            padding: 6px;
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
        }
        
        .user-type-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .form-group {
            position: relative;
            margin-bottom: 25px;
        }
        
        .form-control {
            width: 100%;
            padding: 18px 25px;
            border: 2px solid #e1e8ed;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #fff;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }
        
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
            cursor: pointer;
        }
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
        }
        
        .alert {
            border-radius: 12px;
            margin-bottom: 25px;
            border: none;
            padding: 15px 20px;
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
        
        @media (max-width: 768px) {
            .login-container {
                margin: 10px;
                padding: 30px;
            }
        }
    </style>
</head>
<body>
    <div class="background-animation"></div>
    
    <div class="login-container">
        <div class="login-header">
            <div class="logo">📚</div>
            <h1>智慧图书馆</h1>
            <p id="subtitle">现代化图书管理平台</p>
        </div>
        
        <c:if test="${!empty error}">
            <div class="alert alert-danger">
                <strong>错误：</strong> ${error}
            </div>
        </c:if>
        
        <div id="message-area"></div>
        
        <div class="user-type-selector">
            <button type="button" class="user-type-btn active" onclick="switchUserType('reader')">
                👤 读者登录
            </button>
            <button type="button" class="user-type-btn" onclick="switchUserType('admin')">
                🛡️ 管理员
            </button>
        </div>
        
        <form id="loginForm">
            <div class="form-group">
                <input type="text" class="form-control" id="id" name="id" placeholder="请输入读者账号" required>
            </div>
            
            <div class="form-group">
                <input type="password" class="form-control" id="passwd" name="passwd" placeholder="请输入密码" required>
            </div>
            
            <input type="hidden" name="userType" id="userType" value="reader">
            
            <button type="submit" class="btn-login" id="loginButton">
                🚀 登录系统
            </button>
        </form>
    </div>
    
    <script>
        function switchUserType(type) {
            var buttons = document.querySelectorAll('.user-type-btn');
            buttons.forEach(function(btn) {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            document.getElementById('userType').value = type;
            
            if (type === 'admin') {
                document.getElementById('id').placeholder = '请输入管理员账号';
                document.getElementById('subtitle').textContent = '管理员后台 - 图书馆管理中心';
            } else {
                document.getElementById('id').placeholder = '请输入读者账号';
                document.getElementById('subtitle').textContent = '现代化图书管理平台';
            }
        }
        
        function showMessage(message, type) {
            var messageArea = document.getElementById('message-area');
            messageArea.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
            setTimeout(function() {
                messageArea.innerHTML = '';
            }, 5000);
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('loginForm').addEventListener('submit', function(e) {
                e.preventDefault();
                
                var id = document.getElementById('id').value.trim();
                var passwd = document.getElementById('passwd').value.trim();
                
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
                
                var loginButton = document.getElementById('loginButton');
                loginButton.innerHTML = '🔄 登录中...';
                loginButton.disabled = true;
                
                // 使用原生JavaScript的AJAX
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/loginCheck', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            var data = JSON.parse(xhr.responseText);
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
                        } else {
                            showMessage('登录请求失败，请检查网络连接！', 'danger');
                        }
                        
                        setTimeout(function() {
                            loginButton.innerHTML = '🚀 登录系统';
                            loginButton.disabled = false;
                        }, 1000);
                    }
                };
                
                xhr.send('id=' + encodeURIComponent(id) + '&passwd=' + encodeURIComponent(passwd));
            });
        });
    </script>
</body>
</html>
