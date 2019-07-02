import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class HTMLServlet extends HttpServlet {
    public HTMLServlet(){
        super();
    }
    public void destroy(){
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        this.doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        //response.setContentType("text/html");
        //PrintWriter out = response.getWriter();
        //out.println("Hello World!");
        //out.close();
        request.setAttribute("list", "asdf");
        request.getRequestDispatcher("/novel.jsp").forward(request, response);
    }

    @Override
    public void init() throws ServletException{
        String message = "Hello world, this message is from servlet";
    }
}
