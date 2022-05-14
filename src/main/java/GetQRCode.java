import com.example.DbUtil;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class GetQRCode extends HttpServlet {

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
		// 需要返回的数据
		String ret = "false";
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select qrcode_content from qrcode where qrcode_id = " + qrcodeId + ";");
			if(rs.next()) {
				String content = rs.getString("qrcode_content");
				if(content == null) {
					ret = "null";
				}
				else {
					ret = content;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		out.print(ret);
	}
}
