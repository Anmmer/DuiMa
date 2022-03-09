import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;

public class AddGroupProcessContent extends HttpServlet {
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
		String pcId = new String(request.getParameter("pcId"));
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
			rs = stmt.executeQuery("select * from gp_process_content where gp_id ="+groupId+" and pc_id ="+pcId+";");
			if(rs.next()) {
				ret.put("result","false");
				ret.put("message","权限已存在!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")新增工序权限失败!原因:编号为"+groupId+"的群组已存在编号为"+pcId+"的工序权限!");
				return;
			}
			rs = stmt.executeQuery("select max(gp_pc_id) from gp_process_content;");
			int gppcId = 0;
			if(rs.next()) {
				gppcId = rs.getInt("max(gp_pc_id)")+1;
			}
			stmt.execute("insert into gp_process_content values("+gppcId+","+groupId+","+pcId+");");
			rs = stmt.executeQuery("select * from gp_process_content where gp_pc_id="+gppcId+" and gp_id = "+groupId+" and pc_id ="+pcId+";");
			if(!rs.next()) {
				ret.put("result","false");
				ret.put("message","数据库系统出错!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")向编号为"+groupId+"的群组新增编号为"+pcId+"的工序权限失败!原因:数据库系统出错!");
				return;
			}
			ret.put("result","true");
			ret.put("message","新增成功!");
			SystemLog.log(name+"(工号为"+id+")向编号为"+groupId+"的群组新增编号为"+pcId+"的工序权限成功!");
			out.print(JSON.toJSONString(ret));
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
