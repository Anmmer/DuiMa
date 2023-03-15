import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class GetAuthority extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 传入 UserId
        // 返回JSON
        // 		- 功能权限编号,功能权限名
        // 		- 工序权限编号,工序权限名
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取、转换参数
        String userId = request.getParameter("userId");
        // 需要返回的数据
        String ret = null;
        ArrayList<HashMap<String, String>> functionList = new ArrayList<HashMap<String, String>>();    // 放置功能权限
        ArrayList<HashMap<String, String>> processContentList = new ArrayList<HashMap<String, String>>();    // 放置工序权限
        // 连接数据库查询
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DbUtil.getCon();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("select DISTINCT function_authority.fa_id,function_authority.fa_name,gp.gp_name from function_authority,gp_function_authority,user_gp ,gp where user_gp.gp_id = gp_function_authority.gp_id and gp_function_authority.fa_id = function_authority.fa_id and gp.gp_id = user_gp.gp_id and user_id =" + userId + ";");
            while (rs.next()) {
                String faid = rs.getInt("function_authority.fa_id") + "";
                String faname = rs.getString("function_authority.fa_name");
                String gp_name = rs.getString("gp_name");
                HashMap<String, String> map = new HashMap<String, String>();
                map.put("fa_id", faid);
                map.put("fa_name", faname);
                map.put("gp_name", gp_name);
                functionList.add(map);
            }
            rs = stmt.executeQuery("select DISTINCT process_content.pc_id,process_content.pc_name from process_content,gp_process_content,user_gp where user_gp.gp_id = gp_process_content.gp_id and gp_process_content.pc_id = process_content.pc_id and user_id =" + userId + ";");
            while (rs.next()) {
                String pcid = rs.getInt("process_content.pc_id") + "";
                String pcname = rs.getString("process_content.pc_name");
                HashMap<String, String> map = new HashMap<String, String>();
                map.put("pc_id", pcid);
                map.put("pc_name", pcname);
                processContentList.add(map);
            }
            HashMap<String, String> retJSON = new HashMap<String, String>();
            retJSON.put("function", JSON.toJSONString(functionList));
            retJSON.put("processContent", JSON.toJSONString(processContentList));
            ret = JSON.toJSONString(retJSON);
            out.print(ret);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
