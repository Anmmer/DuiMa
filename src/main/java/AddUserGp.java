import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class AddUserGp extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入 userId
		// 传入 groupId
		// 传入 processorId
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String id = new String(request.getParameter("id"));
		String name = new String(request.getParameter("name"));
		String userId = new String(request.getParameter("userId"));
		String gpId = new String(request.getParameter("groupId"));
		// 需要返回的数据
		HashMap<String,String> ret = new HashMap<String,String>();
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select max(ugp_id) from user_gp;");
			int ugpId = 0;
			if(rs.next()) {
				ugpId = rs.getInt("max(ugp_id)")+1;
			}
			stmt.execute("insert into user_gp values("+ugpId+","+userId+","+gpId+");");
			rs = stmt.executeQuery("select * from user_gp where user_id="+userId+" and gp_id ="+gpId+";");
			if(!rs.next()) {
				ret.put("result","false");
				ret.put("message","数据库系统错误!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")新增用户(工号为"+userId+")进入群组(编号为"+gpId+")失败!原因:数据库系统错误!");
				return;
			}
			ret.put("result","true");
			ret.put("message","新增成功!");
			SystemLog.log(name+"(工号为"+id+")新增用户(工号为"+userId+")进入群组(编号为"+gpId+")成功!");
			out.print(JSON.toJSONString(ret));
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
	}
}
