import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
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
        String startDate = req.getParameter("startDate");
        String endDate = req.getParameter("endDate");
        String planname = req.getParameter("planname");
        String materialcode = req.getParameter("materialcode");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        PrintWriter out = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int i = 0;
        try {
            out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select plannumber,printstate,plant,plantime,line,planname,build,tasksqure,tasknum,updatedate from plan where isdelete = 0 ";
            if (!"".equals(startDate) && startDate != null) {
                sql += " and plantime >= ?";
                i++;
            }
            if (!"".equals(endDate) && endDate != null) {
                sql += " and plantime <= ?";
                i++;
            }
            if (!"".equals(planname) && planname != null) {
                sql += " and planname = ?";
                i++;
            }
            if (!"".equals(materialcode) && materialcode != null) {
                sql += " and plannumber in (select plannumber from preproduct where materialcode = ?)";
                i++;
            }
            ps = con.prepareStatement(sql);
            if (!"".equals(materialcode) && materialcode != null) {
                ps.setString(i--, materialcode);
            }
            if (!"".equals(planname) && planname != null) {
                ps.setString(i--, planname);
            }
            if (!"".equals(endDate) && endDate != null) {
                ps.setDate(i--, new Date(sdf.parse(endDate).getTime()));
            }
            if (!"".equals(startDate) && startDate != null) {
                ps.setDate(i, new Date(sdf.parse(startDate).getTime()));
            }
            rs = ps.executeQuery();
            Map<String, Object> data = new HashMap<>();
            List<Map<String, Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("plannumber", rs.getString("plannumber"));
                map.put("printstate", rs.getInt("printstate"));
                map.put("plant", rs.getString("plant"));
                map.put("plantime", rs.getDate("plantime"));
                map.put("line", rs.getString("line"));
                map.put("planname", rs.getString("planname"));
                map.put("build", rs.getString("build"));
                map.put("tasksqure", rs.getString("tasksqure"));
                map.put("tasknum", rs.getString("tasknum"));
                map.put("updatedate", rs.getDate("updatedate"));
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
