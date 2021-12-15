import java.util.ArrayList;
import java.util.List;
public class QRCode {
	private int Xsituation;
	private int Ysituation;
	private ArrayList<String> QRCodeContent;
	public int getXsituation() {
		return Xsituation;
	}
	public int getYsituation() {
		return Ysituation;
	}
	public ArrayList<String> getQRCodeContent() {
		return QRCodeContent;
	}
	public void setXsituation(int Xsituation) {
		this.Xsituation = Xsituation;
	}
	public void setYsituation(int Ysituation) {
		this.Ysituation = Ysituation;
	}
	public void setQRCodeContent(ArrayList<String> QRCodeContent) {
		this.QRCodeContent = QRCodeContent;
	}
}
