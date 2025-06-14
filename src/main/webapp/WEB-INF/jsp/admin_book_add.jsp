<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书信息添加</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>    <style>
        body{
            background-color: rgb(240,242,245);
            padding-top: 20px; /* 减少顶部边距 */
        }
        .content-container {
            margin-top: 20px;
        }
    </style>

</head>
<body>
<nav class="navbar navbar-default" role="navigation" style="background-color: #fff; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);" >
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

<div style="position: relative;top: 10%;width: 80%;margin-left: 10%">
            <form action="book_add_do.html" method="post" id="addbook" >                <div class="form-group">
                    <label for="name">图书名</label>
                    <input type="text" class="form-control" name="name" id="name" placeholder="请输入书名" 
                           value="${bookAddCommand.name != null ? bookAddCommand.name : ''}">
                </div>
                <div class="form-group">
                    <label for="author">作者</label>
                    <input type="text" class="form-control" name="author" id="author"  placeholder="请输入作者名"
                           value="${bookAddCommand.author != null ? bookAddCommand.author : ''}">
                </div>
                <div class="form-group">
                    <label for="publish">出版社</label>
                    <input type="text" class="form-control"  name="publish" id="publish"  placeholder="请输入出版社"
                           value="${bookAddCommand.publish != null ? bookAddCommand.publish : ''}">
                </div>
                <div class="form-group">
                    <label for="isbn">ISBN</label>
                    <input type="text" class="form-control" name="isbn" id="isbn"  placeholder="请输入ISBN"
                           value="${bookAddCommand.isbn != null ? bookAddCommand.isbn : ''}">
                </div>
                <div class="form-group">
                    <label for="introduction">简介</label>
                    <textarea class="form-control" rows="3"  name="introduction" id="introduction" placeholder="请输入简介">${bookAddCommand.introduction != null ? bookAddCommand.introduction : ''}</textarea>
                </div>
                <div class="form-group">
                    <label for="language">语言</label>
                    <input type="text" class="form-control" name="language" id="language"  placeholder="请输入语言"
                           value="${bookAddCommand.language != null ? bookAddCommand.language : ''}">
                </div>                <div class="form-group">
                    <label for="price">价格</label>
                    <input type="number" step="0.01" min="0" class="form-control"  name="price"  id="price" placeholder="请输入价格（如：29.99）"
                           value="${bookAddCommand.price != null ? bookAddCommand.price : ''}">
                </div>
                <div class="form-group">
                    <label for="pubdate">出版日期</label>
                    <input type="date" class="form-control"  name="pubdate" id="pubdate" placeholder="请选择出版日期"
                           value="${bookAddCommand.pubdate != null ? bookAddCommand.pubdate : ''}">
                </div>
                <div class="form-group">
                    <label for="classId">分类号</label>
                    <input type="number" min="1" class="form-control" name="classId" id="classId"  placeholder="请输入分类号（整数）"
                           value="${bookAddCommand.classId != null && bookAddCommand.classId > 0 ? bookAddCommand.classId : ''}">
                </div>
                <div class="form-group">
                    <label for="pressmark">书架号</label>
                    <input type="number" min="1" class="form-control"  name="pressmark" id="pressmark" placeholder="请输入书架号（整数）"
                           value="${bookAddCommand.pressmark != null && bookAddCommand.pressmark > 0 ? bookAddCommand.pressmark : ''}">
                </div>
                <div class="form-group">
                    <label for="state">状态</label>
                    <select class="form-control" name="state" id="state">
                        <option value="">请选择图书状态</option>
                        <option value="1" ${bookAddCommand.state == 1 ? 'selected' : ''}>在馆</option>
                        <option value="0" ${bookAddCommand.state == 0 ? 'selected' : ''}>借出</option>
                    </select>
                </div>


                <input type="submit" value="添加" class="btn btn-success btn-sm" class="text-left">                <script>
                    function mySubmit(flag){
                        return flag;
                    }
                    $("#addbook").submit(function () {
                        // 检查必填字段
                        if($("#name").val()=='' || $("#author").val()=='' || $("#publish").val()=='' || 
                           $("#isbn").val()=='' || $("#introduction").val()=='' || $("#language").val()=='' || 
                           $("#price").val()=='' || $("#pubdate").val()=='' || $("#classId").val()=='' || 
                           $("#pressmark").val()=='' || $("#state").val()==''){
                            alert("请填入完整图书信息！");
                            return mySubmit(false);
                        }
                        
                        // 检查ISBN格式（标准ISBN-13格式：978-0-123456-78-9）
                        var isbn = $("#isbn").val().trim();
                        if(isbn.length < 10 || isbn.length > 20){
                            alert("请输入有效的ISBN号码（10-20个字符）！");
                            return mySubmit(false);
                        }
                        
                        // 检查价格格式
                        var price = parseFloat($("#price").val());
                        if(isNaN(price) || price <= 0){
                            alert("请输入有效的价格！");
                            return mySubmit(false);
                        }
                        
                        // 检查分类号格式
                        var classId = parseInt($("#classId").val());
                        if(isNaN(classId) || classId <= 0){
                            alert("请输入有效的分类号（正整数）！");
                            return mySubmit(false);
                        }
                        
                        // 检查书架号格式
                        var pressmark = parseInt($("#pressmark").val());
                        if(isNaN(pressmark) || pressmark <= 0){
                            alert("请输入有效的书架号（正整数）！");
                            return mySubmit(false);
                        }
                        
                        return true;
                    })
                </script>
            </form>

</div>



</body>
</html>
