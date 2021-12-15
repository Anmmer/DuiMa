import java.io.*;
import java.nio.file.*;
import com.google.zxing.*;
import com.google.zxing.client.j2se.*;
import com.google.zxing.common.*;
import com.google.zxing.qrcode.*;

public class QRCodeGenerator{
	// 生成一个二维码
	public static void generateQRCodeImage(String text, int width, int height, String filePath) throws WriterException,IOException {
		QRCodeWriter qrCodeWriter = new QRCodeWriter();
		BitMatrix bitMatrix = qrCodeWriter.encode(new String(text.getBytes("UTF-8"),"ISO-8859-1"),BarcodeFormat.QR_CODE,width,height);
		Path path = FileSystems.getDefault().getPath(filePath);
		MatrixToImageWriter.writeToPath(bitMatrix,"PNG",path);
	} 
}
