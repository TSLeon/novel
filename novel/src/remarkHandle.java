import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class remarkHandle extends HttpServlet {
    public remarkHandle(){
        super();
    }
    public void init() {

    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String remark = request.getParameter("remark_content");
        String novel_id = request.getParameter("novel");
        Object user_name = request.getSession().getAttribute("user");

        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://127.0.0.1:3306/java_book";
        String user = "root";
        String password = "305219";

        response.setCharacterEncoding("utf-8");
        String Remark = new String(remark.getBytes("ISO-8859-1"),"utf-8");

        try {
            Class.forName(driver);
            Connection connection = DriverManager.getConnection(url, user, password);
            Statement statement = connection.createStatement();

            String sql = "insert into remark (user_name,book_id,remark,reply) values ('"+user_name.toString()+"','"+novel_id+"','"+Remark+"','0')";
            statement.executeUpdate(sql);

            statement.close();
            connection.close();
            response.sendRedirect(request.getContextPath()+"/novel.jsp?novel="+novel_id);
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
