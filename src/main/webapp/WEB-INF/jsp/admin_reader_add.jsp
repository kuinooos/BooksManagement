
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加读者</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>    <style>
        body{
            background-color: rgb(240,242,245);
            padding-top: 20px; /* 减少顶部边距 */
        }
    </style>

</head>
<body>
<nav  class="navbar navbar-default" role="navigation" style="background-color: #fff; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);" >
    <div class="container-fluid">
        <div class="navbar-header" style="margin-left: 8%;margin-right: 1%">
            <a class="navbar-brand" href="admin_main.html">图书管理系统</a>
        </div>
        <div class="collapse navbar-collapse" >
            <ul class="nav navbar-nav navbar-left">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        图书管理
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="allbooks.html">全部图书</a></li>
                        <li class="divider"></li>
                        <li><a href="book_add.html">增加图书</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        读者管理
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="allreaders.html">全部读者</a></li>
                        <li class="divider"></li>
                        <li><a href="reader_add.html">增加读者</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        借还管理
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="lendlist.html">借还日志</a></li>
                    </ul>
                </li>
                <li >
                    <a href="admin_repasswd.html" >
                        密码修改
                    </a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="login.html"><span class="glyphicon glyphicon-user"></span>&nbsp;${admin.adminId}，已登录</a></li>
                <li><a href="logout.html"><span class="glyphicon glyphicon-log-in"></span>&nbsp;退出</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- 显示成功和错误消息 -->
<div class="container" style="margin-top: 20px;">
    <c:if test="${!empty succ}">
        <div class="alert alert-success alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            ${succ}
        </div>
    </c:if>
    <c:if test="${!empty error}">
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            ${error}
        </div>
    </c:if>
</div>

<div class="col-xs-6 col-md-offset-3" style="position: relative;top: 25%">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">添加读者</h3>
        </div>
        <div class="panel-body">
            <form action="reader_add_do.html" method="post" id="readeredit" >                <div class="input-group">
                    <span  class="input-group-addon">读者证号</span>
                    <input  type="number" min="1" class="form-control" name="readerId" id="readerId" 
                           placeholder="请输入读者证号" value="${readerId != null ? readerId : ''}" required>
                </div>
                <br/>
                <div class="input-group">
                    <span class="input-group-addon">姓名</span>
                    <input type="text" class="form-control" name="name" id="name" 
                           placeholder="请输入姓名" value="${name != null ? name : ''}" required>
                </div>
                <br/>
                <div class="input-group">
                    <span  class="input-group-addon">性别</span>
                    <select class="form-control" name="sex" id="sex" required>
                        <option value="">请选择性别</option>
                        <option value="男" ${sex == '男' ? 'selected' : ''}>男</option>
                        <option value="女" ${sex == '女' ? 'selected' : ''}>女</option>
                    </select>
                </div>
                <br/>
                <div class="input-group">
                    <span class="input-group-addon">生日</span>
                    <input type="date" class="form-control" name="birth" id="birth" 
                           value="${birth != null ? birth : ''}" required>
                </div>
                <br/>
                <div class="input-group">
                    <span  class="input-group-addon">地址</span>
                    <input type="text" class="form-control" name="address" id="address" 
                           placeholder="请输入地址" value="${address != null ? address : ''}" required>
                </div>
                <br/>
                <div class="input-group">
                    <span class="input-group-addon">电话</span>
                    <input type="tel" class="form-control" name="telcode" id="telcode" 
                           placeholder="请输入手机号码" value="${telcode != null ? telcode : ''}" 
                           pattern="^1[3-9]\d{9}$" title="请输入有效的手机号码" required>
                </div>
                <br/>                <input type="submit" value="添加" class="btn btn-success btn-sm">
                <script>
                    function mySubmit(flag){
                        return flag;
                    }
                    $("#readeredit").submit(function () {
                        // 检查必填字段
                        if($("#readerId").val()=='' || $("#name").val()=='' || $("#sex").val()=='' || 
                           $("#birth").val()=='' || $("#address").val()=='' || $("#telcode").val()==''){
                            alert("请填入完整读者信息！");
                            return mySubmit(false);
                        }
                        
                        // 验证读者证号
                        var readerId = parseInt($("#readerId").val());
                        if(isNaN(readerId) || readerId <= 0){
                            alert("请输入有效的读者证号（正整数）！");
                            return mySubmit(false);
                        }
                        
                        // 验证手机号码格式
                        var telcode = $("#telcode").val();
                        var phonePattern = /^1[3-9]\d{9}$/;
                        if(!phonePattern.test(telcode)){
                            alert("请输入有效的手机号码！");
                            return mySubmit(false);
                        }
                        
                        return true;
                    })
                </script>
            </form>
        </div>
    </div>

</div>

</body>
</html>
