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
                        <li class="active"><a href="index.jsp">主页 <span class="sr-only">(current)</span></a></li>
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
                        <%
                            Object User = request.getSession().getAttribute("user");
                            if (User != null) {
                                out.println("<li class=\"dropdown\">");
                                out.println("<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">" + User.toString().substring(0, 1) + "<span class=\"caret\"></span></a>");
                                out.println("<ul class=\"dropdown-menu\">");
                                out.println("<li><a href=\"#\">个人书架</a></li>");
                                out.println("<li><a href=\"#\">个人信息</a></li>");
                                out.println("<li><a href=\"#\">上传作品</a></li>");
                                out.println("<li role=\"separator\" class=\"divider\"></li>");
                                out.println("<li><a href=\"logout\">退出登录</a></li>");
                                out.println("</ul>");
                                out.println("</li>");
                            } else {
                                out.println("<li><a href=\"register.jsp\">注册</a></li>");
                                out.println("<li><a href=\"login.jsp\">登录</a></li>");
                            }
                        %>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>

    </div>
<%/*
    Cookie[] cookies = request.getCookies();
    if(cookies!=null)
    {
        for(int i=0; i<cookies.length; i++){
            out.println(cookies[i].getName());
            out.println(cookies[i].getValue());
        }
    }else{
        out.print("cookies is null");
    }*/
    /*
    Object usr = request.getSession().getAttribute("user");
    if(usr != null){
        out.println("asdfasdf");
    }*/
%>

<!-- 巨屏信息 -->
<div class="jumbotron jumbotron_self">
    <div class="container">
        <h1 id="jumbotron_h1">Welcome to Novel</h1>
        <p class="jumbotron_p">NOVEL Sanctum</p>
        <p class="jumbotron_p">A place to discover, interact and divert with our numerou books,bla bla bla...</p>
    </div>
</div>

<%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://127.0.0.1:3306/java_book";
    String user = "root";
    String password = "305219";
    String[] showType = {"最近更新", "女频言情", "武侠仙侠", "玄幻奇幻"};
    String[] showId = {"update_recently", "romantic", "wuxia", "strange"};
    try {
        Class.forName(driver);
        Connection conn = DriverManager.getConnection(url, user, password);
        Statement statement = conn.createStatement();

        // sql search
        String search_end = " order by book_id desc limit 6";
        String hot_sql = "select book_id,book_name,img_name from book_info" + search_end;
        String rom_sql = "select book_id,book_name,img_name from book_info where type='女频言情'" + search_end;
        String wux_sql = "select book_id,book_name,img_name from book_info where type='武侠仙侠'" + search_end;
        String str_sql = "select book_id,book_name,img_name from book_info where type='玄幻奇幻'" + search_end;
        ResultSet rs = null;

        // novel intro to use
        String imgurl = null;
        String novel_name = null;
        int novel_id = 0;

        int id_count = 0;
        for (String bookType : showType) {
            // show each type page
            out.println("<div class=\"container template-container\">");
            out.println("<div class=\"row\">");
            out.println("<div class=\"col-md-12 link_show\">");
            out.println("<h2 class=\"nav_h2\" id=\"" + showId[id_count] + "\">");
            out.println("<a href=\"#" + showId[id_count] + "\" class=\"anchor-link\">");
            out.println("<span class=\"glyphicon glyphicon-link aria-hidden=\"true\"></span></a>");
            out.println(bookType);
            out.println("</h2>");
            out.println("</div>");
            out.println("</div>");
            out.println("<div class=\"row\">");
            // show image list of type
            if (id_count == 0)
                rs = statement.executeQuery(hot_sql);
            else if (id_count == 1)
                rs = statement.executeQuery(rom_sql);
            else if (id_count == 2)
                rs = statement.executeQuery(wux_sql);
            else
                rs = statement.executeQuery(str_sql);

            while (rs.next()) {
                imgurl = rs.getString("img_name");
                novel_name = rs.getString("book_name");
                novel_id = rs.getInt("book_id");

                out.println("<div class=\"col-md-3 col-sm-3 col-lg-2 col-xs-6 info-div\">");
                out.println("<a href=\"BookInfo/" + novel_id + "\" class=\"book-link\">");
                out.println("<img src=\"static/img/" + imgurl + "\" class=\"img-rounded img-self\">");
                out.println("</a>");
                out.println("<p class=\"text-center\">" + novel_name + "</p>");
                out.println("</div>");
            }

            out.println("</div>");// end of img list row
            out.println("</div>");// end of container

            // next type
            id_count++;
        }
        rs.close();
        statement.close();
        conn.close();
    } catch (ClassNotFoundException e) {
        System.out.println("Sorry, can not find the Driver!");
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script src="static/js/jquery-3.3.1.min.js"></script>
<script src="static/js/jquery.color-2.1.2.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/index.js"></script>
</body>
</html>
