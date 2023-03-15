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

public class GetPieData extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        Map<String, Object> result = new HashMap<>();
        String planname = req.getParameter("planname");
        String building_no = req.getParameter("building_no");
        String floor_no = req.getParameter("floor_no");
        Connection con = null;
        PreparedStatement ps = null;
        try {
            int i = 1;
            int j = 0;
            con = DbUtil.getCon();
            String sql = "select build_type name,sum(fangliang) value from preproduct a  where a.pourmade = 1 and isdelete = 0 and  a.planname = ?";
            String sql2 = "select build_type name,sum(fangliang) value from preproduct a  where a.inspect = 1 and isdelete = 0 and  a.planname = ?";
            String sql3 = "select build_type name,count(*) value from preproduct a  where   isdelete = 0 and  a.planname = ?";
            String sql4 = "select build_type name,sum(fangliang) value from preproduct a  where  isdelete = 0 and  a.planname = ?";
            if (building_no != null && !"".equals(building_no)) {
                sql += " and building_no = ?";
                sql2 += " and building_no = ?";
                sql3 += " and building_no = ?";
                sql4 += " and building_no = ?";
                i++;
            }

            if (floor_no != null && !"".equals(floor_no)) {
                sql += " and floor_no = ?";
                sql2 += " and floor_no = ?";
                sql3 += " and floor_no = ?";
                sql4 += " and floor_no = ?";
                i++;
            }
            j = i;
            sql += " group by build_type";
            sql2 += " group by build_type";
            sql3 += " group by build_type";
            sql4 += " group by build_type";

            ps = con.prepareStatement(sql);
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(i--, floor_no);
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(i--, building_no);
            }
            ps.setString(i, planname);
            ResultSet rs = ps.executeQuery();
            List<Map<String, String>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("value", rs.getString("value"));
                list.add(map);
            }

            i = j;
            ps = con.prepareStatement(sql2);
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(i--, floor_no);
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(i--, building_no);
            }
            ps.setString(i, planname);
            rs = ps.executeQuery();
            List<Map<String, String>> list2 = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("value", rs.getString("value"));
                list2.add(map);
            }

            i = j;
            ps = con.prepareStatement(sql3);
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(i--, floor_no);
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(i--, building_no);
            }
            ps.setString(i, planname);
            rs = ps.executeQuery();
            List<Map<String, String>> list3 = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("value", rs.getString("value"));
                list3.add(map);
            }

            i = j;
            ps = con.prepareStatement(sql4);
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(i--, floor_no);
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(i--, building_no);
            }
            ps.setString(i, planname);
            rs = ps.executeQuery();
            List<Map<String, String>> list4 = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("value", rs.getString("value"));
                list4.add(map);
            }
            result.put("pie1", list);
            result.put("pie2", list2);
            result.put("pie3", list3);
            result.put("pie4", list4);
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
