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

public class GetArchives extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String planname = req.getParameter("planname");
        String plant = req.getParameter("plant");
        String qc = req.getParameter("qc");
        String id = req.getParameter("id");
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int i = 0;
        try {
            con = DbUtil.getCon();
            String sql = "select planname,line,plant,qc,id from basicarchives where isdelete = 0";
            if (id != null && !"".equals(id)) {
                sql += " and id = ?";
                i++;
            }
            if (planname != null && !"".equals(planname)) {
                sql += " and planname = ?";
                i++;
            }
            if (qc != null && !"".equals(qc)) {
                sql += " and qc = ?";
                i++;
            }
            if (plant != null && !"".equals(plant)) {
                sql += " and plant = ?";
                i++;
            }
            ps = con.prepareStatement(sql);
            if (plant != null && !"".equals(plant)) {
                ps.setString(i--, plant);
            }
            if (qc != null && !"".equals(qc)) {
                ps.setString(i--, qc);
            }
            if (planname != null && !"".equals(planname)) {
                ps.setString(i--,planname);
            }
            if (id != null && !"".equals(id)) {
                ps.setInt(i, Integer.parseInt(id));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("planname", rs.getString("planname"));
                map.put("line", rs.getString("line"));
                map.put("plant", rs.getString("plant"));
                map.put("qc", rs.getString("qc"));
                map.put("id", rs.getString("id"));
                list.add(map);
            }
            result.put("data", list);
            out.write(JSON.toJSONString(result));
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
