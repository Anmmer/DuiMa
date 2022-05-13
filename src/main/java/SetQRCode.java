import com.example.DbUtil;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class SetQRCode extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入equipmentName
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String qrcodeId = new String(request.getParameter("qrcodeId"));
		String qrcodestyle = new String(request.getParameter("qrcodestyle"));
		// 需要返回的数据
		String ret = "false";
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			stmt.execute("update qrcode set qrcode_content = '"+qrcodestyle+"' where qrcode_id = "+qrcodeId+";");
			ret = "true";
		}catch(Exception e) {
			try{
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}
		out.print(ret);
	}
}
