<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📚 ${readercard.name} - 密码修改</title>
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
        
        .navbar-toggle {
            border-color: #667eea;
        }
        
        .navbar-toggle .icon-bar {
            background-color: #667eea;
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
        
        .password-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: none;
        }
        
        .password-card .panel-heading {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 15px 15px 0 0;
            color: white;
            padding: 20px;
            margin: -30px -30px 20px -30px;
        }
        
        .password-card .panel-title {
            font-size: 1.3em;
            font-weight: 600;
        }
        
        .input-group {
            margin-bottom: 20px;
        }
        
        .input-group-addon {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            font-weight: 600;
            min-width: 120px;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 0 10px 10px 0;
            padding: 12px 15px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 16px;
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .alert {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        @media (max-width: 767px) {
            .navbar-nav {
                margin: 10px 0;
            }
            
            .navbar-nav > li > a {
                margin: 2px 0;
            }
            
            .main-content {
                padding: 20px 10px;
            }
        }
    </style>
</head>
<body>
    <!-- 现代化导航栏 -->
    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#reader-navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="reader_main.html">
                    <i class="fas fa-book"></i> 我的图书馆
                </a>
            </div>
            <div class="collapse navbar-collapse" id="reader-navbar-collapse">
                <ul class="nav navbar-nav navbar-left">
                    <li>
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
                            <i class="fas fa-book-reader"></i> 我的借还
                        </a>
                    </li>
                    <li class="active">
                        <a href="reader_repasswd.html">
                            <i class="fas fa-key"></i> 密码修改
                        </a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="reader_info.html">
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
        <c:if test="${!empty succ}">
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="fas fa-check-circle"></i> ${succ}
            </div>
        </c:if>
        <c:if test="${!empty error}">
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <div class="container">
            <div class="col-xs-12 col-md-6 col-md-offset-3">
                <div class="panel panel-default password-card">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <i class="fas fa-shield-alt"></i> 密码修改
                        </h3>
                    </div>
                    <div class="panel-body">
                        <form action="reader_repasswd_do.html" method="post" id="myform">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-lock"></i> 原密码
                                </span>
                                <input type="password" class="form-control" name="oldPasswd" id="oldPasswd" 
                                       placeholder="请输入原密码" required>
                            </div>
                            
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-key"></i> 新密码
                                </span>
                                <input type="password" class="form-control" name="newPasswd" id="newPasswd" 
                                       placeholder="请输入新密码" required>
                            </div>
                            
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-check-circle"></i> 确认密码
                                </span>
                                <input type="password" class="form-control" name="reNewPasswd" id="reNewPasswd" 
                                       placeholder="请再次输入新密码" required>
                            </div>
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="fas fa-save"></i> 修改密码
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function mySubmit(flag){
            return flag;
        }
        
        $("#myform").submit(function () {
            if($("#oldPasswd").val()=='' || $("#newPasswd").val()=='' || $("#reNewPasswd").val()==''){
                alert("请完整填写密码信息！");
                return mySubmit(false);
            }
            
            if($("#newPasswd").val() != $("#reNewPasswd").val()){
                alert("两次新密码输入不一致！");
                return mySubmit(false);
            }
            
            if($("#newPasswd").val().length < 6){
                alert("新密码长度不能少于6位！");
                return mySubmit(false);
            }
            
            return true;
        });
    </script>
</body>
</html>
