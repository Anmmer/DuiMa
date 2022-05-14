import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class AddEquipment extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入equipmentName
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		String id = new String(request.getParameter("id"));				// 处理人工号
		String name = new String(request.getParameter("name"));			// 处理人姓名
		String equipmentName = new String(request.getParameter("equipmentName"));
		// 需要返回的数据
		HashMap<String,String> ret = new HashMap<String,String>();
		// 连接数据库查询
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			// 检测有无重名(当前存在的所有设备检测)
			rs = stmt.executeQuery("select * from equipment where equipment_name='"+equipmentName+"' and equipment_status=1;");
			if(rs.next()) {
				ret.put("result","false");
				ret.put("cause",name+"(工号为"+id+")新增设备失败!失败原因:‘有重名设备!’");
				SystemLog.log(name+"(工号为"+id+")新增设备失败!失败原因:‘有重名设备!’");
				out.print(JSON.toJSONString(ret));
				return;
			}
			rs = stmt.executeQuery("select max(equipment_id) from equipment;");
			int equipmentId = 0;
			if(rs.next()) {
				equipmentId = rs.getInt("max(equipment_id)")+1;
			}
			stmt.execute("insert into equipment values("+equipmentId+",'"+equipmentName+"',1);");
			rs = stmt.executeQuery("select * from equipment where equipment_id="+equipmentId+" and equipment_name ='"+equipmentName+"' and equipment_status=1;");
			if(!rs.next()){
				ret.put("result","false");
				ret.put("cause",name+"(工号为"+id+")新增设备失败!失败原因:‘数据库插入失败!’");
				SystemLog.log(name+"(工号为"+id+")新增设备失败!失败原因:‘数据库插入失败!’");
				out.print(JSON.toJSONString(ret));
				return;
			}
			ret.put("result","true");
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
		out.print(JSON.toJSONString(ret));
	}
}
