import com.sun.deploy.net.HttpResponse;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class category extends HttpServlet {
    public category(){
        super();
    }

    public void init()
    {

    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        String url = request.getRequestURL().toString();
        String flag = request.getParameter("flag");
        String type = request.getParameter("type");
        String tag = null;
        if(flag != null){
            tag = url.split("/")[5].split("\\?")[0];
        }else{
            tag = url.split("/")[5];
        }

        if(flag != null){
            if(type != null){
                response.sendRedirect(request.getContextPath()+"/category.jsp?flag=1&type="+type+"&page="+tag);
            }else{
                response.sendRedirect(request.getContextPath()+"/category.jsp?flag=1&page=0&type="+tag);
            }
        }else{
            response.sendRedirect(request.getContextPath()+"/category.jsp?page="+tag);
        }

        /*
        String page = url.split("/")[5];
        response.sendRedirect(request.getContextPath()+"/category.jsp?page="+page);*/
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        doGet(request, response);
    }

    public void destroy(){
        super.destroy();
    }

}
