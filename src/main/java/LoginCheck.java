import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;

public class LoginCheck extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/ljsys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
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
		String userId = new String(request.getParameter("userId"));
		String userPwd = new String(request.getParameter("userPwd"));
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String ret = "false";
		String userName = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from user where user_id = "+userId+" and user_pwd = '"+userPwd+"';");
			if(rs.next()) {
				userName = rs.getString("user_name");
				ret = "true";
				SystemLog.log("工号为"+userId+"登陆成功!");
			}
		}catch(Exception e) {
			try{
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("ret",ret);
		map.put("userName",userName);
		String mapStr = JSON.toJSONString(map);
		out.print(mapStr);
	}
}
