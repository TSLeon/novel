import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class loginCheck extends HttpServlet {
    public loginCheck(){
        super();
    }

    public void init(){

    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        doPost(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        String User_name = request.getParameter("user");
        String pswd = request.getParameter("pswd");
        String novel = request.getParameter("novel");
        String sql_pswd = null;
        int flag = 0;
        response.setCharacterEncoding("utf-8");
        String user_name = new String(User_name.getBytes("iso-8859-1"), "utf-8");


        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://127.0.0.1:3306/java_book";
        String user = "root";
        String password = "305219";

        try{
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement statement = conn.createStatement();

            String sql = "select pswd from user_info where user_name='"+user_name+"'";
            String sql_e = "select pswd, user_name from user_info where email='"+user_name+"'";

            ResultSet rs = statement.executeQuery(sql);
            int count = 0;
            while (rs.next()){
                sql_pswd = rs.getString("pswd");
                if(sql_pswd.equals(pswd)){
                    flag = 1;
                }
                count++;
            }
            String tem = null;
            if(count == 0){
                rs = statement.executeQuery(sql_e);
                while(rs.next()){
                    sql_pswd = rs.getString("pswd");
                    tem = rs.getString("user_name");
                    if(sql_pswd.equals(pswd)){
                        flag = 1;
                    }
                }
            }

            rs.close();
            statement.close();
            conn.close();

            if(flag == 1){
                if(count == 0)
                    request.getSession().setAttribute("user", tem);
                else
                    request.getSession().setAttribute("user", user_name);
                request.getSession().setMaxInactiveInterval(60*60);
                if(novel != null){
                    response.sendRedirect(request.getContextPath()+"/novel.jsp?novel="+novel);
                }else
                    response.sendRedirect(request.getContextPath()+"/index.jsp");
            }else{
                response.sendRedirect(request.getContextPath()+"/login.jsp?flag=false");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Sorry, can not find the Driver!");
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void destroy(){
        super.destroy();
    }
}
