import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;

public class GetWarehouseInfo extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://8.142.26.93:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
	static final String USER = "root";
	static final String PASS = "123456";

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入 warehouse_id
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String warehouseId = new String(request.getParameter("warehouseId"));
		// 需要返回的数据
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<String> ret = new ArrayList<String>();
		HashMap<String,String> maptmp = new HashMap<String,String>();
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			// 获取该仓库具有的products
			rs = stmt.executeQuery("select product.product_id,wi_time,user_name from warehouse_info,product,user where product.product_id = warehouse_info.product_id and product.warehouse_id="+warehouseId+" and warehouse_info.user_id = user.user_id and wi_type = 1 order by wi_time DESC;");
			// product可能会重复入库出库，所有数据放入ret时过滤一遍
			while(rs.next()) {
				String wiTime = rs.getString("wi_time");
				String productId = rs.getString("product_id");
				String userName = rs.getString("user_name");
				if(!maptmp.containsKey(productId)) {
					// 不存在记录插入
					HashMap<String,String> insertmap = new HashMap<String,String>();
					insertmap.put("wiTime",wiTime);
					insertmap.put("productId",productId);
					insertmap.put("userName",userName);
					ret.add(JSON.toJSONString(insertmap));
					maptmp.put(productId,"true");
				}
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
		String retStr = JSON.toJSONString(ret);
		out.print(ret);
	}
}
