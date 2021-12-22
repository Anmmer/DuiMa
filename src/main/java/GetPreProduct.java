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
 * @createDate: 2021/12/20
 */
public class GetPreProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String planid = req.getParameter("planid");
        String preproductid = req.getParameter("preproductid");
        String build = req.getParameter("build");
        String print = req.getParameter("print");
        Connection con = null;
        int i = 0;
        try {
            PrintWriter out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select pid, projectname,materialcode,preproductid,size,volume,weigh,qc,build,time,print,planid from preproduct where 1=1";
            if (planid != null && !"".equals(planid)) {
                sql += " and planid = ?";
                i++;
            }
            if (preproductid != null && !"".equals(preproductid)) {
                sql += " and preproductid = ?";
                i++;
            }
            if (build != null && !"".equals(build)) {
                sql += " and build = ?";
                i++;
            }
            if (print != null && !"".equals(print)) {
                sql += " and print = ?";
                i++;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            if (print != null && !"".equals(print)) {
                ps.setInt(i--, Integer.parseInt(print));
            }
            if (build != null && !"".equals(build)) {
                ps.setString(i--, build);
            }
            if (preproductid != null && !"".equals(preproductid)) {
                ps.setString(i--, preproductid);
            }
            if (planid != null && !"".equals(planid)) {
                ps.setInt(i, Integer.parseInt(planid));
            }
            ResultSet rs = ps.executeQuery();
            Map<String, List<Map<String, Object>>> data = new HashMap<>();
            List<Map<String, Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("pid", rs.getInt("pid"));
                map.put("projectname", rs.getString("projectname"));
                map.put("materialcode", rs.getString("materialcode"));
                map.put("preproductid", rs.getString("preproductid"));
                map.put("size", rs.getString("size"));
                map.put("volume", rs.getDouble("volume"));
                map.put("weigh", rs.getDouble("weigh"));
                map.put("qc", rs.getString("qc"));
                map.put("build", rs.getString("build"));
                map.put("time", rs.getDate("time"));
                map.put("print", rs.getInt("print"));
                map.put("planid", rs.getInt("planid"));
                list.add(map);
            }
            data.put("data", list);
            out.write(JSON.toJSONString(data));
            ps.close();
            rs.close();
            out.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
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
