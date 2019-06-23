<%--
  Created by IntelliJ IDEA.
  User: CCG
  Date: 2019/6/17
  Time: 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述三个标签必须放在title前面 -->

    <title>Novels</title>

    <link rel="stylesheet" href="./static/css/bootstrap.min.css">
    <link rel="stylesheet" href="./static/css/index.css">
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
                <a class="navbar-brand" href="/novel" style="align-content: center">
                    <!--
                    <img class="img-rounded" src="static/img/Brand11.png" alt="Novel" id="Brand_self">
                    -->
                    奇易斋
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="/novel">主页 <span class="sr-only">(current)</span></a></li>
                    <li><a href="#">分类</a></li>
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
                        <input type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>

                <!-- 注册登录 -->
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="/novel/register.jsp">注册</a></li>
                    <li><a href="#">登录</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

</div>

<!-- 巨屏信息 -->
<div class="jumbotron jumbotron_self">
    <div class="container">
        <h1 id="jumbotron_h1">Welcome to Novel</h1>
        <p class="jumbotron_p">NOVEL Sanctum</p>
        <p class="jumbotron_p">A place to discover, interact and divert with our numerou books,bla bla bla...</p>
    </div>
</div>

<!-- 热门推荐 -->
<div class="container" id="hot-div-container">
    <div class="row">
        <div class="col-md-12 link_show">
            <h2 class="nav_h2" id="update_recently">
                <a href="#update_recently" class="anchor-link">
                    <span class="glyphicon glyphicon-link" aria-hidden="true"></span></a>
                最近更新
            </h2>
        </div>
    </div>
    <!-- jsp处理 -->
    <div class="row">
        <%
            String driver = "com.mysql.jdbc.Driver";
            String url = "jdbc:mysql://127.0.0.1:3306/java_book";
            String user = "root";
            String password = "305219";
            try{
                Class.forName(driver);
                Connection conn = DriverManager.getConnection(url,user,password);
                Statement statement = conn.createStatement();
                String sql = "select * from book_info order by book_id desc limit 6";
                ResultSet rs = statement.executeQuery(sql);
                String imgurl = null;
                String novel_name = null;
                int novel_id = 0;
                while(rs.next()){
                    imgurl = rs.getString("img_name");
                    novel_name = rs.getString("book_name");
                    novel_id = rs.getInt("book_id");
                    out.println("<div class=\"col-md-3 col-sm-3 col-lg-2 col-xs-6 info-div\">");
                    out.println("<a href=\"/novel/BookInfo/"+novel_id+"\" class=\"book-link\">");
                    out.println("<img src=\"static/img/"+imgurl+"\" class=\"img-rounded img-self\">");
                    out.println("<p class=\"text-center\">"+novel_name+"</p>");
                    out.println("</a>");
                    out.println("</div>");
                }
                rs.close();
                statement.close();
                conn.close();
            } catch (ClassNotFoundException e){
                System.out.println("Sorry, can not find the Driver!");
                e.printStackTrace();
            } catch (SQLException e){
                e.printStackTrace();
            } catch (Exception e){
                e.printStackTrace();
            }
        %>
    </div>
</div>

<!-- 女频言情 -->
<div class="container template-container">
    <div class="row">
        <div class="col-md-12 link-show">
            <h2 class="nav_h2" id="romantic">
                <a href="#romantic" class="anchor-link">
                    <span class="glyphicon glyphicon-link"></span></a>
                女频言情
            </h2>
        </div>
    </div>
</div>

<script src="static/js/jquery-3.3.1.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/index.js"></script>
</body>
</html>
