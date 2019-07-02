<%--
  Created by IntelliJ IDEA.
  User: CCG
  Date: 2019/6/18
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Sign up</title>

    <link rel="stylesheet" href="./static/css/bootstrap.min.css">
    <link rel="stylesheet" href="./static/css/index.css">
    <link rel="stylesheet" href="./static/css/register.css">
</head>
<body>
    <!-- 导航栏 -->
    <div class="container-fluid div_nav_self">
        <nav class="navbar navbar-inverse nav_self">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!-- 放置商标 -->
                    <a class="navbar-brand" href="index.jsp" style="align-content: center">
                        <!--
                        <img class="img-rounded" src="static/img/Brand11.png" alt="Novel" id="Brand_self">
                        -->
                        奇易斋
                    </a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="index.jsp">主页 <span class="sr-only">(current)</span></a></li>
                        <li><a href="category.jsp">分类</a></li>
                        <!--
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false">Dropdown <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">One more separated link</a></li>
                            </ul>
                        </li>-->
                    </ul>
                    <form class="navbar-form navbar-right">
                        <div class="form-group">
                            <label for="searchInput"></label>
                            <input type="text" class="form-control" placeholder="Search" id="searchInput">
                        </div>
                        <button type="submit" class="btn btn-default">搜索</button>
                    </form>

                    <!-- 注册登录 -->
                    <ul class="nav navbar-nav navbar-right">
                        <li class="active"><a href="register.jsp">注册</a></li>
                        <li><a href="login.jsp">登录</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>

    </div>

    <!-- 大屏幕信息 -->
    <div class="jumbotron jumbotron_self">
        <div class="container">
            <h1 style="color: #ffffff">加入奇易斋</h1>
            <p class="jumbotron_p">享受更新提示、即时点评书籍、分享个人作品..</p>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-9">
                <div>
                    <form action="checkRegister" onsubmit="return check_info()" method="post">
                        <div class="form-group">
                            <label for="InputUser">用户名</label>
                            <input type="text" class="form-control" id="InputUser" placeholder="用户名" name="user">
                            <p class="form-group text-danger" id="user-danger">用户名不能为空且不能包含空格</p>
                        </div>
                        <div class="form-group">
                            <label for="InputEmail">邮箱</label>
                            <input type="email" class="form-control" id="InputEmail" placeholder="邮箱" name="email">
                            <p class="text-danger form-group" id="email-danger">邮箱格式错误</p>
                        </div>
                        <div class="form-group">
                            <label for="InputPassword">密码</label>
                            <input type="password" class="form-control" id="InputPassword" placeholder="密码" name="pswd">
                            <p class="text-danger form-group" id="pswd-danger">密码不能为空且不能包含空格</p>
                        </div>
                        <div class="form-group">
                            <label for="ComfirmPassword" type="ComfirmPassword">确认密码</label>
                            <input type="password" class="form-control" id="ComfirmPassword" placeholder="确认密码">
                            <p class="form-group text-danger" id="com-danger">两次输入密码不相同</p>
                        </div>
                        <div class="checkbox">
                            <label id="register-label">
                                <input type="checkbox" id="check-self">本站点使用Cookie，注册账户默认同意本站点规则。
                            </label>
                        </div>
                        <button class="btn btn-success" type="submit" disabled="disabled" id="register" onclick="check_info()">确认</button>
                    </form>
                </div>
            </div>
            <div class="col-md-3" id="register-info">
                <div>
                    <h3>Join Novel</h3>
                    <p>Begin a travel of reading.</p>
                    <p>the source come from <a href="https://www.qisuu.la">https://www.qisuu.la</a></p>
                    <p>Glyphicons <a href="https://glypicons.com">https://www.glyphicons.com</a></p>
                </div>
            </div>
        </div>
    </div>
    <%
        String rg = request.getParameter("rg");
        if(rg!=null && rg.equals("false")){
            out.println("<span id=\"rg_false\" style=\"display:none\"></span>");
        }
    %>
    <!-- 模态框 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        注册失败
                    </h4>
                </div>
                <div class="modal-body">
                    用户名或邮箱已存在
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">
                        关闭
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="static/js/jquery-3.3.1.min.js"></script>
    <script src="static/js/jquery.color-2.1.2.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/index.js"></script>
    <script src="static/js/register.js"></script>
</body>
</html>
