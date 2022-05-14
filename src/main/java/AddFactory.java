import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class AddFactory extends HttpServlet {

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
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String factoryName = request.getParameter("factoryName");
		String factoryAddress = request.getParameter("factoryAddress");
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
			rs = stmt.executeQuery("select * from factory where factory_name='"+factoryName+"' and factory_status=1;");
			if(rs.next()) {
				ret.put("result","false");
				ret.put("message","仓储组织重名!");
				SystemLog.log(name+"(工号为"+id+")新增仓储组织失败!原因是系统已存在名为"+factoryName+"的仓储组织");
				out.print(JSON.toJSONString(ret));
				return;
			}
			rs = stmt.executeQuery("select max(factory_id) from factory;");
			int factoryId = 0;
			if(rs.next()) {
				factoryId = rs.getInt("max(factory_id)")+1;
			}
			stmt.execute("insert into factory values("+factoryId+",'"+factoryName+"','"+factoryAddress+"',1);");
			rs = stmt.executeQuery("select * from factory where factory_id="+factoryId+" and factory_name ='"+factoryName+"';");
			if(!rs.next()){
				ret.put("result","false");
				ret.put("message","数据库系统错误!请重新提交新增!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")新增仓储组织'"+factoryName+"'失败!失败原因:数据库错误!");
				return;
			}
			ret.put("result","true");
			ret.put("message","新增仓储组织成功!");
			out.print(JSON.toJSONString(ret));
			SystemLog.log(name+"(工号为"+id+")新增仓储组织'"+factoryName+"'成功!");
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
