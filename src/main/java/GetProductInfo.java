import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

// 微信小程序获取产品信息
public class GetProductInfo extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入equipmentName
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String productId = new String(request.getParameter("productId"));
		// 需要返回的数据
		HashMap<String,String> ret = new HashMap<String,String>();
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			// 查询生产流程信息
			rs = stmt.executeQuery("select produce_time,user_name,pc_name from produce,user,process_content where produce.user_id=user.user_id and process_content_id = pc_id and product_id='"+productId+"' order by produce_time ASC;");
			ArrayList<HashMap<String,String>> produceInfo = new ArrayList<HashMap<String,String>>();
			while(rs.next()) {
				HashMap<String,String> info = new HashMap<String,String>();
				info.put("produce_time",rs.getString("produce_time"));
				info.put("user_name",rs.getString("user_name"));
				info.put("pc_name",rs.getString("pc_name"));
				produceInfo.add(info);
			}
			ret.put("produceInfo",JSON.toJSONString(produceInfo));
			// 查询仓储信息
			rs = stmt.executeQuery("select warehouse_name,factory_name from product,warehouse,factory where product.warehouse_id = warehouse.warehouse_id and product_id='"+productId+"' and warehouse.factory_id = factory.factory_id;");
			if(rs.next()){
				ret.put("warehouse_name",rs.getString("warehouse_name"));
				ret.put("factory_name",rs.getString("factory_name"));
			}
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
