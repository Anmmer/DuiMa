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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String materialcodes = request.getParameter("materialcodes");
        String type = request.getParameter("type");//0：盘库单查询 1：盘库单新增 2：盘库单修改 3：盘库单删除 4：查看详情 5：实盘删除 6：写备注 7：结束
        String check_type = request.getParameter("check_type");
        String batch_id = request.getParameter("batch_id");
        String real_id = request.getParameter("id");
        String status = request.getParameter("status");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String user_name = request.getParameter("user_name");
        String remark = request.getParameter("remark");
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
                String sql = "select check_id,user_name,status,a.create_time,batch_id,(select b.path from warehouse b where a.warehouse_id = b.id and  b.is_delete = '0') path,(select c.planname from planname c where a.planname_id = c.id and c.isdelete = 0) planname ,build_type,(select count(*) from should_check d where a.check_id = d.check_id and d.is_effective = '1' ) should_check_num,(select count(*) from real_check e where a.check_id = e.check_id and e.is_effective = '1' ) real_check_num from inventory_check a where a.is_effective = '1'  ";
                String sql2 = "select count(*) as num from inventory_check  a where a.is_effective = '1'  ";
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
                if (status != null && !"".equals(status)) {
                    sql += " and status = ?";
                    sql2 += " and status = ?";
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
                if (status != null && !"".equals(status)) {
                    ps.setString(i--, status);
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
                if (status != null && !"".equals(status)) {
                    ps.setString(j--, status);
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
                String sql3 = "insert into should_check(id,check_id,create_time,is_effective,materialcode) values(?,?,now(),'1',?)";
                String uuid = UUID.randomUUID().toString().toLowerCase().replace("-", "");
                JSONArray jsonArray = JSON.parseArray(materialcodes);
                if (jsonArray.size() == 0) {
                    result.put("msg", "查询数据不能为空！");
                    result.put("flag", false);
                    out.print(JSON.toJSONString(result));
                    return;
                }
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
                ps.setInt(7, "".equals(planname_id) ? 0 : Integer.parseInt(planname_id));
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
                int[] rs2 = ps.executeBatch();
                if (rs2.length < 1) {
                    result.put("flag", false);
                    result.put("msg", "录入失败");
                    out.write(JSON.toJSONString(result));
                    return;
                } else {
                    result.put("msg", "录入成功");
                    result.put("flag", true);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            if ("3".equals(type)) {
                if (check_id == null) {
                    result.put("flag", false);
                    result.put("msg", "参数不全");
                    out.write(JSON.toJSONString(result));
                    return;
                }
                String sql = "update inventory_check set is_effective = '0' where check_id =?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, check_id);
                int a = ps.executeUpdate();
                if (a > 0) {
                    result.put("msg", "删除成功");
                    result.put("flag", true);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            if ("4".equals(type)) {
                int pageCur = Integer.parseInt(request.getParameter("pageCur"));
                int pageMax = Integer.parseInt(request.getParameter("pageMax"));
                if (check_id == null) {
                    result.put("flag", false);
                    result.put("msg", "参数不全");
                    out.write(JSON.toJSONString(result));
                    return;
                }
                String sql = "select check_id,user_name,status,a.create_time,batch_id,(select b.path from warehouse b where a.warehouse_id = b.id and  b.is_delete = '0') path,(select c.planname from planname c where a.planname_id = c.id and c.isdelete = 0) planname ,build_type,(select count(*) from should_check d where a.check_id = d.check_id and d.is_effective = '1' ) should_check_num,(select count(*) from real_check e where a.check_id = e.check_id and e.is_effective = '1' ) real_check_num from inventory_check a where a.is_effective = '1' and check_id =?  ";
                ps = conn.prepareStatement(sql);
                ps.setString(1, check_id);
                rs = ps.executeQuery();
                while (rs.next()) {
                    result.put("user_name", rs.getString("user_name"));
                    result.put("create_time", rs.getString("create_time"));
                    result.put("batch_id", rs.getString("batch_id"));
                    result.put("path", rs.getString("path"));
                    result.put("status", rs.getString("status"));
                    result.put("planname", rs.getString("planname"));
                    result.put("should_check_num", rs.getString("should_check_num"));
                    result.put("real_check_num", rs.getString("real_check_num"));
                }
                String sql2 = "select a.materialcode,materialname,drawing_no,planname,build_type,building_no,floor_no,(select path from warehouse_info c left join warehouse d on d.id = c.warehouse_id where c.materialcode = a.materialcode  ) path from should_check a left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.isdelete = '0' and a.check_id = ? limit ?,? ";
                String sql2_page = "select count(*) num from should_check a left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.isdelete = '0' and a.check_id = ? ";
                String sql3 = "select a.id, a.materialcode,a.create_user,materialname,drawing_no,planname,build_type,building_no,floor_no,(select path from warehouse_info c left join warehouse d on d.id = c.warehouse_id where c.materialcode = a.materialcode  ) path from real_check a left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.isdelete = '0' and a.check_id = ? limit ?,? ";
                String sql3_page = "select count(*) num from real_check a left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.isdelete = '0' and a.check_id = ? ";
                String sql4 = "select a.id, a.materialcode,a.remark,materialname,drawing_no,planname,build_type,building_no,floor_no,(select path from warehouse_info c left join warehouse d on d.id = c.warehouse_id where c.materialcode = a.materialcode  ) path from should_check a left join real_check e on a.materialcode = e.materialcode left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.isdelete = '0' and a.check_id = ? and e.materialcode is null limit ?,? ";
                String sql4_page = "select count(*) num from should_check a left join real_check e on a.materialcode = e.materialcode left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.isdelete = '0' and a.check_id = ? and e.materialcode is null ";
                String sql5 = "select a.id, a.materialcode,a.remark,materialname,drawing_no,planname,build_type,building_no,floor_no,(select path from warehouse_info c left join warehouse d on d.id = c.warehouse_id where c.materialcode = a.materialcode  ) path from real_check a left join should_check e on a.materialcode = e.materialcode left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.isdelete = '0' and a.check_id = ? and e.materialcode is null limit ?,? ";
                String sql5_page = "select count(*) num from real_check a left join should_check e on a.materialcode = e.materialcode left join preproduct b on a.materialcode = b.materialcode where a.is_effective = '1' and b.isdelete = '0' and a.check_id = ? and e.materialcode is null ";
                if ("should_check".equals(check_type)) {
                    ps = conn.prepareStatement(sql2);
                    ps.setString(1, check_id);
                    ps.setInt(3, pageMax);
                    ps.setInt(2, (pageCur - 1) * pageMax);
                    rs = ps.executeQuery();
                    List<Map<String, String>> shouldList = new ArrayList<>();
                    while (rs.next()) {
                        Map<String, String> map = new HashMap<>();
                        map.put("materialcode", rs.getString("materialcode"));
                        map.put("materialname", rs.getString("materialname"));
                        map.put("drawing_no", rs.getString("drawing_no"));
                        map.put("planname", rs.getString("planname"));
                        map.put("build_type", rs.getString("build_type"));
                        map.put("path", rs.getString("path"));
                        map.put("building_no", rs.getString("building_no"));
                        map.put("floor_no", rs.getString("floor_no"));
                        shouldList.add(map);
                    }
                    result.put("data", shouldList);
                    ps = conn.prepareStatement(sql2_page);
                    ps.setString(1, check_id);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        int num = rs.getInt("num");
                        result.put("cnt", num);
                        result.put("pageAll", Math.ceil((double) num / pageMax));
                    }
                }
                if ("real_check".equals(check_type)) {
                    ps = conn.prepareStatement(sql3);
                    ps.setString(1, check_id);
                    ps.setInt(3, pageMax);
                    ps.setInt(2, (pageCur - 1) * pageMax);
                    rs = ps.executeQuery();
                    List<Map<String, String>> shouldList = new ArrayList<>();
                    while (rs.next()) {
                        Map<String, String> map = new HashMap<>();
                        map.put("id", rs.getString("id"));
                        map.put("materialcode", rs.getString("materialcode"));
                        map.put("materialname", rs.getString("materialname"));
                        map.put("drawing_no", rs.getString("drawing_no"));
                        map.put("planname", rs.getString("planname"));
                        map.put("build_type", rs.getString("build_type"));
                        map.put("path", rs.getString("path"));
                        map.put("building_no", rs.getString("building_no"));
                        map.put("floor_no", rs.getString("floor_no"));
                        shouldList.add(map);
                    }
                    result.put("data", shouldList);
                    ps = conn.prepareStatement(sql3_page);
                    ps.setString(1, check_id);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        int num = rs.getInt("num");
                        result.put("cnt", num);
                        result.put("pageAll", Math.ceil((double) num / pageMax));
                    }
                }
                if ("leak_check".equals(check_type)) {
                    ps = conn.prepareStatement(sql4);
                    ps.setString(1, check_id);
                    ps.setInt(3, pageMax);
                    ps.setInt(2, (pageCur - 1) * pageMax);
                    rs = ps.executeQuery();
                    List<Map<String, String>> shouldList = new ArrayList<>();
                    while (rs.next()) {
                        Map<String, String> map = new HashMap<>();
                        map.put("materialcode", rs.getString("materialcode"));
                        map.put("id", rs.getString("id"));
                        map.put("materialname", rs.getString("materialname"));
                        map.put("drawing_no", rs.getString("drawing_no"));
                        map.put("planname", rs.getString("planname"));
                        map.put("build_type", rs.getString("build_type"));
                        map.put("building_no", rs.getString("building_no"));
                        map.put("floor_no", rs.getString("floor_no"));
                        map.put("path", rs.getString("path"));
                        map.put("remark", rs.getString("remark"));
                        shouldList.add(map);
                    }
                    result.put("data", shouldList);
                    ps = conn.prepareStatement(sql4_page);
                    ps.setString(1, check_id);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        int num = rs.getInt("num");
                        result.put("cnt", num);
                        result.put("pageAll", Math.ceil((double) num / pageMax));
                    }
                }
                if ("full_check".equals(check_type)) {
                    ps = conn.prepareStatement(sql5);
                    ps.setString(1, check_id);
                    ps.setInt(3, pageMax);
                    ps.setInt(2, (pageCur - 1) * pageMax);
                    rs = ps.executeQuery();
                    List<Map<String, String>> shouldList = new ArrayList<>();
                    while (rs.next()) {
                        Map<String, String> map = new HashMap<>();
                        map.put("id", rs.getString("id"));
                        map.put("materialcode", rs.getString("materialcode"));
                        map.put("materialname", rs.getString("materialname"));
                        map.put("drawing_no", rs.getString("drawing_no"));
                        map.put("planname", rs.getString("planname"));
                        map.put("build_type", rs.getString("build_type"));
                        map.put("building_no", rs.getString("building_no"));
                        map.put("floor_no", rs.getString("floor_no"));
                        map.put("path", rs.getString("path"));
                        map.put("remark", rs.getString("remark"));
                        shouldList.add(map);
                    }
                    result.put("data", shouldList);
                    ps = conn.prepareStatement(sql5_page);
                    ps.setString(1, check_id);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        int num = rs.getInt("num");
                        result.put("cnt", num);
                        result.put("pageAll", Math.ceil((double) num / pageMax));
                    }
                }

                out.write(JSON.toJSONString(result));
            }
            if ("5".equals(type)) {
                if (real_id == null) {
                    result.put("flag", false);
                    result.put("msg", "参数不全");
                    out.write(JSON.toJSONString(result));
                    return;
                }
                String sql = "update real_check set is_effective = '0' where id =?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, real_id);
                int a = ps.executeUpdate();
                if (a > 0) {
                    result.put("msg", "删除成功");
                    result.put("flag", true);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            if ("6".equals(type)) {
                if ("leak_check".equals(check_type)) {
                    if (real_id == null) {
                        result.put("flag", false);
                        result.put("msg", "参数不全");
                        out.write(JSON.toJSONString(result));
                        return;
                    }
                    String sql = "update should_check set remark = ? where id =?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, remark);
                    ps.setString(2, real_id);
                    int a = ps.executeUpdate();
                    if (a > 0) {
                        result.put("msg", "操作成功");
                        result.put("flag", true);
                        out.write(JSON.toJSONString(result));
                        return;
                    }
                }
                if ("full_check".equals(check_type)) {
                    if (real_id == null) {
                        result.put("flag", false);
                        result.put("msg", "参数不全");
                        out.write(JSON.toJSONString(result));
                        return;
                    }
                    String sql = "update real_check set remark = ? where id =?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, remark);
                    ps.setString(2, real_id);
                    int a = ps.executeUpdate();
                    if (a > 0) {
                        result.put("msg", "操作成功");
                        result.put("flag", true);
                        out.write(JSON.toJSONString(result));
                        return;
                    }
                }

            }
            if ("7".equals(type)) {
                if (check_id == null) {
                    result.put("flag", false);
                    result.put("msg", "参数不全");
                    out.write(JSON.toJSONString(result));
                    return;
                }
                String sql = "update inventory_check set status = '2' where check_id =?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, check_id);
                int a = ps.executeUpdate();
                if (a > 0) {
                    result.put("msg", "操作成功");
                    result.put("flag", true);
                    out.write(JSON.toJSONString(result));
                    return;
                }
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
