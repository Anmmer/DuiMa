import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class PostTest extends HttpServlet {
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// doPost
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String name = new String(request.getParameter("name").getBytes("ISO8859-1"),"UTF-8");
		out.println(name);
	}
}
