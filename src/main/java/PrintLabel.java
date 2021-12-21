import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.alibaba.fastjson.JSON;
import java.nio.file.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.text.SimpleDateFormat;

// 打印标签
public class PrintLabel extends HttpServlet {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/ljsys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
	static final String USER = "root";
	static final String PASS = "123456";

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		// 返回 true 或者 错误信息 或者 false
		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 获取、转换参数
		// 传入data
		String data = new String(request.getParameter("data"));
		// 将data转换为PrintInfo对象
		PrintInfo printInfo = JSON.parseObject(data, PrintInfo.class);
		int qrcodeId = printInfo.getQrcodeId();
		ArrayList<HashMap<String,String>> list = printInfo.getList();
		HashMap<String,String> map = printInfo.getMymap();
		int turnover = printInfo.getTurnover();
		boolean flag = false;
		if(turnover == 1) flag = true;
		else flag = false;
		int userid = printInfo.getUserid();
		String taskname = printInfo.getTaskname();
		if(taskname==null) taskname = "DEFAULT";
		// 新建一个打印任务并设置任务备注名，任务状态，打印申请人
		// 获取QRCodeStyle
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String qrcodestylestr = null;
		int ptId = 0;
		try{
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			// 获取打印任务最大值
			rs = stmt.executeQuery("select max(pt_id) from printtask;");
			if(rs.next()) ptId = rs.getInt("max(pt_id)") + 1;
			else ptId = 1;
			// 新增打印任务
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			stmt.execute("insert into printtask values("+ptId+",'"+df.format(new java.util.Date())+"',"+userid+",'"+taskname+"','处理中');");
			rs = stmt.executeQuery("select * from printtask where pt_id = "+ptId+" and pt_user_id="+userid+";");
			if(!rs.next()){
				out.print("error");
				return;
			}
			rs = stmt.executeQuery("select qrcode_content from qrcode where qrcode_id ="+qrcodeId +";");
			if(rs.next()){
				qrcodestylestr = rs.getString("qrcode_content");
			}
		}catch(Exception e){
			try{
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}
		QRCodeStyle style = JSON.parseObject(qrcodestylestr,QRCodeStyle.class);
		QRCode qrcode = style.getQRCode();
		ArrayList<String> content = qrcode.getQRCodeContent();
		// 绘图
		for(int i = 0; i < list.size(); i++) {
			HashMap<String,String> productInfo = list.get(i);
			// 二维码内信息
			String infoStr = "";
			for(int j = 0; j < content.size(); j++) {
				// 获取中文
				infoStr = infoStr + map.get(content.get(j)) + ":";
				// 获取值
				infoStr = infoStr + productInfo.get(content.get(j)) + "\n";
			}
			// 绘制二维码
			String path = "C:\\apache-tomcat\\webapps\\ROOT\\ljsys\\pictures\\QRCodes\\product_"+productInfo.get("productId")+".png";
			try{
				QRCodeGenerator.generateQRCodeImage(infoStr,150,150,path);
				// 绘制画布
				BufferedImage bi = null;
				if(flag) bi = new BufferedImage(style.getXsize(),style.getYsize()*2,BufferedImage.TYPE_INT_RGB);
				else bi = new BufferedImage(style.getXsize(),style.getYsize(),BufferedImage.TYPE_INT_RGB);
				Graphics2D g2 = (Graphics2D)bi.getGraphics();
				g2.setColor(Color.WHITE);
				g2.fillRect(0,0,style.getXsize(),style.getYsize());
				File file = new File(path);
				Image src = ImageIO.read(file);
				g2.drawImage(src.getScaledInstance(150,150,Image.SCALE_SMOOTH),qrcode.getXsituation(),qrcode.getYsituation(),null);
				// 写入文本
				g2.setFont(new Font("宋体",Font.BOLD,18));
				g2.setColor(Color.BLACK);
				ArrayList<Item> items = style.getItems();
				for(int j = 0; j < items.size(); j++) {
					String c = items.get(j).getContent();
					String value = productInfo.get(c);
					String title = map.get(c);
					g2.drawString(title+":"+value,items.get(j).getXsituation(),items.get(j).getYsituation()+18);
				}
				// 翻转
				if(flag) {
					for(int k = 0; k < style.getXsize(); k++){
						for(int p = 0; p < style.getYsize(); p++){
							bi.setRGB(k,p+style.getYsize(),bi.getRGB(k,style.getYsize()-1-p));
						}
					}
				}
				String labelpath =  "C:\\apache-tomcat\\webapps\\ROOT\\ljsys\\pictures\\Labels\\label_"+productInfo.get("productId")+".png";
				ImageIO.write(bi,"PNG",new FileOutputStream(labelpath));
			} catch(Exception e3) {
				e3.printStackTrace();
			}
		}
		// 压缩图片
		MyZip pictures = new MyZip();
		try{
			pictures.zip("C:\\apache-tomcat\\webapps\\ROOT\\ljsys\\pictures\\zips\\"+ptId+".zip",new File("C:\\apache-tomcat\\webapps\\ROOT\\ljsys\\pictures\\Labels"));
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			stmt.execute("update printtask set pt_status='已完成' where pt_id="+ptId+";");
		}catch(Exception e4){
			e4.printStackTrace();
		}
		out.print("true");
	}
}
