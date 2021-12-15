import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.alibaba.fastjson.JSON;

public class ResetPrint extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
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
		String ret = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String message = "";
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			for(int i = 1; i < rownum; i++) {
				row = sheet.getRow(i);
				// 获取列数
				int columnNum = row.getPhysicalNumberOfCells();
				// 获取productId
				String productId = row.getCell(0).getRichStringCellValue()+"";
				if(productId.equals("")) continue;
				rs = stmt.executeQuery("select * from product where product_id ='"+productId+"';");
				if(rs.next()) {
					stmt.execute("update product set print=0 where product_id='"+productId+"';");
					SystemLog.log("管理员重置了构件(构件号为'"+productId+"')的打印次数!");
					message += "构件(构件号为'" + productId + "')已重置打印次数!</br>";
				}
				else{
					SystemLog.log("管理员重置构件(构件号为'"+productId+"')失败，系统中无此构件!");
					message += "系统中无构件(构件号为'"+productId+"')</br>";
				}
			}
			out.print(message);
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
