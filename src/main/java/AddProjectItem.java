import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class AddProjectItem extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 需要在写入时SystemLog
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		System.out.println(request);
		String id = new String(request.getParameter("id"));		// 处理人ID
		String name = new String(request.getParameter("name"));	// 处理人名
		String pikey = new String(request.getParameter("pikey"));					// project_item中的pi_key
		String pivalue = new String(request.getParameter("pivalue"));
		// 需要返回的数据
		HashMap<String,String> ret = new HashMap<String,String>();
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from project_item where pi_key='"+pikey+"' or pi_value='"+pivalue+"';");
			if(rs.next()){
				ret.put("result","false");
				ret.put("message","已存在项目字段名为'"+pivalue+"'或项目字段值为'"+pikey+"'的项目字段!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")新增项目字段'"+pivalue+"'失败(值为'"+pikey+"'!原因:已存在项目字段名为'"+pivalue+"'或项目字段值为'"+pikey+"'的项目字段!");
				return;
			}
			rs = stmt.executeQuery("select max(pi_id) from project_item;");
			int piId = 0;
			if(rs.next()) {
				piId = rs.getInt("max(pi_id)")+1;
			}
			stmt.execute("insert into project_item values("+piId+",'"+pikey+"','"+pivalue+"');");
			rs = stmt.executeQuery("select * from project_item where pi_id="+piId+" and pi_key='"+pikey+"' and pi_value='"+pivalue+"';");
			if(!rs.next()) {
				ret.put("result","false");
				ret.put("message","数据库系统失败!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")新增项目字段'"+pivalue+"'失败(值为'"+pikey+"'的项目字段失败!原因:数据库系统失败!");
				return;
			}
			ret.put("result","true");
			ret.put("message","新增成功!");
			SystemLog.log(name+"(工号为"+id+")新增项目字段'"+pivalue+"'(值为'"+pikey+"')成功!");
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
