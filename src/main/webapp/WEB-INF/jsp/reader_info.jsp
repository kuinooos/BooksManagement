
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📚 ${readercard.name} - 个人信息</title>
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
        
        .info-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: none;
        }
        
        .info-card .panel-heading {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 15px 15px 0 0;
            color: white;
            padding: 20px;
            margin: -30px -30px 20px -30px;
        }
        
        .info-card .panel-title {
            font-size: 1.3em;
            font-weight: 600;
        }
        
        .table-hover {
            background: transparent;
        }
        
        .table-hover th {
            background: #f8f9fa;
            color: #333;
            font-weight: 600;
            border: none;
            padding: 15px;
        }
        
        .table-hover td {
            border: none;
            padding: 15px;
            color: #555;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 10px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
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
                    <li class="active">
                        <a href="reader_info.html">
                            <i class="fas fa-user"></i> 个人信息
                        </a>
                    </li>
                    <li>
                        <a href="mylend.html">
                            <i class="fas fa-book-reader"></i> 我的借还
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
            <div class="col-xs-12 col-md-8 col-md-offset-2">
                <div class="panel panel-default info-card">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <i class="fas fa-id-card"></i> 我的个人信息
                        </h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-hover">
                            <tbody>
                                <tr>
                                    <th width="20%"><i class="fas fa-id-badge"></i> 读者证号</th>
                                    <td>${readerinfo.readerId}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-user"></i> 姓名</th>
                                    <td>${readerinfo.name}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-venus-mars"></i> 性别</th>
                                    <td>${readerinfo.sex}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-birthday-cake"></i> 生日</th>
                                    <td>${readerinfo.birth}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-home"></i> 地址</th>
                                    <td>${readerinfo.address}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-phone"></i> 电话</th>
                                    <td>${readerinfo.telcode}</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="text-center">
                            <a class="btn btn-success btn-lg" href="reader_info_edit.html" role="button">
                                <i class="fas fa-edit"></i> 修改信息
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</body>
</html>
