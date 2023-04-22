import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
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
import java.util.*;

public class InventoryCheck extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        doGet(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String materialcodes = request.getParameter("materialcodes");
        String type = request.getParameter("type");//0：盘库单查询 1：盘库单新增 2：盘库单修改 3：盘库单删除
        String batch_id = request.getParameter("batch_id");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String user_name = request.getParameter("user_name");
        String warehouse_id = request.getParameter("warehouse_id");
        String planname_id = request.getParameter("planname_id");
        String build_type = request.getParameter("build_type");
        String check_id = request.getParameter("check_id");
        endDate = endDate + ": 23:59:59";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        HashMap<String, Object> result = new HashMap<>();
        List<Map> maptmp = new ArrayList<>();
        try {
            conn = DbUtil.getCon();
            int i = 0;
            int j = 0;
            if ("0".equals(type)) {
                int pageCur = Integer.parseInt(request.getParameter("pageCur"));
                int pageMax = Integer.parseInt(request.getParameter("pageMax"));
                String sql = "select check_id,user_name,status,a.create_time,batch_id,b.path,c.planname,build_type,(select count(*) from should_check d where a.check_id = d.check_id and d.is_effective = '1' ) should_check_num,(select count(*) from real_check e where a.check_id = e.check_id and e.is_effective = '1' ) real_check_num from inventory_check a left join warehouse b on a.warehouse_id = b.id left join planname c on a.planname_id = c.id where a.is_effective = '1' and b.is_delete = '0' and c.isdelete = 0 ";
                String sql2 = "select count(*) as num from inventory_check a left join warehouse b on a.warehouse_id = b.id left join planname c on a.planname_id = c.id where a.is_effective = '1' and b.is_delete = '0' and c.isdelete = 0 ";
                if (batch_id != null && !"".equals(batch_id)) {
                    sql += " and batch_id = ?";
                    sql2 += " and batch_id = ?";
                    i++;
                }
                if (user_name != null && !"".equals(user_name)) {
                    sql += " and user_name = ?";
                    sql2 += " and user_name = ?";
                    i++;
                }
                if (startDate != null && !"".equals(startDate) && endDate != null && !"".equals(endDate)) {
                    sql += " and create_time < ? and create_time > ?";
                    sql2 += " and create_time < ? and create_time > ?";
                    i += 2;
                }
                j = i;
                sql += " order by a.create_time desc limit ?,? ";
                i += 2;
                ps = conn.prepareStatement(sql);
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);
                if ((startDate != null && !"".equals(startDate)) && (endDate != null && !"".equals(endDate))) {
                    ps.setString(i--, startDate);
                    ps.setString(i--, endDate);
                }
                if (user_name != null && !"".equals(user_name)) {
                    ps.setString(i--, user_name);
                }
                if (batch_id != null && !"".equals(batch_id)) {
                    ps.setString(i, batch_id);
                }
                rs = ps.executeQuery();
                while (rs.next()) {
                    HashMap<String, String> insertmap = new HashMap<>();
                    insertmap.put("check_id", rs.getString("check_id"));
                    insertmap.put("user_name", rs.getString("user_name"));
                    insertmap.put("status", rs.getString("status"));
                    insertmap.put("create_time", rs.getString("create_time"));
                    insertmap.put("batch_id", rs.getString("batch_id"));
                    insertmap.put("path", rs.getString("path"));
                    insertmap.put("planname", rs.getString("planname"));
                    insertmap.put("should_check_num", rs.getString("should_check_num"));
                    insertmap.put("real_check_num", rs.getString("real_check_num"));
                    insertmap.put("build_type", rs.getString("build_type"));
                    maptmp.add(insertmap);
                }
                result.put("data", maptmp);
                ps = conn.prepareStatement(sql2);
                if ((startDate != null && !"".equals(startDate)) && (endDate != null && !"".equals(endDate))) {
                    ps.setString(j--, startDate);
                    ps.setString(j--, endDate);
                }
                if (user_name != null && !"".equals(user_name)) {
                    ps.setString(j--, user_name);
                }
                if (batch_id != null && !"".equals(batch_id)) {
                    ps.setString(j, batch_id);
                }
                rs = ps.executeQuery();
                while (rs.next()) {
                    int num = rs.getInt("num");
                    result.put("cnt", num);
                    result.put("pageAll", Math.ceil((double) num / pageMax));
                }
                out.write(JSON.toJSONString(result));
                return;
            }
            if ("1".equals(type)) {
                String sql = "insert into inventory_check values(?,?,?,?,now(),?,?,?,?)";
                String sql2 = "select max(batch_id) batch_id from inventory_check where is_effective = '1'";
                String sql3 = "insert into should_check values(?,?,now(),'1',?)";
                String uuid = UUID.randomUUID().toString().toLowerCase().replace("-", "");
                JSONArray jsonArray = JSON.parseArray(materialcodes);
                ps = conn.prepareStatement(sql2);
                rs = ps.executeQuery();
                int id = 0;
                while (rs.next()) {
                    id = rs.getInt("batch_id");
                }
                id++;
                ps = conn.prepareStatement(sql);
                ps.setString(1, uuid);
                ps.setString(2, user_name);
                ps.setString(3, "1");
                ps.setString(4, "1");
                ps.setInt(5, id);
                ps.setString(6, warehouse_id);
                ps.setString(7, planname_id);
                ps.setString(8, build_type);
                ps.executeUpdate();
                ps = conn.prepareStatement(sql3);
                for (Object o : jsonArray) {
                    String materialcode = (String) o;
                    ps.setString(1, UUID.randomUUID().toString().toLowerCase().replace("-", ""));
                    ps.setString(2, uuid);
                    ps.setString(3, materialcode);
                    ps.addBatch();
                }
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("msg", "操作失败！");
            result.put("flag", false);
            out.print(JSON.toJSONString(result));
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
