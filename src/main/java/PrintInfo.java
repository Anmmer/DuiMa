import java.util.*;

public class PrintInfo {
	public ArrayList<HashMap<String,String>> list;
	public int qrcodeId;
	public HashMap<String,String> mymap;
	public int turnover;
	public int userid;
	public String taskname;
	public void setList(ArrayList<HashMap<String,String>> list) {
		this.list = list;
	}
	public void setQrcodeId(int qrcodeId) {
		this.qrcodeId = qrcodeId;
	}
	public void setMymap(HashMap<String,String> map) {
		this.mymap = map;
	}
	public void setTurnover(int turnover){
		this.turnover = turnover;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public void setTaskname(String taskname){
		this.taskname = taskname;
	}
	public ArrayList<HashMap<String,String>> getList(){
		return this.list;
	}
	public int getQrcodeId(){
		return this.qrcodeId;
	}
	public HashMap<String,String> getMymap(){
		return this.mymap;
	}
	public int getTurnover(){
		return this.turnover;
	}
	public int getUserid(){
		return this.userid;
	}
	public String getTaskname(){
		return this.taskname;
	}
}
