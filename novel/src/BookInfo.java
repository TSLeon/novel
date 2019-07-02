import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class BookInfo extends HttpServlet {
    public BookInfo(){
        super();
    }

    public void init(){
    }
    public void destroy(){
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        StringBuffer url = request.getRequestURL();
        String info = url.toString().split("/")[5];
        response.sendRedirect(request.getContextPath()+"/novel.jsp?novel="+info);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        this.doGet(request, response);
    }
}
