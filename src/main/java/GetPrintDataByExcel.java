import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.example.DbUtil;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.alibaba.fastjson.JSON;

public class GetPrintDataByExcel extends HttpServlet {

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
		ArrayList<String> info = new ArrayList<String>();		// 报错信息汇总
		ArrayList<HashMap<String,String>> data = new ArrayList<HashMap<String,String>>();	// 数据
		HashMap<String,Object> ret = new HashMap<String,Object>();	// 返回信息
		ArrayList<String> fieldValues = new ArrayList<String>();	// 放置字段的值
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getCon();
			stmt = conn.createStatement();
			String retString = null;
			// 获取第一行，并检测是否存在非系统内字段
			row = sheet.getRow(0);
			int columnNum = row.getPhysicalNumberOfCells();
			for(int i = 1; i < columnNum; i++){
				// 获取字段名
				String fieldName = row.getCell(i).getRichStringCellValue().getString();
				// 检测是否存在该字段
				rs = stmt.executeQuery("select pi_key from project_item where pi_value ='"+fieldName+"';");
				if(rs.next()){
					fieldValues.add(rs.getString("pi_key"));
				}
				else {
					info.add("字段'"+fieldName+"'不存在!请查验!");
					ret.put("info",info);
					ret.put("data",data);
					retString = JSON.toJSONString(ret);
					out.print(retString);
					return;
				}
			}
			// 循环填入data
			for(int i = 1; i < rownum; i++){
				// 获取该行
				row = sheet.getRow(i);
				// 获取列数
				columnNum = row.getPhysicalNumberOfCells();
				HashMap<String,String> recode = new HashMap<String,String>();		// 一行的记录
				// 判断这一行有没有数据
				if(row.getCell(0) == null) continue;
				for(int j = 1; j < columnNum; j++){
					// 获取内容
					row.getCell(j).setCellType(CellType.STRING);
					String value = row.getCell(j).getRichStringCellValue().getString();
					// 放入记录
					recode.put(fieldValues.get(j-1),value);
				}
				// 将记录放入数据中
				data.add(recode);
			}
			// 组成最终数据
			ret.put("info","true");
			ret.put("data",data);
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
		String retString = JSON.toJSONString(ret);
		out.print(retString);
	}
}
