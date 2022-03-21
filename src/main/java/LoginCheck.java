import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;

public class LoginCheck extends HttpServlet {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123456";

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // doPost
        // 返回JSON文件 例:{ret:True, userName:"xxx"}
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String user_phone = new String(request.getParameter("user_phone"));
        String userPwd = new String(request.getParameter("userPwd"));
        // 连接数据库查询
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String userName = null;
        Map<String, Object> result = new HashMap();
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
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
                if ("0".equals(user_status)) {
                    result.put("message", "请修改密码");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                    return;
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
