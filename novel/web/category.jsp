<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: CCG
  Date: 2019/6/24
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="java.io.File" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述三个标签必须放在title前面 -->

    <title>Category</title>

    <link rel="stylesheet" href="./static/css/bootstrap.min.css">
    <link rel="stylesheet" href="./static/css/index.css">
    <link rel="stylesheet" href="static/css/category.css">
</head>
<body>
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
                        奇易斋
                    </a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="index.jsp">主页 <span class="sr-only">(current)</span></a></li>
                        <li class="active"><a href="category.jsp">分类</a></li>
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
                            if(User != null){
                                out.println("<li class=\"dropdown\">");
                                out.println("<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">"+User.toString().substring(0,1)+"<span class=\"caret\"></span></a>");
                                out.println("<ul class=\"dropdown-menu\">");
                                out.println("<li><a href=\"#\">个人书架</a></li>");
                                out.println("<li><a href=\"#\">个人信息</a></li>");
                                out.println("<li><a href=\"#\">上传作品</a></li>");
                                out.println("<li role=\"separator\" class=\"divider\"></li>");
                                out.println("<li><a href=\"logout\">退出登录</a></li>");
                                out.println("</ul>");
                                out.println("</li>");
                            }else{
                                out.println("<li><a href=\"register.jsp\">注册</a></li>");
                                out.println("<li><a href=\"login.jsp\">登录</a></li>");
                            }
                        %>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>

    </div>

    <%!
        String novel_name = null;
        String novel_img = null;
        String novel_author = null;
        String novel_type = null;
        int novel_id = 0;
        int pre_page = 0;

        int db_len = 0;

        String[] novel_type_list = {"历史军事", "美文同人", "女频言情", "武侠仙侠", "现代都市", "玄幻奇幻", "游戏竞技","科幻灵异","技术其它"};
        String[] type_list_code = {"lsjs", "mwtr", "npyq", "wxxx", "xdds", "xhqx", "yxjj", "khly", "jsqt"};

        String type = null;
        String flag = null;

    %>
    <div class="container">
        <div class="row">
            <div class="col-md-9" id="type_content">
                <div id="sort-way-div">
                    <a href="#">综合</a>
                    <a href="#">热度</a>
                    <a href="#">字数</a>
                </div>
                <div id="sort-content-div">
                    <ul class="list-unstyled">
                        <%
                            flag = request.getParameter("flag");
                            type = request.getParameter("type");
                            String page_str = request.getParameter("page");
                            if(page_str != null)
                            {
                                pre_page = Integer.parseInt(page_str);
                            }
                            String novel_intro = null;
                            int fir_page = pre_page * 10;

                            String driver = "com.mysql.jdbc.Driver";
                            String url = "jdbc:mysql://127.0.0.1:3306/java_book";
                            String user = "root";
                            String password = "305219";

                            try {
                                Class.forName(driver);
                                Connection conn = DriverManager.getConnection(url, user, password);
                                Statement statement = conn.createStatement();
                                String sql = null;
                                String db_len_sql = null;
                                if(flag == null || type.equals("all")) {
                                    // sql search
                                    sql = "select book_id,book_name,img_name,type,author,intro from book_info order by book_id desc limit " + fir_page + ",10";
                                    // get totall page
                                    db_len_sql = "select book_id from book_info";
                                }else{
                                    for(int i = 0; i < novel_type_list.length; i++){
                                        if(type_list_code[i].equals(type)){
                                            sql = "select book_id,book_name,img_name,type,author,intro from book_info where type='"+novel_type_list[i]+"' order by book_id desc limit "+fir_page+",10";
                                            db_len_sql = "select book_id from book_info where type='"+novel_type_list[i]+"'";
                                            break;
                                        }
                                    }
                                }

                                ResultSet rs_len = statement.executeQuery(db_len_sql);
                                db_len = 0;
                                while (rs_len.next()) {
                                    db_len++;
                                }

                                ResultSet rs = statement.executeQuery(sql);

                                while (rs.next()) {
                                    novel_name = rs.getString("book_name");
                                    novel_img = rs.getString("img_name");
                                    novel_author = rs.getString("author");
                                    novel_intro = rs.getString("intro");
                                    novel_type = rs.getString("type");
                                    novel_id = rs.getInt("book_id");

                                    out.println("<li>");
                                    out.println("<div class=\"sort-img\">");
                                    out.println("<a href=\"BookInfo/" + novel_id + "\"><img src=\"static/img/" + novel_img + "\"></a>");
                                    out.println("</div>");
                                    out.println("<div class=\"sort-intro\">");
                                    out.println("<h4><a href=\"BookInfo/" + novel_id + "\">" + novel_name + "</a></h4>");
                                    out.println("<h5>" + novel_author.replace("作者：", "") + " 著</h5>");
                                    out.println("<p>" + novel_type + "</p>");
                                    if (novel_intro.length() > 50)
                                        out.println("<p>" + novel_intro.substring(0, 50) + "...</p>");
                                    else
                                        out.println("<p>" + novel_intro + "</p>");
                                    out.println("</div>");
                                    out.print("</li>");
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
                    </ul>
                </div>

                <div id="sort-footer-div">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <%
                                int total_page = db_len / 10;
                                if(db_len % 10 != 0)
                                    total_page++;
                                //out.println("asdf"+total_page);
                                int max_show = 0;
                                if(total_page > 5)
                                    max_show = 3;
                                else
                                    max_show = total_page;

                                if(pre_page == 0) {
                                    out.println("<li class=\"disabled\">");
                                    out.println("<a href=\"javascript:;\" aria-label=\"Previous\">");
                                }else{
                                    out.println("<li>");
                                    if(flag != null)
                                    {
                                        out.println("<a href=\"category/"+(pre_page-1)+"?flag=1&type="+type+"\" aria-label=\"Previous\">");
                                    }
                                    else {
                                        out.println("<a href=\"category/" + (pre_page - 1) + "\" aria-label=\"Previous\">");
                                    }
                                }
                                out.println("<span aria-hidden=\"ture\">&laquo;</span>");
                                out.println("</a>");
                                out.println("</li>");

                                for(int i = 1; i <= max_show; i++)
                                {
                                    if((i-1) == pre_page){
                                        out.print("<li class=\"active\">");
                                    }else{
                                        out.print("<li>");
                                    }
                                    if(flag != null){
                                        out.println("<a href=\"category/"+(i-1)+"?flag=1&type="+type+"\">"+i+"</a></li>");
                                    }
                                    else {
                                        out.println("<a href=\"category/" + (i - 1) + "\">" + i + "</a></li>");
                                    }
                                }
                                if(total_page > 5)
                                {
                                    out.println("<li><a href=\"#\">...</a></li>");
                                    if(flag != null){
                                        out.println("<li><a href=\"category/"+(total_page-1)+"?flag=1&type="+type+"\">"+total_page+"</a></li>");
                                    }
                                    else {
                                        out.println("<li><a href=\"category/" + (total_page - 1) + "\">" + total_page + "</a></li>");
                                    }
                                }

                                if(pre_page >= (total_page-1)) {
                                    out.println("<li class=\"disabled\">");
                                    out.println("<a href=\"javascript:;\" aria-label=\"Next\">");
                                }else{
                                    out.println("<li>");
                                    if(flag != null){
                                        out.println("<a href=\"category/"+(pre_page+1)+"?flag=1&type="+type+"\" aria-label=\"Next\">");
                                    }else {
                                        out.println("<a href=\"category/" + (pre_page + 1) + "\" aria-label=\"Next\">");
                                    }
                                }
                                out.println("<span aria-hidden=\"true\">&raquo;</span>");
                                out.println("</a>");
                                out.println("</li>");
                            %>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="col-md-3" id="select_type">
                <div class="type-all">
                    <p>已选</p>
                    <a href="javascript:;">全部</a>
                </div>
                <div class="type-list">
                    <p>分类</p>
                    <ul class="list-unstyled">
                        <%
                            String type_path = "D:\\java_homework\\qishu_book\\";
                            try{
                                File file = new File(type_path);
                                File[] file_list = file.listFiles();
                                int type_id = 1;
                                if(type == null || type.equals("all")) {
                                    out.print("<li><a href=\"category/all?flag=1\" id=\"type-0\" class=\"type-list-click\">全部</a></li>");
                                }else{
                                    out.print("<li><a href=\"category/all?flag=1\" id=\"type-0\">全部</a></li>");
                                }

                                for(File f : file_list){
                                    for(int i = 0; i < novel_type_list.length; i++) {
                                        if(novel_type_list[i].equals(f.getName())) {
                                            if(type != null && type.equals(type_list_code[i])){
                                                out.print("<li><a href=\"category/"+type_list_code[i]+"?flag=1\" id=\"tpye-" + type_id + "\" class=\"type-list-click\">" + f.getName() + "</a></li>");
                                            }
                                            else {
                                                out.print("<li><a href=\"category/" + type_list_code[i] + "?flag=1\" id=\"tpye-" + type_id + "\">" + f.getName() + "</a></li>");
                                            }
                                            break;
                                        }
                                    }
                                    type_id++;
                                }
                            } catch (Exception e){
                                e.printStackTrace();
                            }
                        %>
                        <!--<li><a href="#">全部</a></li><li><a href="#">asdf</a></li><li><a href="#">asdf</a></li>-->
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <script src="static/js/jquery-3.3.1.min.js"></script>
    <script src="static/js/jquery.color-2.1.2.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/index.js"></script>
    <script src="static/js/category.js"></script>
</body>
</html>
