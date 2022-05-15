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
import java.util.HashMap;
import java.util.Map;

/**
 * @description:
 * @author:
 * @createDate: 2022/5/15
 */
public class ConcealedProcess extends HttpServlet {
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
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbUtil.getCon();
            String sql = "select count(1) num from planname where planname = ? and isdelete = 0";
            String sql2 = "select count(1) num from line where line = ? and isdelete = 0";
            String sql3 = "select count(1) num from plant where plant = ? and isdelete = 0";
            ps = con.prepareStatement(sql);
            ps.setString(1, planname);
            rs = ps.executeQuery();
            while (rs.next()) {
                int i = rs.getInt("num");
                if (i == 0) {
                    result.put("message", "项目名称不存在，请在基础档案添加项目");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            ps = con.prepareStatement(sql2);
            ps.setString(1, line);
            rs = ps.executeQuery();
            while (rs.next()) {
                int i = rs.getInt("num");
                if (i == 0) {
                    result.put("message", "产线不存在，请在基础档案添加产线");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            ps = con.prepareStatement(sql3);
            ps.setString(1, plant);
            rs = ps.executeQuery();
            while (rs.next()) {
                int i = rs.getInt("num");
                if (i == 0) {
                    result.put("message", "工厂不存在，请在基础档案添加工厂");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            result.put("flag", true);
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
