import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
public class SystemLog{
	public static void log(String info){
		try {
			SimpleDateFormat filenameSdf = new SimpleDateFormat();
			filenameSdf.applyPattern("yyyy-MM-dd");
			SimpleDateFormat infoSdf = new SimpleDateFormat();
			infoSdf.applyPattern("HH:mm:ss");
			Date date = new Date();
//			File file = new File("/root/tomcat/apache-tomcat-9.0.50/webapps/ROOT/ljsys/logs/"+filenameSdf.format(date)+".txt");
			File file = new File(System.getProperty("user.dir")+"\\src\\main\\webapp\\ljsys\\logs\\"+filenameSdf.format(date)+".txt");
			if(!file.exists()) file.createNewFile();
//			FileWriter fw = new FileWriter("/root/tomcat/apache-tomcat-9.0.50/webapps/ROOT/ljsys/logs/"+file.getName(),true);
			FileWriter fw = new FileWriter(System.getProperty("user.dir")+"\\src\\main\\webapp\\ljsys\\logs\\"+file.getName(),true);
			System.out.println(file.getName());
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(infoSdf.format(date)+":"+info+"\n");
			bw.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		System.out.println(System.getProperty("user.dir"));
	}
}
