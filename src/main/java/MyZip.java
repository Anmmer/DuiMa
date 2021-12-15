import java.io.*;
import java.util.zip.*;
 
public class MyZip { // 创建类
	public void zip(String zipFileName, File inputFile) throws Exception {
		ZipOutputStream out = new ZipOutputStream(new FileOutputStream(
				zipFileName)); // 创建ZipOutputStream类对象
		zip2(out, inputFile, ""); // 调用方法
		System.out.println("压缩中…"); // 输出信息
		out.close(); // 将流关闭
	}
	
	public void zip2(ZipOutputStream out, File f, String base)
			throws Exception { // 方法重载
		if (f.isDirectory()) { // 测试此抽象路径名表示的文件是否是一个目录
			out.putNextEntry(new ZipEntry(base+"/"));
			File[] fl = f.listFiles(); // 获取路径数组
			for (int i = 0; i < fl.length; i++) { // 循环遍历数组中文件
				zip2(out, fl[i], base + fl[i]);
			}
		} else {
			// 创建FileInputStream对象
			out.putNextEntry(new ZipEntry(base));
			FileInputStream in = new FileInputStream(f);
			int b; // 定义int型变量
			System.out.println(base);
			while ((b = in.read()) != -1) { // 如果没有到达流的尾部
				out.write(b); // 将字节写入当前ZIP条目
			}
			in.close(); // 关闭流
		}
	}
}
