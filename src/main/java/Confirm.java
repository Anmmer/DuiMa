import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;

// 让构件完成目前所在的工序
public class Confirm extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/ljsys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
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
		String productId = new String(request.getParameter("productId"));
		String userId = new String(request.getParameter("userId"));
		String userName = new String(request.getParameter("userName"));
		// 需要返回的数据
		String ret = "true";
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String nextId = null;
		String processId = null;
		String pcId = null;
		String nowstr = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			// 获取构件目前所在的流程
			rs = stmt.executeQuery("select process_id, process_content_id from product where product_id='"+productId+"';");
			if(rs.next()){
				processId = rs.getString("process_id");
				pcId = rs.getString("process_content_id");
				// 获取下一流程号
				rs = stmt.executeQuery("select pps_next_id from pps where process_id="+processId+" and process_content_id="+pcId+";");
				if(rs.next()){
					nextId = rs.getString("pps_next_id");
					System.out.println("nextId:"+nextId);
					if(nextId==null) {
						// 流程全部结束
						stmt.execute("update product set process_content_id=NULL where product_id='"+productId+"';");
					}
					else{
						stmt.execute("update product set process_content_id="+nextId+" where product_id='"+productId+"';");
					}
				}
				else{
					System.out.println("no rs.next()");
				}
				String produceId = productId+"_"+processId;
				java.util.Date now = new java.util.Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				nowstr = sdf.format(now);
				stmt.execute("insert into produce values('"+produceId+"','"+productId+"',"+pcId+",NULL,'"+nowstr+"',"+userId+");");
			}
			out.print(ret);
			SystemLog.log(userName+"(工号为"+userId+")在"+nowstr+"时，确认构件(构件号为"+productId+")完成了编号为"+pcId+"的工序!");
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
