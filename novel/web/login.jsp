<%--
  Created by IntelliJ IDEA.
  User: CCG
  Date: 2019/6/26
  Time: 14:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述三个标签必须放在title前面 -->

    <title>Sign in</title>

    <link rel="stylesheet" href="./static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/index.css">
    <link rel="stylesheet" href="static/css/login.css">
</head>
<body>

    <div class="container-fluid" id="brand-img">
        <a href="index.jsp">
            <img src="static/img/brand20.png" alt="img" class="img-circle">
        </a>
    </div>
    <div class="container" id="login-container">
        <div>
            <h2>Sign in to Novel</h2>
        </div>

        <div id="login-form">
            <form action="loginCheck" method="post" onsubmit="return check()">
                <div class="form-group">
                    <label for="InputUser">用户名或邮箱</label>
                    <input type="text" class="form-control" id="InputUser" name="user">
                </div>
                <div class="form-group">
                    <label for="InputPassword">密码<a href="#" id="forget">忘记密码?</a></label>
                    <input type="password" class="form-control" id="InputPassword" name="pswd">
                </div>
                <button type="submit" class="btn btn-success" onclick="check()">登录</button>
            </form>
        </div>
        <p id="login-footer">还没有账户?<a href="register.jsp">注册</a></p>
    </div>

    <%
        String flag = request.getParameter("flag");
        if(flag != null && flag.equals("false")){
            out.println("<span id=\"flag_false\" style=\"display:none\"></span>");
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
                        登录失败
                    </h4>
                </div>
                <div class="modal-body">
                    <p id="login-error" style="display: none">账户或密码错误</p>
                    <p id="user-info" style="display: none">账户为空或包含敏感字符</p>
                    <p id="pswd-info" style="display: none">密码为空或包含敏感字符</p>
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
    <script src="static/js/login.js"></script>
</body>
</html>
