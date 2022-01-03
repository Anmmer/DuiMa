import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import com.alibaba.fastjson.JSON;
// 出库、入库
public class InOutWarehouse extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
	static final String USER = "root";
	static final String PASS = "123456";

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入equipmentName
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String pids = new String(request.getParameter("productIds"));			// 需要入库、出库的构件号集合
		List<String> products = JSON.parseArray(pids,String.class);
		String warehouseId = new String(request.getParameter("warehouseId"));			// 货位编号
		String type = new String(request.getParameter("type"));					// 出库，入库类型	1为入库，0为出库
		boolean flag = type.equals("1");
		String id = new String(request.getParameter("userId"));					// 操作人工号
		String name = new String(request.getParameter("userName"));				// 操作人名
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
			String msg = "";					// 返回的信息
			for(int i = 0; i < products.size(); i++) {
				String productId = products.get(i);
				// 检查是否在库存内  ->  信息写入warehouse_info  ->  信息写入product
				//					 |
				//					 ->  出错写入msg
				java.util.Date now = new java.util.Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String nowstr = sdf.format(now);
				if(flag){
					// 入库操作
					rs = stmt.executeQuery("select product_id from product where product_id='"+productId+"' and warehouse_id is null;");
					if(!rs.next()) {
						msg += "'" + productId + "'已在库内，入库失败!\n";
						continue;
					}
					stmt.execute("insert into warehouse_info values('"+nowstr+"','"+productId+"',"+id+","+type+","+warehouseId+");");
					stmt.execute("update product set warehouse_id="+warehouseId+" where product_id='"+productId+"';");
				}
				else{
					// 出库操作
					rs = stmt.executeQuery("select product_id,warehouse_id from product where product_id='"+productId+"' and warehouse_id is not null;");
					if(!rs.next()){
						msg += "'" + productId + "'未在库中，出库失败!\n";
						continue;
					}
					warehouseId = rs.getString("warehouse_id");		// 对每一个出库的都检查其warehouseId
					stmt.execute("insert into warehouse_info values('"+nowstr+"','"+productId+"',"+id+","+type+","+warehouseId+");");
					stmt.execute("update product set warehouse_id=NULL where product_id='"+productId+"';");
				}
			}
			ret.put("msg",msg);
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
