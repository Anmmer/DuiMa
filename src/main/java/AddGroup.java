import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class AddGroup extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		doPost(request,response);
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入 userName
		// 传入 groupId
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String name = new String(request.getParameter("name"));
		String id = new String(request.getParameter("id"));
		String groupName = new String(request.getParameter("groupName"));
		// 需要返回的数据
		HashMap<String,String> ret = new HashMap<String,String>();
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			// 检测有无重名
			rs = stmt.executeQuery("select * from gp where gp_name='"+groupName+"' and gp_status=1;");
			if(rs.next()) {
				ret.put("result","false");
				ret.put("message","该群组重名!");
				SystemLog.log(name+"(工号为"+id+")新增群组失败!原因:系统已存在名为'"+groupName+"'的群组!");
				out.print(JSON.toJSONString(ret));
				return;
			}
			rs = stmt.executeQuery("select max(gp_id) from gp;");
			int gpId = 0;
			if(rs.next()) {
				gpId = rs.getInt("max(gp_id)")+1;
			}
			stmt.execute("insert into gp values("+gpId+",'"+groupName+"',1);");
			rs = stmt.executeQuery("select * from gp where gp_id="+gpId+" and gp_name ='"+groupName+"';");
			if(!rs.next()){
				ret.put("result","false");
				ret.put("message","数据库系统错误!请重新提交新增!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")新增群组'"+groupName+"'失败!原因:数据库错误!");
				return;
			}
			ret.put("result","true");
			ret.put("message","新增成功!");
			out.print(JSON.toJSONString(ret));
			SystemLog.log(name+"(工号为"+id+")新增群组'"+groupName+"'成功!");
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
