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
import java.util.HashMap;
import java.util.Map;

public class UpdateArchives extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String planname = req.getParameter("planname");
        String line = req.getParameter("line");
        String plant = req.getParameter("plant");
        String qc = req.getParameter("qc");
        String id = req.getParameter("id");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        int i = 0;
        try {
            con = DbUtil.getCon();
            String sql = "update basicarchives set ";
            if (planname != null && !"".equals(planname)) {
                sql += "planname = ?";
                i++;
            }
            if (line != null && !"".equals(line)) {
                sql += "line = ?";
                i++;
            }
            if (plant != null && !"".equals(plant)) {
                sql += "plant = ?";
                i++;
            }
            if (qc != null && !"".equals(qc)) {
                sql += "qc = ?";
                i++;
            }
            sql += " where id = ?";
            i++;
            ps = con.prepareStatement(sql);
            ps.setInt(i--, Integer.parseInt(id));
            if (qc != null && !"".equals(qc)) {
                ps.setString(i--, qc);
            }
            if (plant != null && !"".equals(plant)) {
                ps.setString(i--, plant);
            }
            if (line != null && !"".equals(line)) {
                ps.setString(i--, line);
            }
            if (planname != null && !"".equals(planname)) {
                ps.setString(i, planname);
            }
            int j = ps.executeUpdate();
            if (j == 1) {
                result.put("message", "修改成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "修改失败");
                result.put("flag", false);
                out.write(JSON.toJSONString(result));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }
    }
}
