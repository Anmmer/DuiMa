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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author:
 * @createDate: 2022/3/22
 */
public class AutoLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String openid = req.getParameter("openid");
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        int i = 0;
        try {
            con = DbUtil.getCon();
            String sql = "select user.user_id,user_name, gp_name from user ,user_gp ,gp where user.user_id = user_gp.user_id and user_gp.gp_id = gp.gp_id and user.isdelete = '1' and user_wxid = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, openid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("user_id", rs.getString("user_id"));
                map.put("user_name", rs.getString("user_name"));
                map.put("gp_name", rs.getString("gp_name"));
                list.add(map);
            }
            result.put("flag", true);
            result.put("data", list);
            out.write(JSON.toJSONString(result));
        } catch (Exception e) {
            result.put("flag", false);
            result.put("message", "查询失败");
            out.write(JSON.toJSONString(result));
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
