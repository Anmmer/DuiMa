import com.alibaba.fastjson.JSON;
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
import java.text.SimpleDateFormat;
import java.util.*;

public class ReportDataStatistics extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String type = req.getParameter("type");  //统计类型
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            int i = 0;
            con = DbUtil.getCon();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

            // 默认是当前时间
            Calendar calendar = Calendar.getInstance();
            // 先把天之后的时间设置为0
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            calendar.set(Calendar.MILLISECOND, 0);

            // 2023-01-01
            String current = format.format(calendar.getTime());
            calendar.add(Calendar.DAY_OF_MONTH, -1); // 获取前一天日期，跨年跨月也不会出错
            String yesterday = format.format(calendar.getTime());
            int y = calendar.get(Calendar.YEAR);
            int m = calendar.get(Calendar.MONTH) + 1;
            int d = calendar.get(Calendar.DATE);
            String inWarehouse = "select line, sum(fangliang) num from warehouse_info_log a left join preproduct b on a.materialcode = b.materialcode left join plan c on b.plannumber = c.plannumber  where c.isdelete = '0' and a.type = '1' and b.isdelete = '0' ";
            String outWarehouse = "select build_type, sum(fangliang) num from warehouse_info_log a left join preproduct b on a.materialcode = b.materialcode   where  a.type = '1' and b.isdelete = '0' ";
            String warehouse = "select build_type, sum(fangliang) num from warehouse_info a left join preproduct b on a.materialcode = b.materialcode   where  a.is_effective = '1' and b.isdelete = '0' group by build_type";
            BigDecimal bigDecimal = null;
            if ("inWarehouseDay".equals(type)) {
                inWarehouse += " and create_date > '" + yesterday + " 00:00:00'" + " and create_date < '" + yesterday + " 23:59:59'";
                inWarehouse += " group by line";
                ps = con.prepareStatement(inWarehouse);
                rs = ps.executeQuery();

                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("line"));
                    map.put("value", rs.getBigDecimal("num"));
                    bigDecimal = (bigDecimal == null ? new BigDecimal("0") : bigDecimal).add(rs.getBigDecimal("num") == null ? new BigDecimal("0") : rs.getBigDecimal("num"));
                    list.add(map);
                }
                result.put("data", list);
                result.put("sum", bigDecimal);
            }
            if ("inWarehouseMonth".equals(type)) {
                inWarehouse += " and create_date > '" + y + "-" + m + "-01" + " 00:00:00'";
                inWarehouse += " group by line";
                ps = con.prepareStatement(inWarehouse);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("line"));
                    map.put("value", rs.getBigDecimal("num"));
                    bigDecimal = (bigDecimal == null ? new BigDecimal("0") : bigDecimal).add(rs.getBigDecimal("num") == null ? new BigDecimal("0") : rs.getBigDecimal("num"));
                    list.add(map);
                }
                result.put("data", list);
                result.put("sum", bigDecimal);
            }
            if ("inWarehouseYear".equals(type)) {
                inWarehouse += " and create_date > '" + y + "-" + "01" + "-01" + " 00:00:00'";
                inWarehouse += " group by line";
                ps = con.prepareStatement(inWarehouse);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("line"));
                    map.put("value", rs.getBigDecimal("num"));
                    bigDecimal = (bigDecimal == null ? new BigDecimal("0") : bigDecimal).add(rs.getBigDecimal("num") == null ? new BigDecimal("0") : rs.getBigDecimal("num"));
                    list.add(map);
                }
                result.put("data", list);
                result.put("sum", bigDecimal);
            }


            if ("outWarehouseDay".equals(type)) {
                outWarehouse += " and create_date > '" + yesterday + " 00:00:00'" + " and create_date < '" + yesterday + " 23:59:59'";
                outWarehouse += " group by build_type";
                ps = con.prepareStatement(outWarehouse);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("build_type"));
                    map.put("value", rs.getBigDecimal("num"));
                    bigDecimal = (bigDecimal == null ? new BigDecimal("0") : bigDecimal).add(rs.getBigDecimal("num") == null ? new BigDecimal("0") : rs.getBigDecimal("num"));
                    list.add(map);
                }
                result.put("data", list);
                result.put("sum", bigDecimal);
            }
            if ("outWarehouseMonth".equals(type)) {
                outWarehouse += " and create_date > '" + y + "-" + m + "-01" + " 00:00:00'";
                outWarehouse += " group by build_type";
                ps = con.prepareStatement(outWarehouse);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("build_type"));
                    map.put("value", rs.getBigDecimal("num"));
                    bigDecimal = (bigDecimal == null ? new BigDecimal("0") : bigDecimal).add(rs.getBigDecimal("num") == null ? new BigDecimal("0") : rs.getBigDecimal("num"));
                    list.add(map);
                }
                result.put("data", list);
                result.put("sum", bigDecimal);
            }
            if ("outWarehouseYear".equals(type)) {
                outWarehouse += " and create_date > '" + y + "-" + "01" + "-01" + " 00:00:00'";
                outWarehouse += " group by build_type";
                ps = con.prepareStatement(outWarehouse);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("build_type"));
                    map.put("value", rs.getBigDecimal("num"));
                    bigDecimal = (bigDecimal == null ? new BigDecimal("0") : bigDecimal).add(rs.getBigDecimal("num") == null ? new BigDecimal("0") : rs.getBigDecimal("num"));
                    list.add(map);
                }
                result.put("data", list);
                result.put("sum", bigDecimal);
            }
            if ("warehouse".equals(type)) {
                ps = con.prepareStatement(warehouse);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("build_type"));
                    map.put("value", rs.getBigDecimal("num"));
                    bigDecimal = (bigDecimal == null ? new BigDecimal("0") : bigDecimal).add(rs.getBigDecimal("num") == null ? new BigDecimal("0") : rs.getBigDecimal("num"));
                    list.add(map);
                }
                result.put("data", list);
                result.put("sum", bigDecimal);
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
