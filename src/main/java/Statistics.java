import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.example.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Statistics extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String type = req.getParameter("type");    //统计名称
        String planname = req.getParameter("planname");
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            int i = 0;
            con = DbUtil.getCon();
            String pourAll = "select (select sum(fangliang) from preproduct where (pourmade = 1 or pourmade = 2) and isdelete = '0') pour_sum,(select sum(fangliang) from preproduct where (pourmade = 0 or pourmade is null)  and isdelete = '0') no_pour_sum from dual";
            String pourPlanname = "select planname,(select sum(fangliang) from preproduct b where b.planname = a.planname and (b.pourmade = 1 or b.pourmade = 2) and b.isdelete = '0' ) as pour_sum,(select sum(fangliang) from preproduct b where b.planname = a.planname and (pourmade = 0 or pourmade is null) and b.isdelete = '0' ) as no_pour_sum from planname a where isdelete = 0";
            String pourPlannameType = "select a.build_type,(select sum(fangliang) from preproduct b where " +
                    (planname == null ? "" : "planname =? and ") + "  b.build_type = a.build_type  and (pourmade = 1 or pourmade = 2) and isdelete = '0') pour_sum,(select sum(fangliang) from preproduct b where " +
                    (planname == null ? "" : "planname =? and ") + " (pourmade = 0 or pourmade is null) and b.isdelete = '0' and b.build_type = a.build_type ) as no_pour_sum from (select build_type from preproduct " +
                    (planname == null ? "" : "where planname =? ") + "  group by build_type) a";
            String inventoryPlanname = "select planname,(select count(*) from preproduct a inner join warehouse_info b on a.materialcode = b.materialcode where b.is_effective = '1' and c.planname = a.planname  ) num from planname c where isdelete = 0";
            String inventoryType = "select a.build_type,count(*) num from preproduct a inner join warehouse_info b on a.materialcode = b.materialcode where b.is_effective = '1' group by a.build_type";
            String inventoryFactory = "SELECT NAME,(SELECT count(*) FROM warehouse_info WHERE is_effective = '1' and warehouse_id IN " +
                    "( SELECT d.id FROM warehouse b LEFT JOIN warehouse c ON b.id = c.pid LEFT JOIN warehouse d ON c.id = d.pid WHERE b.type = '1'  AND d.type = '3'  AND a.id = b.id  ) ) num " +
                    "FROM warehouse a WHERE type = '1'  AND is_delete = '0'";
            if ("pourAll".equals(type)) {
                ps = con.prepareStatement(pourAll);
                ResultSet rs = ps.executeQuery();
                BigDecimal bigDecimal = new BigDecimal("0");
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", "已浇捣");
                    map.put("value", rs.getBigDecimal("pour_sum"));
                    Map<String, Object> map1 = new HashMap<>();
                    map1.put("name", "未浇捣");
                    map1.put("value", rs.getBigDecimal("no_pour_sum"));
                    bigDecimal = (rs.getBigDecimal("pour_sum") == null ? new BigDecimal("0") : rs.getBigDecimal("pour_sum")).add(rs.getBigDecimal("no_pour_sum") == null ? new BigDecimal("0") : rs.getBigDecimal("no_pour_sum"));
                    list.add(map);
                    list.add(map1);
                }
                result.put("data", list);
                result.put("all", bigDecimal);
            }
            if ("pourPlanname".equals(type)) {
                ps = con.prepareStatement(pourPlanname);
                ResultSet rs = ps.executeQuery();
                List<String> xAxisData = new ArrayList<>();
                List<String> data1 = new ArrayList<>();
                List<String> data2 = new ArrayList<>();
                while (rs.next()) {
                    xAxisData.add(rs.getString("planname"));
                    data1.add(rs.getString("pour_sum"));
                    data2.add(rs.getString("no_pour_sum"));
                }
                result.put("xAxisData", xAxisData);
                result.put("data1", data1);
                result.put("data2", data2);
            }
            if ("pourPlannameType".equals(type)) {
                ps = con.prepareStatement(pourPlannameType);
                ps.setString(1, planname);
                ps.setString(2, planname);
                ps.setString(3, planname);
                ResultSet rs = ps.executeQuery();
                List<String> xAxisData = new ArrayList<>();
                List<String> data1 = new ArrayList<>();
                List<String> data2 = new ArrayList<>();
                while (rs.next()) {
                    xAxisData.add(rs.getString("build_type"));
                    data1.add(rs.getString("pour_sum"));
                    data2.add(rs.getString("no_pour_sum"));
                }
                result.put("xAxisData", xAxisData);
                result.put("data1", data1);
                result.put("data2", data2);
            }
            if ("pourType".equals(type)) {
                ps = con.prepareStatement(pourPlannameType);
                ResultSet rs = ps.executeQuery();
                List<String> xAxisData = new ArrayList<>();
                List<String> data1 = new ArrayList<>();
                List<String> data2 = new ArrayList<>();
                while (rs.next()) {
                    xAxisData.add(rs.getString("build_type"));
                    data1.add(rs.getString("pour_sum"));
                    data2.add(rs.getString("no_pour_sum"));
                }
                result.put("xAxisData", xAxisData);
                result.put("data1", data1);
                result.put("data2", data2);
            }
            if ("inventoryPlanname".equals(type)) {
                ps = con.prepareStatement(inventoryPlanname);
                ResultSet rs = ps.executeQuery();
                List<String> xAxis = new ArrayList<>();
                List<String> data = new ArrayList<>();
                while (rs.next()) {
                    xAxis.add(rs.getString("planname"));
                    data.add(rs.getString("num"));
                }
                result.put("xAxis", xAxis);
                result.put("data", data);
            }
            if ("inventoryType".equals(type)) {
                ps = con.prepareStatement(inventoryType);
                ResultSet rs = ps.executeQuery();
                List<String> xAxis = new ArrayList<>();
                List<String> data = new ArrayList<>();
                while (rs.next()) {
                    xAxis.add(rs.getString("build_type"));
                    data.add(rs.getString("num"));
                }
                result.put("xAxis", xAxis);
                result.put("data", data);
            }
            if ("inventoryFactory".equals(type)) {
                ps = con.prepareStatement(inventoryFactory);
                ResultSet rs = ps.executeQuery();
                List<String> xAxis = new ArrayList<>();
                List<String> data = new ArrayList<>();
                while (rs.next()) {
                    xAxis.add(rs.getString("NAME"));
                    data.add(rs.getString("num"));
                }
                result.put("xAxis", xAxis);
                result.put("data", data);
            }

            if ("inventoryPlannameType".equals(type)) {
                String buildType = "select build_type from preproduct group by build_type";
                ps = con.prepareStatement(buildType);
                ResultSet rs = ps.executeQuery();
                List<String> list1 = new ArrayList<>();
                while (rs.next()) {
                    list1.add(rs.getString("build_type"));
                }
                String inventoryPlannameType = "select planname";
                List<Map<String, Object>> list2 = new ArrayList<>();
                for (int i1 = 0; i1 < list1.size(); i1++) {
                    Map<String, Object> map = new HashMap<>();
                    List<Integer> list3 = new ArrayList<>();
                    map.put("name", list1.get(i));
                    map.put("data", list3);
                    list2.add(map);
                    inventoryPlannameType += ",(select count(*) from warehouse_info a left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.product_delete = '0' and b.planname = c.planname and b.build_type ='" + list1.get(i1) + "' ) type" + i;
                }
                inventoryPlannameType += " from planname c";
                ps = con.prepareStatement(inventoryPlannameType);
                rs = ps.executeQuery();
                List<String> yAxis = new ArrayList<>();
                int j = 0;
                while (rs.next()) {
                    yAxis.add(rs.getString("planname"));
                    List<Integer> list3 = (List<Integer>) list2.get(j).get("data");
                    list3.add(rs.getInt("type" + i));
                }
                result.put("yAxis", yAxis);
                result.put("data", list2);
            }

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
