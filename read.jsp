<%--
  Created by IntelliJ IDEA.
  User: CCG
  Date: 2019/6/20
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,java.io.*" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述三个标签必须放在title前面 -->

    <title>Read</title>

    <link rel="stylesheet" href="./static/css/bootstrap.min.css">
    <link rel="stylesheet" href="./static/css/index.css">
    <link rel="stylesheet" href="static/css/read.css">
</head>
<body>
    <!-- 导航栏 -->
    <div class="container-fluid div_nav_self">
        <nav class="navbar navbar-default nav_self" id="read-nav">
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
                        <li><a href="/novel">主页 <span class="sr-only">(current)</span></a></li>
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

    <%!
        String novel_id = null;
        String novel_chapter = null;
        String novel_name = null;
        String novel_author = null;
        String novel_type = null;
        int novel_hot = 0;
        int count = 0;
        int present_chapter = 0;
        String next_url = null;
        String pre_url = null;
        String chapter_list = null;
    %>
    <%
        novel_id = request.getParameter("novel");
        novel_chapter = request.getParameter("chapter");

        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://127.0.0.1:3306/java_book";
        String user = "root";
        String password = "305219";

        try{
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(url,user,password);
            Statement statement = conn.createStatement();
            String sql = "select book_name, author, type, hot from book_info where book_id="+novel_id;
            ResultSet rs = statement.executeQuery(sql);

            while(rs.next()){
                novel_name = rs.getString("book_name");
                novel_author = rs.getString("author");
                novel_type = rs.getString("type");
                novel_hot = rs.getInt("hot");
            }
            rs.close();
            statement.close();
            conn.close();
            //out.println("the hot is " + novel_hot);
        } catch (ClassNotFoundException e){
            System.out.println("Sorry, can not find the Driver!");
            e.printStackTrace();
        } catch (SQLException e){
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }
    %>
    <%
        present_chapter = Integer.parseInt(novel_chapter);
        next_url = "read/"+novel_id+"/"+(present_chapter+1);
        if(present_chapter != 0)
            pre_url = "read/" + novel_id + "/" + (present_chapter - 1);
        pre_url = "read/" + novel_id + "/" + present_chapter;
        chapter_list = "BookInfo/" + novel_id;
    %>
    <%
        if(novel_chapter.equals("0"))
        {
            out.println("<span id=\"first_chapter\" style=\"display:none\"></span>");
        }
    %>
    <!-- first chpater show -->
    <div class="container" id="read-container" style="display: none">
        <div class="row">
            <div id="read-row-div">
                <h1 class="text-center" id="read-row-h1"><%=novel_name%></h1>
                <h3 class="text-center"><%=novel_author%></h3>
                <div>
                    <ul style="">
                        <li id="type-li">
                            <p><%=novel_type%></p>
                            <span>类型</span>
                        </li>
                        <li id="hot-li">
                            <p><%=novel_hot%></p>
                            <span>热度</span>
                        </li>
                    </ul>
                </div>
                <h5 class="text-center">本站小说来源奇书网站</h5>
                <h6 class="text-center">请到起点等正版网站支持正版图书</h6>
            </div>
        </div>
    </div>

    <div class="container" id="content-container">
        <div class="row">

            <div>
                <%
                    String BASE_PAtH = "D:\\java_homework\\javaWeb\\novels\\novel\\web\\qishu_book\\" + novel_type + "\\" + novel_name;
                    File file = new File(BASE_PAtH, novel_chapter+".txt");
                    BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "utf-8"));
                    String chapter_name = br.readLine();

                    String str = br.readLine();
                    while(str != null){
                        count = str.length() + count;
                        str = br.readLine();
                    }
                    out.println("<h3 class=\"text-left\">" + chapter_name + "</h3>");

                    br.close();
                %>
                <!--
                <h3 class="text-left">第一章</h3>
                -->
                <div>
                    <%
                        out.println("<a href=\"/novel/BookInfo/"+novel_id+"\" class=\"info-self-a\" id=\"glyphicon-book-name\">");
                    %>
                        <span class="glyphicon glyphicon-book"></span>
                        <%=novel_name%>
                    </a>
                    <a href="#" class="info-self-a">
                        <span class="glyphicon glyphicon-pencil"></span>
                        <%=novel_author%>
                    </a>
                    <a href="#" class="info-self-a">
                        <span class="glyphicon glyphicon-file"></span>
                        <%=count%>
                    </a>
                </div>
            </div>

            <div id="content-context">
                <%
                    String BASE_PAtHs = "D:\\java_homework\\javaWeb\\novels\\novel\\web\\qishu_book\\" + novel_type + "\\" + novel_name;
                    File files = new File(BASE_PAtHs, novel_chapter+".txt");
                    BufferedReader brs = new BufferedReader(new InputStreamReader(new FileInputStream(files), "utf-8"));
                    String chapter_names = brs.readLine();

                    String content = brs.readLine();
                    while(content != null){
                        out.println("<p>"+content+"</p>");
                        content = brs.readLine();
                    }
                    brs.close();
                %>
                <!--<p>content</p>-->
            </div>
        </div>
    </div>

    <div class="container" id="footer-container" style="margin-bottom: 20px">
        <div class="row" id="footer-row">
            <div style="padding-left: 0;padding-right: 0">
                <a href="<%=pre_url%>" class="footer-link">上一章</a><span>|</span><a href="<%=chapter_list%>" class="footer-link">目录</a><span>|</span><a href="<%=next_url%>" class="footer-link">下一章</a>
            </div>
        </div>
    </div>

    <script src="static/js/jquery-3.3.1.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/read.js"></script>
</body>
</html>
