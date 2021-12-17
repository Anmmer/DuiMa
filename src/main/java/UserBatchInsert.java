import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.alibaba.fastjson.JSON;

public class UserBatchInsert extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://8.142.26.93:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
	static final String USER = "root";
	static final String PASS = "123456";

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		return;
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 传入 xls文件
		// 返回true,或者报错信息
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取文件
		byte[] junk = new byte[1024];
		int bytesRead = 0;
		ServletInputStream is = request.getInputStream();
		bytesRead = is.readLine(junk,0,junk.length);
		bytesRead = is.readLine(junk,0,junk.length);
		bytesRead = is.readLine(junk,0,junk.length);
		bytesRead = is.readLine(junk,0,junk.length);
		Workbook wb = null;
		Sheet sheet = null;
		Row row = null;
		wb = new HSSFWorkbook(is);
		sheet = wb.getSheetAt(0);
		int rownum = sheet.getPhysicalNumberOfRows();
		ArrayList<String> ret = new ArrayList<String>();		// 报错信息汇总
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			for(int i = 1; i < rownum; i++) {
				row = sheet.getRow(i);
				// 获取列数
				int columnNum = row.getPhysicalNumberOfCells();
				// 获取序号
				String num = row.getCell(0).getNumericCellValue()+"";
				// 获取用户名字
				String userName = row.getCell(1).getRichStringCellValue().getString();
				// 新增用户
				rs = stmt.executeQuery("select max(user_id) from user;");
				int userId = 0;
				if(!rs.next()){
					ret.add("序号为"+num+",姓名为"+userName+"的用户，新增失败!");
					SystemLog.log("管理员新增名为'"+userName+"'的用户失败!原因:数据库系统错误!");
					continue;
				}else userId = rs.getInt("max(user_id)") + 1;
				stmt.execute("insert into user values("+userId+",'"+userName+"',NULL,123456,1,NULL);");
				rs = stmt.executeQuery("select * from user where user_id="+userId+" and user_name = '"+userName+"';");
				if(!rs.next()){
					ret.add("序号为"+num+",姓名为"+userName+"的用户，新增失败!");
					SystemLog.log("管理员新增名为'"+userName+"'的用户失败!原因:数据库系统错误!");
					continue;
				}else {
					// 用户新增成功
					SystemLog.log("管理员新增用户'"+userName+"'(工号为"+userId+"'成功!");
					for(int j = 2; j < columnNum; j++){
						// 循环获取群组名字
						String groupName = row.getCell(j).getRichStringCellValue().getString();
						if(groupName=="") continue;
						rs = stmt.executeQuery("select gp_id from gp where gp_name ='"+groupName+"';");
						int groupId = 0;
						if(!rs.next()){
							ret.add("序号为"+num+",姓名为"+userName+"的用户，其角色'"+groupName+"'不存在!");
							SystemLog.log("管理员设置用户群组'"+groupName+"'失败!原因:无该用户群组!");
							continue;
						}
						else groupId = rs.getInt("gp_id");
						rs = stmt.executeQuery("select max(ugp_id) from user_gp;");
						int ugpId = 0;
						if(!rs.next()){
							ret.add("序号为"+num+",姓名为"+userName+"的用户新增成功，但其角色'"+groupName+"'设置失败，请于修改界面手动设置!");
							SystemLog.log("管理员给'"+userName+"'(工号为"+userId+")设置群组'"+groupName+"'(群组编号"+groupId+")失败!原因:数据库系统错误!");
							continue;
						}
						else ugpId = rs.getInt("max(ugp_id)")+1;
						stmt.execute("insert into user_gp values("+ugpId+","+userId+","+groupId+");");
						rs = stmt.executeQuery("select * from user_gp where ugp_id="+ugpId+" and user_id ="+userId+";");
						if(!rs.next()){
							ret.add("序号为"+num+",姓名为"+userName+"的用户新增成功，但其角色'"+groupName+"'设置失败,请于修改界面手动设置!");
							SystemLog.log("管理员给'"+userName+"'(工号为"+userId+")设置群组'"+groupName+"'(群组编号"+groupId+")失败!原因:数据库系统错误!");
							continue;
						}
					}
				}
			}
			ret.add("完成批量新增!");
		}catch(Exception e) {
			try{
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}
		String retString = JSON.toJSONString(ret);
		out.print(retString);
	}
}
