import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;

public class AddGroupFunction extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
	static final String USER = "root";
	static final String PASS = "123456";

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入 userName
		// 传入 groupId
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String id = new String(request.getParameter("id"));
		String name = new String(request.getParameter("name"));
		String groupId = new String(request.getParameter("groupId"));
		String faId = new String(request.getParameter("faId"));
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
			rs = stmt.executeQuery("select * from gp_function_authority where gp_id ="+groupId+" and fa_id ="+faId+";");
			if(rs.next()) {
				ret.put("result","false");
				ret.put("message","新增失败,群组id为"+groupId+"的群组已存在功能权限编号为"+faId+"的功能权限!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")的用户新增功能权限(功能权限编号为"+faId+")至群组编号为"+groupId+"的群组中失败!原因:该群组已存在该功能权限!");
				return;
			}
			rs = stmt.executeQuery("select max(gp_fa_id) from gp_function_authority;");
			int gpfaId = 0;
			if(rs.next()) {
				gpfaId = rs.getInt("max(gp_fa_id)")+1;
			}
			stmt.execute("insert into gp_function_authority values("+gpfaId+","+groupId+","+faId+");");
			rs = stmt.executeQuery("select * from gp_function_authority where gp_fa_id="+gpfaId+" and gp_id = "+groupId+" and fa_id ="+faId+";");
			if(!rs.next()) {
				ret.put("result","false");
				ret.put("message","数据库系统错误!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")的用户新增功能权限(功能权限编号为"+faId+")至群组编号为"+groupId+"的群组中失败!原因:数据库系统错误！");
				return;
			}
			ret.put("result","true");
			ret.put("message","新增成功!");
			out.print(JSON.toJSONString(ret));
			SystemLog.log(name+"(工号为"+id+")的用户新增功能权限(功能权限编号为"+faId+")至群组编号为"+groupId+"的群组中成功!");
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
