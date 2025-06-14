
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📚 ${readercard.name} - 编辑个人信息</title>
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
        
        .edit-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: none;
        }
        
        .edit-card .panel-heading {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 15px 15px 0 0;
            color: white;
            padding: 20px;
            margin: -30px -30px 20px -30px;
        }
        
        .edit-card .panel-title {
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
        
        .form-control[readonly] {
            background-color: #f8f9fa;
            opacity: 0.7;
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
        <div class="container">
            <div class="col-xs-12 col-md-8 col-md-offset-2">
                <div class="panel panel-default edit-card">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <i class="fas fa-user-edit"></i> 编辑个人信息
                        </h3>
                    </div>
                    <div class="panel-body">
                        <form action="reader_edit_do_r.html" method="post" id="edit">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-id-badge"></i> 读者证号
                                </span>
                                <input type="text" readonly="readonly" class="form-control" 
                                       name="readerId" id="readerId" value="${readerinfo.readerId}">
                            </div>
                            
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-user"></i> 姓名
                                </span>
                                <input type="text" class="form-control" name="name" id="name" 
                                       value="${readerinfo.name}" placeholder="请输入姓名" required>
                            </div>
                            
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-venus-mars"></i> 性别
                                </span>
                                <select class="form-control" name="sex" id="sex" required>
                                    <option value="">请选择性别</option>
                                    <option value="男" ${readerinfo.sex == '男' ? 'selected' : ''}>男</option>
                                    <option value="女" ${readerinfo.sex == '女' ? 'selected' : ''}>女</option>
                                </select>
                            </div>
                            
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-birthday-cake"></i> 生日
                                </span>
                                <input type="date" class="form-control" name="birth" id="birth" 
                                       value="${readerinfo.birth}" required>
                            </div>
                            
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-home"></i> 地址
                                </span>
                                <input type="text" class="form-control" name="address" id="address" 
                                       value="${readerinfo.address}" placeholder="请输入地址" required>
                            </div>
                            
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fas fa-phone"></i> 电话
                                </span>
                                <input type="tel" class="form-control" name="telcode" id="telcode" 
                                       value="${readerinfo.telcode}" placeholder="请输入手机号码" 
                                       pattern="^1[3-9]\d{9}$" title="请输入有效的手机号码" required>
                            </div>
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="fas fa-save"></i> 保存修改
                                </button>
                                <a href="reader_info.html" class="btn btn-default btn-lg" style="margin-left: 15px;">
                                    <i class="fas fa-times"></i> 取消
                                </a>
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
        
        $("#edit").submit(function () {
            if($("#name").val()=='' || $("#sex").val()=='' || $("#birth").val()=='' || 
               $("#address").val()=='' || $("#telcode").val()==''){
                alert("请填入完整个人信息！");
                return mySubmit(false);
            }
            
            // 验证手机号码格式
            var telcode = $("#telcode").val();
            if (!telcode.match(/^1[3-9]\d{9}$/)) {
                alert("请输入有效的手机号码！");
                return mySubmit(false);
            }
            
            return true;
        });
    </script>


</body>
</html>
