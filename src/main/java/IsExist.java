import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import com.alibaba.fastjson.JSON;

public class IsExist extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://8.142.26.93:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
	static final String USER = "root";
	static final String PASS = "123456";

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
//			File file = new File("src/main/webapp/lisys/logs/"+filename);
			File file = new File("C:\\Project\\DuiMa\\src\\main\\webapp\\lisys\\logs\\"+filename);
			if(file.exists()) out.print("true");
			else out.print("false");
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}