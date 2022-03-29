import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InitPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String user_phone = req.getParameter("user_phone");
        String user_pwd = req.getParameter("user_pwd");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "update user set user_pwd= ? ,user_status = 0 where user_phone=? and isdelete = 1";
            ps = con.prepareStatement(sql);
            ps.setString(1, user_pwd);
            ps.setString(2, user_phone);
            int i = ps.executeUpdate();
            if (i > 0) {
                result.put("flag", true);
                result.put("message", "重置成功");
                out.write(JSON.toJSONString(result));
            } else {
                result.put("flag", false);
                result.put("message", "重置失败");
                out.write(JSON.toJSONString(result));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
            try {
                if (con != null)
                    con.close();
                if (ps != null)
                    ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
