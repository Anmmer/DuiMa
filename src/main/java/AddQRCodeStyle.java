import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;

public class AddQRCodeStyle extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://8.142.26.93:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
	static final String USER = "root";
	static final String PASS = "123456";

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String id = new String(request.getParameter("id"));
		String name = new String(request.getParameter("name"));
		String qrcodeName = new String(request.getParameter("qrcodeName"));
		// 需要返回的数据
		HashMap<String,String> ret = new HashMap<String,String>();
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			// 检测有无重名
			rs = stmt.executeQuery("select * from qrcode where qrcode_name='"+qrcodeName+"' and qrcode_status=1;");
			if(rs.next()) {
				ret.put("result","false");
				ret.put("message","系统已存在名为'"+qrcodeName+"'的二维码样式!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")新增二维码样式失败!原因:系统已存在名为'"+qrcodeName+"'的二维码样式!");
				return;
			}
			rs = stmt.executeQuery("select max(qrcode_id) from qrcode;");
			int qrcodeId = 0;
			if(rs.next()) {
				qrcodeId = rs.getInt("max(qrcode_id)")+1;
			}
			stmt.execute("insert into qrcode values("+qrcodeId+",'"+qrcodeName+"',NULL,1);");
			rs = stmt.executeQuery("select * from qrcode where qrcode_id="+qrcodeId+" and qrcode_name ='"+qrcodeName+"';");
			if(!rs.next()){
				ret.put("result","false");
				ret.put("message","数据库系统失败!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")新增名为'"+qrcodeName+"'的二维码样式失败!原因:数据库系统失败!");
				return;
			}
			ret.put("result","true");
			ret.put("message","新增成功!");
			out.print(JSON.toJSONString(ret));
			SystemLog.log(name+"(工号为"+id+")新增名为'"+qrcodeName+"'的二维码样式成功!");
		}catch(Exception e) {
			try{
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}
	}
}
