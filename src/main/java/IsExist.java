import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import com.alibaba.fastjson.JSON;

public class IsExist extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// doPost
		// 返回JSON文件 例:{ret:True, userName:"xxx"}
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String filename = new String(request.getParameter("filename"));
		// 连接数据库查询
		try{
//			File file = new File("src/main/webapp/ljsys/logs/"+filename);
			File file = new File("C:\\Project\\DuiMa\\src\\main\\webapp\\ljsys\\logs\\"+filename);
			if(file.exists()) out.print("true");
			else out.print("false");
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
