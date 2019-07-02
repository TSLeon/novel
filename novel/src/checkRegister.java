import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class checkRegister extends HttpServlet {
    public checkRegister(){
        super();
    }

    public void init(){

    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException{
        doPost(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws  IOException{
        String User_name = request.getParameter("user");
        String email = request.getParameter("email");
        String pswd = request.getParameter("pswd");
        response.setCharacterEncoding("utf-8");
        String user_name = new String(User_name.getBytes("iso-8859-1"),"utf-8");

        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://127.0.0.1:3306/java_book";
        String user = "root";
        String password = "305219";

        try{
            Class.forName(driver);
            Connection connection = DriverManager.getConnection(url, user, password);
            Statement statement = connection.createStatement();

            // check user
            String sql = "select user_name from user_info where user_name='"+user_name+"'";
            ResultSet rs = statement.executeQuery(sql);
            int count = 0;
            while(rs.next()){
                count++;
            }

            // check email
            sql = "select email from user_info where email='"+email+"'";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                count++;
            }

            if(count != 0){
                response.sendRedirect(request.getContextPath()+"/register.jsp?rg=false");
            }else{
                sql = "insert into user_info values ('"+user_name+"','"+email+"','"+pswd+"')";
                statement.executeUpdate(sql);

                request.getSession().setAttribute("user", user_name);
                request.getSession().setMaxInactiveInterval(60*60);

                /*
                Cookie cookie = new Cookie("JSESSIONID", request.getSession().getId());
                cookie.setPath("/");
                cookie.setMaxAge(60);
                response.addCookie(cookie);*/
                response.sendRedirect(request.getContextPath()+"/index.jsp?rg=true");
            }
            rs.close();
            statement.close();
            connection.close();
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
