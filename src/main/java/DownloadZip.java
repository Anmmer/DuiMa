import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class DownloadZip extends HttpServlet {
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入ptId
		String ptId= new String(request.getParameter("ptId"));
		response.setCharacterEncoding("utf-8");
		response.setHeader("Content-Disposition","attachment; filename="+ptId+".zip");
		ServletOutputStream out = response.getOutputStream();
		// 打开文件
		File f = new File("C:\\Users\\Administrator\\Desktop\\堆码项目源代码\\tomcat\\webapps\\ROOT\\ljsys\\pictures\\zips\\"+ptId+".zip");
		if(f.exists()){
			FileInputStream fis = new FileInputStream(f);
			byte[] b = new byte[fis.available()];
			fis.read(b);
			out.write(b);
			out.flush();
			out.close();
		}
	}
}
