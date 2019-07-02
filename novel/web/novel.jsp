<%--
  Created by IntelliJ IDEA.
  User: CCG
  Date: 2019/6/18
  Time: 21:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Comparator" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述三个标签必须放在title前面 -->

    <title>Book</title>

    <link rel="stylesheet" href="./static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/index.css">
    <link rel="stylesheet" href="static/css/novel.css">
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
                        <li><a href="category.jsp">分类</a></li>
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
                                out.println("<li><a href=\"login.jsp\" id=\"notLogin\">登录</a></li>");
                            }
                        %>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>

    </div>

    <%!
        String novel_name = null;
        String novel_author = null;
        String novel_type = null;
        String book_id = null;
        String start_url = null;
    %>
    <div class="container" id="novel_container">
        <div class="row" id="novel_row">
            <div class="col-xs-3  col-lg-2  col-sm-3  col-md-3">
                <%
                    book_id = request.getParameter("novel");
                    String driver = "com.mysql.jdbc.Driver";
                    String url = "jdbc:mysql://127.0.0.1:3306/java_book";
                    String user = "root";
                    String password = "305219";
                    try{
                        Class.forName(driver);
                        Connection conn = DriverManager.getConnection(url, user, password);
                        Statement statement = conn.createStatement();
                        String sql = "select book_name, author, type, hot, intro, img_name from book_info where book_id="+book_id;
                        ResultSet rs = statement.executeQuery(sql);
                        //String novel_name = null;
                        //String novel_author = null;
                        //String novel_type = null;
                        String novel_intro = null;
                        String novel_img = null;
                        int novel_hot = 0;
                        while(rs.next()){
                            novel_name = rs.getString("book_name");
                            novel_author = rs.getString("author");
                            novel_type = rs.getString("type");
                            novel_hot = rs.getInt("hot");
                            novel_intro = rs.getString("intro");
                            novel_img = rs.getString("img_name");
                            //show novel img
                            out.println("<a href=\"#\" id=\"img-a\">");
                            out.println("<img src=\"static/img/"+novel_img+"\" class=\"img-rounded img-self\">");
                            out.println("</a>");
                            out.println("</div>");

                            //show novel information
                            out.println("<div class=\"col-xs-9 col-lg-10 col-sm-9 col-md-9\">");
                            out.println("<h2><strong>" + novel_name + "</strong></h2>");
                            out.println("<h5>" + novel_author.replace("作者：","") + " 著</h4>");
                            out.println("<h5>类型：" + novel_type + "</h4>");
                            out.println("<h5>阅读量：" + novel_hot + "</h4>");
                            if(novel_intro.length() > 100)
                                out.println("<p>" + novel_intro.substring(0,100) + "...</p>");
                            else
                                out.println("<p>" + novel_intro + "</p>");


                        }
                        rs.close();
                        statement.close();
                        conn.close();
                    }catch (ClassNotFoundException e){
                        System.out.println("Sorry, can not find the Driver!");
                        e.printStackTrace();
                    }catch (SQLException e){
                        e.printStackTrace();
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                %>
                <!--
                <img src="#" alt="novel" class="img-rounded img-self">
            </div>
            <div class="col-xs-6 col-lg-7 col-sm-6 col-md-6">-->
                <!--
                <h2>novel name</h2>
                <h4>author</h4>
                <h4>type</h4>
                <h4>hot</h4>
                <p>resume</p> -->
                <%
                    start_url = "read/"+book_id+"/0";
                %>
                <a href="<%=start_url%>" class="btn-a">
                    <button class="btn" id="read-btn" style="display: inline">开始阅读</button>
                </a>
                <a href="#" class="btn-a">
                    <button class="btn" id="collect_btn" style="display: inline">加入书架</button>
                </a>
            </div>
        </div>
        <div class="row" id="row_control">
            <div>
                <ul>
                    <li class="control_li" id="remark_control"><a href="javascript:;"><h4>作品消息</h4></a></li>
                    <li class="control_li" id="category_control"><a href="javascript:;"><h4>章节目录</h4></a></li>
                </ul>
            </div>
        </div>
        <div class="row" id="remark">
            <div class="col-md-9">
                <h3 id="remark-head"><strong>作品评论区</strong></h3>
                <form action="remarkHandle?novel=<%=book_id%>" role="form" id="remark-form" method="post">
                    <div class="form-group">
                        <textarea name="remark_content" id="InputRemark" cols="30" rows="3" class="form-control"></textarea>
                    </div>
                    <button class="btn btn-danger" type="submit" onclick="submit_remark()">提交</button>
                </form>
                <div>
                    <ul class="list-unstyled">
                        <li>
                            <p>评论</p>
                        </li>
                        <%
                            try {
                                Class.forName(driver);
                                Connection conn = DriverManager.getConnection(url, user, password);
                                Statement statement = conn.createStatement();

                                String sql = "select user_name, remark from remark where book_id="+book_id;
                                ResultSet rs = statement.executeQuery(sql);

                                String uu = null;
                                String rm = null;
                                String rm_t;
                                while(rs.next()){
                                    uu = rs.getString("user_name");
                                    rm = rs.getString("remark");
                                    out.println("<li>");
                                    out.println("<p>"+uu+": "+rm+"</p>");
                                    out.println("</li>");
                                }

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
            </div>
            <div class="col-md-3" id="author-info">
                <div id="author-photo">
                    <img src="static/img/author.jpg" alt="author" class="img-circle">
                </div>
                <p class="text-center"><strong><%=novel_author.replace("作者：", "")%></strong></p>
            </div>
        </div>
        <div class="row" id="category">
            <h3 id="main-content"><strong>正文卷</strong></h3>
            <%!
                // file sort function
                int extractNumber(String name){
                    int i;
                    try{
                        String number = name.replace(".txt","");
                        i = Integer.parseInt(number);
                    }catch (Exception e){
                        i = 0;
                    }
                    return i;
                }

                List<File> sortFileByName(List<File> files, final String orderStr){
                    if(!orderStr.equalsIgnoreCase("asc") && orderStr.equalsIgnoreCase("desc")){
                        return files;
                    }
                    File[] files1 = files.toArray(new File[0]);
                    Arrays.sort(files1, new Comparator<File>() {
                        @Override
                        public int compare(File o1, File o2) {
                            int n1 = extractNumber(o1.getName());
                            int n2 = extractNumber(o2.getName());
                            if(orderStr == null || orderStr.length() < 1 || orderStr.equalsIgnoreCase("asc")){
                                return n1 - n2;
                            }else{
                                return n2 - n1;
                            }
                        }
                    });
                    return new ArrayList<File>(Arrays.asList(files1));
                }
            %>
            <%
                String BASE_PATH = "D:\\java_homework\\qishu_book\\"+novel_type+"\\"+novel_name;
                //File file = new File(BASE_PATH, "0.txt");
                //BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "utf-8"));
                //make file can read by line
                //can not use FileReader , it will cause Zh-em can not show
                //InputStreamReader implement parent method which can decode muti code with charset.

                //StringBuffer strB = new StringBuffer();//to store content of 0.txt
                //String str = br.readLine(); //read a line
                //strB.append(str).append("<br>");
                //br.close(); //close read;

                // acquire file name
                File new_file = new File(BASE_PATH);
                File[] list_file = new_file.listFiles();

                // make file names into a list
                List<File> file_list = new ArrayList<File>();
                for(File f : list_file)
                {
                    file_list.add(f);
                }

                // sort file list by name
                file_list = sortFileByName(file_list, "asc");

                out.println("<ul class=\"list-unstyled\">");
                int count = 0;
                for(File f : file_list){
                    if(count == 501) {
                        out.println("<a href=\"javascript:;\">");
                        out.println("<h2>加载更多</h2>");
                        out.println("</a>");
                        break;
                    }
                    //out.println(f.getName());
                    if(f.getName().equals("img.jpg") || f.getName().equals("Intro.txt")){
                        continue;
                    }
                    String txtName = f.getName();
                    String chapterPath = BASE_PATH + "\\" + txtName;
                    File chapterFile = new File(chapterPath);
                    BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(chapterFile), "utf-8"));

                    String str = br.readLine();
                    br.close();

                    out.print("<li class=\"category_li\">");
                    out.print("<a href=\"read/"+book_id+"/"+txtName.replace(".txt","")+"\">" + str + "</a>");
                    out.print("</li>");
                    count ++;

                }
                out.println("</ul>");
            %>
            <!--
            <ul>
                <li class="category_li"><a href="">测试</a></li>
                <li class="category_li"><a href="">测试</a></li>
                <li class="category_li"><a href="">测试</a></li>
                <li class="category_li"><a href="">测试</a></li>
            </ul>-->
        </div>
    </div>

    <!-- 模态框 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        请先登录
                    </h4>
                </div>
                <div class="modal-body">
                    <form action="loginCheck?novel=<%=book_id%>" id="moda-form" method="post">
                        <div class="form-group">
                            <label for="inputUser">用户名</label>
                            <input type="text" id="inputUser" placeholder="用户名" class="form-control" name="user">
                        </div>
                        <div class="form-group">
                            <label for="inputPswd">密码</label>
                            <input type="password" id="inputPswd" placeholder="密码" class="form-control" name="pswd">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">
                        关闭
                    </button>
                    <button type="button" class="btn btn-danger" onclick="modal_login()">
                        登录
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="static/js/jquery-3.3.1.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/index.js"></script>
    <script src="static/js/novel.js"></script>
</body>
</html>
