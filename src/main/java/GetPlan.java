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

public class GetPlan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        resp.setContentType("text/html;charset=UTF-8");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        PrintWriter out = null;
        try {
            out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select planid,planname,company,plant from plan";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            Map<String, Object> data = new HashMap<>();
            List<Map<String, Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("planid", rs.getInt("planid"));
                map.put("planname", rs.getString("planname"));
                map.put("company", rs.getString("company"));
                map.put("plant", rs.getString("plant"));
                list.add(map);
            }
            data.put("data", list);
            out.write(JSON.toJSONString(data));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null)
                    con.close();
                if (rs != null)
                    rs.close();
                if (ps != null)
                    ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            if (out != null) {
                out.close();
            }
        }
    }
}
