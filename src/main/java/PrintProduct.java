import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class PrintProduct extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String id = new String(request.getParameter("id"));
		String name = new String(request.getParameter("name"));
		String productIds = new String(request.getParameter("productIds"));
		List<String> pidList = JSON.parseArray(productIds,String.class);
		List<String> trueList = new ArrayList<String>();			// 可以打印的构件号列表
		// 需要返回的数据
		HashMap<String,String> ret = new HashMap<String,String>();
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			String message = "";
			for(int i = 0; i < pidList.size(); i++) {
				// 检查构建是否存在，不存在放入数据库
				rs = stmt.executeQuery("select * from product where product_id='"+pidList.get(i)+"';");
				System.out.println("查看是否存在"+pidList.get(i));
				if(!rs.next()){
					// 不存在，直接插入
					System.out.println("不存在"+pidList.get(i));
					stmt.execute("insert into product values('"+pidList.get(i)+"',1,NULL,NULL,NULL,1,1);");
					trueList.add(pidList.get(i));
					continue;
				}
				// 检查构件是否可以打印
				rs = stmt.executeQuery("select * from product where product_id='"+pidList.get(i)+"' and print=0;");
				if(rs.next()){
					// 可以打印
					stmt.execute("update product set print=1 where product_id='"+pidList.get(i)+"';");
					SystemLog.log(name+"(工号为"+id+")打印了构件(构件号为'"+pidList.get(i)+"')");
					trueList.add(pidList.get(i));
				}
				else{
					// 不可以打印
					SystemLog.log(name+"(工号为"+id+")打印构件(构件号为'"+pidList.get(i)+"')失败!该构件已打印过!");
					message += "构件(构件号为'" + pidList.get(i) + "')已打印过!请联系管理员重置打印次数!</br>";
				}
			}
			ret.put("message",message);
			ret.put("data",JSON.toJSONString(trueList));
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
