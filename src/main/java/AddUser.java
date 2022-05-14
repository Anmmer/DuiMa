import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class AddUser extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 传入 userName
        // 传入 groupIds
        // 需要在写入时SystemLog
        // 返回 true 或者 错误信息 或者 false
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取、转换参数
        String id = request.getParameter("id");
        String user_phone = request.getParameter("user_phone");
        String name = request.getParameter("name");
        String groupIds = request.getParameter("groupIds");
        String userName = request.getParameter("userName");
        String user_pwd = request.getParameter("user_pwd");
        List<Integer> gpidList = JSON.parseArray(groupIds, Integer.class);
        // 需要返回的数据
        HashMap<String, String> ret = new HashMap<String, String>();
        // 连接数据库查询
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DbUtil.getCon();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("select max(user_id) from user;");
            int userId = 0;
            if (rs.next()) {
                userId = rs.getInt("max(user_id)") + 1;
            }
            String sql = "insert into user values(" + userId + ",'" + userName + "','" + user_phone + "',NULL,'"+user_pwd+"',0,NULL,1)";
            stmt.execute(sql);
            rs = stmt.executeQuery("select * from user where user_id=" + userId);
            if (!rs.next()) {
                ret.put("result", "false");
                ret.put("message", "数据库系统错误!");
                out.print(JSON.toJSONString(ret));
                SystemLog.log(name + "(工号为" + id + ")新增名为'" + userName + "'的新用户时失败!原因:数据库系统错误!");
                return;
            }
            SystemLog.log(name + "(工号为" + id + ")新增名为'" + userName + "'的新用户成功!新用户的工号为" + userId);
            // 循环添加ugp_id
            String strtmp = "";
            for (int i = 0; i < gpidList.size(); i++) {
                Integer gpid = gpidList.get(i);
                rs = stmt.executeQuery("select max(ugp_id) from user_gp;");
                int ugpId = 0;
                if (rs.next()) {
                    ugpId = rs.getInt("max(ugp_id)") + 1;
                }
                stmt.execute("insert into user_gp values(" + ugpId + "," + userId + "," + gpid + ");");
                rs = stmt.executeQuery("select * from user_gp where ugp_id=" + ugpId + " and user_id = " + userId + " and gp_id = " + gpid);
                if (!rs.next()) {
                    strtmp += "角色群组" + gpid + "添加失败!\n";
                    SystemLog.log(name + "(工号为" + id + ")授予用户(工号为" + userId + ")群组(群组编号为" + gpid + ")失败!原因是数据库系统错误!");
                } else {
                    SystemLog.log(name + "(工号为" + id + ")授予用户(工号为" + userId + ")群组(群组编号为" + gpid + ")成功!");
                }
            }
            ret.put("result", "true");
            ret.put("message", strtmp);
            out.print(JSON.toJSONString(ret));
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
