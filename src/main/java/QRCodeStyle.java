import java.util.ArrayList;
import java.util.List;
public class QRCodeStyle {
	private int Xsize;
	private int Ysize;
	private QRCode qrcode;
	private ArrayList<Item> items;
	public int getXsize() {
		return Xsize;
	}
	public int getYsize() {
		return Ysize;
	}
	public QRCode getQRCode() {
		return qrcode;
	}
	public ArrayList<Item> getItems() {
		return items;
	}
	public void setXsize(int Xsize) {
		this.Xsize = Xsize;
	}
	public void setYsize(int Ysize) {
		this.Ysize = Ysize;
	}
	public void setQRCode(QRCode qrcode) {
		this.qrcode = qrcode;
	}
	public void setItems(ArrayList<Item> items) {
		this.items = items;
	}
}
