import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class read extends HttpServlet {
    public read(){
        super();
    }

    public void init(){

    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        String url = request.getRequestURL().toString();
        String novel_id = url.split("/")[5];
        String novel_chapter = url.split("/")[6];
        response.sendRedirect(request.getContextPath()+"/read.jsp?novel="+novel_id+"&chapter="+novel_chapter);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        this.doGet(request, response);
    }

    public void destroy(){
        super.destroy();
    }
}
