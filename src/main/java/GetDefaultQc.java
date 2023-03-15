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

public class GetDefaultQc extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        Map<String, Object> result = new HashMap<>();
        String id = req.getParameter("id");
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql1 = "select qc,qc.id from default_qc left join qc on default_qc.qc_id = qc.id where default_qc.id = 1";
            String sql2 = "select qc_id from default_qc where id = ?";
            List<Map<String, String>> list = new ArrayList<>();
            if (id == null) {
                ps = con.prepareStatement(sql1);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("qc", rs.getString("qc"));
                    map.put("id", rs.getString("id"));
                    list.add(map);
                }
            } else {
                ps = con.prepareStatement(sql2);
                ps.setString(1, id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("id", rs.getString("qc_id"));
                    list.add(map);
                }
            }
            result.put("data", list);
            out.write(JSON.toJSONString(result));
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
