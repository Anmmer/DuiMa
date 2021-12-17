import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;

public class AddWarehouse extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://8.142.26.93:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
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
		String factoryId = new String(request.getParameter("factoryId"));
		String warehouseName = new String(request.getParameter("warehouseName"));
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
			rs = stmt.executeQuery("select * from warehouse where warehouse_name='"+warehouseName+"' and factory_id="+factoryId+" and warehouse_status=1;");
			if(rs.next()) {
				ret.put("result","false");
				ret.put("message","编号为"+factoryId+"的库存组织已存在名为'"+warehouseName+"'的库位");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")在编号为"+factoryId+"的库存组织中新增货位'"+warehouseName+"'失败!原因:该库存组织已存在同名库位");
				return;
			}
			rs = stmt.executeQuery("select max(warehouse_id) from warehouse;");
			int warehouseId = 0;
			if(rs.next()) {
				warehouseId = rs.getInt("max(warehouse_id)")+1;
			}
			stmt.execute("insert into warehouse values("+warehouseId+",'"+warehouseName+"',"+factoryId+",1);");
			rs = stmt.executeQuery("select * from warehouse where warehouse_id="+warehouseId+" and warehouse_name ='"+warehouseName+"' and factory_id="+factoryId+";");
			if(!rs.next()){
				ret.put("result","false");
				ret.put("message","数据库系统错误!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")在编号为"+factoryId+"的库存组织中新增库位'"+warehouseName+"'失败!原因:数据库系统错误!");
				return;
			}
			else {
				// 生成图片
				ret.put("result","true");
				ret.put("message","新增成功!");
				out.print(JSON.toJSONString(ret));
				SystemLog.log(name+"(工号为"+id+")在编号为"+factoryId+"的库存组织中新增库位'"+warehouseName+"'成功!");
			}
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
