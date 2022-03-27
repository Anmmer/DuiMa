import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class LoginCheck extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // doPost
        // 返回JSON文件 例:{ret:True, userName:"xxx"}
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String user_phone = request.getParameter("user_phone");
        String userPwd = request.getParameter("userPwd");
        String openid = request.getParameter("openid");
        // 连接数据库查询
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String userName = null;
        Map<String, Object> result = new HashMap();
        try {
            conn = DbUtil.getCon();
            stmt = conn.createStatement();
            String sql = "select * from user where user_phone = ? and user_pwd = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user_phone);
            ps.setString(2, userPwd);
            rs = ps.executeQuery();
            if (rs.next()) {
                userName = rs.getString("user_name");
                Integer userId = rs.getInt("user_id");
                String user_status = rs.getString("user_status");
                String user_wxid = rs.getString("user_wxid");
                if ("0".equals(user_status)) {
                    result.put("message", "请在网页端修改密码");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                    return;
                }
                if (openid != null && user_wxid == null) {
                    String sql2 = "update user set user_wxid = ? where user_phone = ?";
                    ps = conn.prepareStatement(sql2);
                    ps.setString(1, openid);
                    ps.setString(2, user_phone);
                    ps.executeUpdate();
                }
                result.put("message", "登录成功");
                result.put("userId", userId);
                result.put("userName", userName);
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "账号或密码错误");
                result.put("flag", false);
                out.write(JSON.toJSONString(result));
            }
        } catch (Exception e) {
            result.put("message", "账号或密码错误");
            result.put("flag", false);
            out.write(JSON.toJSONString(result));
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
