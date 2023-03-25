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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GetWarehouseLog extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String type = req.getParameter("type");
        String method = req.getParameter("method");
        String planname = req.getParameter("planname");
        String warehouseId = req.getParameter("warehouseId");
        String materialcode = req.getParameter("materialcode");
        String materialcodes = req.getParameter("materialcodes");
        String floor_no = req.getParameter("floor_no");
        String building_no = req.getParameter("building_no");
        String drawing_no = req.getParameter("drawing_no");
        String startDate = req.getParameter("startDate");
        String endDate = req.getParameter("endDate");
        int pageCur = Integer.parseInt(req.getParameter("pageCur"));
        int pageMax = Integer.parseInt(req.getParameter("pageMax"));
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;

        if (startDate == null || "".equals(startDate) || endDate == null || "".equals(endDate)) {
            result.put("flag", false);
            result.put("msg", "请选择起止日期！");
            out.write(JSON.toJSONString(result));
            return;
        }

        if (type == null || "".equals(type)) {
            result.put("flag", false);
            result.put("msg", "请选择出入库类型！");
            out.write(JSON.toJSONString(result));
            return;
        }

        endDate = endDate+": 23:59:59";

        int i = 0;
        int j = 0;
        try {
            con = DbUtil.getCon();
            String sql = "SELECT\n" +
                    "\ta.materialcode,\n" +
                    "\tbuild_type,\n" +
                    "\tc.standard,\n" +
                    "\tdrawing_no,\n" +
                    "\tweigh,\n" +
                    "\tfangliang,\n" +
                    "\ttype,\n" +
                    "\tcreate_date,\n" +
                    "\tuser_name,\n" +
                    "\ttype,\n" +
                    "\tmethod,(\n" +
                    "\tSELECT path \n" +
                    "\tFROM\n" +
                    "\t\twarehouse b \n" +
                    "\tWHERE\n" +
                    "\t\tb.id = a.in_warehouse_id \n" +
                    "\t\t) AS in_warehouse_path,(\n" +
                    "\tSELECT path \n" +
                    "\tFROM\n" +
                    "\t\twarehouse b \n" +
                    "\tWHERE\n" +
                    "\t\tb.id = a.out_warehouse_id \n" +
                    "\t) AS out_warehouse_path \n" +
                    "FROM\n" +
                    "\twarehouse_info_log a left join preproduct c on a.materialcode = c.materialcode  where 1=1";
            String sql2 = "select count(*) as num from warehouse_info_log a left join preproduct c on a.materialcode = c.materialcode where 1=1";
            if ("1".equals(type) && warehouseId != null && !"".equals(warehouseId)) {
                sql += " and in_warehouse_id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id,t.pid from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )";
                sql2 += " and in_warehouse_id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id,t.pid from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )";
                i++;
            }
            if ("2".equals(type) && warehouseId != null && !"".equals(warehouseId)) {
                sql += " and out_warehouse_id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id,t.pid from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )";
                sql2 += " and in_warehouse_id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id,t.pid from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )";
                i++;
            }
            if (type != null && !"".equals(type)) {
                sql += " and type = ?";
                sql2 += " and type = ?";
                i++;
            }
            if (method != null && !"".equals(method)) {
                sql += " and method = ?";
                sql2 += " and method = ?";
                i++;
            }
            if (startDate != null && !"".equals(startDate) && endDate != null && !"".equals(endDate)) {
                sql += " and create_date < ? and create_date > ?";
                sql2 += " and create_date < ? and create_date > ?";
                i += 2;
            }
            if (planname != null && !"".equals(planname)) {
                sql += " and preproduct.planname like ?";
                sql2 += " and preproduct.planname like ?";
                i++;
            }
            if (floor_no != null && !"".equals(floor_no)) {
                sql += " and preproduct.floor_no like ?";
                sql2 += " and preproduct.floor_no like ?";
                i++;
            }
            if (building_no != null && !"".equals(building_no)) {
                sql += " and preproduct.building_no like ?";
                sql2 += " and preproduct.building_no like ?";
                i++;
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                sql += " and preproduct.drawing_no like ?";
                sql2 += " and preproduct.drawing_no like ?";
                i++;
            }
            if (materialcode != null && !"".equals(materialcode)) {
                sql += " and a.materialcode like ?";
                sql2 += " and a.materialcode like ?";
                i++;
            }
            if (materialcodes != null && !"".equals(materialcodes)) {
                JSONArray jsonArray = JSON.parseArray(materialcodes);
                String o = "(";
                for (int a = 0; a < jsonArray.size() - 1; a++) {
                    o += "?,";
                    i++;
                }
                o += "?)";
                i++;
                sql += " and a.materialcode in " + o;
                sql2 += " and a.materialcode in " + o;

            }
            j = i;
            sql += " order by a.create_date desc limit ?,? ";
            i += 2;
            ps = con.prepareStatement(sql);
            ps.setInt(i--, pageMax);
            ps.setInt(i--, (pageCur - 1) * pageMax);
            if (materialcodes != null && !"".equals(materialcodes)) {
                JSONArray jsonArray = JSON.parseArray(materialcodes);
                for (int a = 0; a < jsonArray.size(); a++) {
                    ps.setString(i--, jsonArray.getString(a).trim());
                }
            }
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(i--, "%" + materialcode.trim() + "%");
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                ps.setString(i--, "%" + drawing_no.trim() + "%");
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(i--, "%" + building_no.trim() + "%");
            }
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(i--, "%" + floor_no.trim() + "%");
            }
            if (planname != null && !"".equals(planname)) {
                ps.setString(i--, "%" + planname.trim() + "%");
            }
            if ((startDate != null && !"".equals(startDate)) && (endDate != null && !"".equals(endDate))) {
                ps.setString(i--, startDate);
                ps.setString(i--, endDate);
            }
            if (method != null && !"".equals(method)) {
                ps.setString(i--, method);
            }
            if (type != null && !"".equals(type)) {
                ps.setString(i--, type);
            }
            if ("2".equals(type) && warehouseId != null && !"".equals(warehouseId)) {
                ps.setString(i--, warehouseId);
            }
            if ("1".equals(type) && warehouseId != null && !"".equals(warehouseId)) {
                ps.setString(i, warehouseId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("materialcode", rs.getString("materialcode"));
                map.put("build_type", rs.getString("build_type"));
                map.put("type", rs.getString("type"));
                map.put("standard", rs.getString("standard"));
                map.put("drawing_no", rs.getString("drawing_no"));
                map.put("weigh", rs.getString("weigh"));
                map.put("fangliang", rs.getString("fangliang"));
                map.put("create_date", rs.getString("create_date"));
                map.put("user_name", rs.getString("user_name"));
                map.put("method", rs.getString("method"));
                map.put("in_warehouse_path", rs.getString("in_warehouse_path"));
                map.put("out_warehouse_path", rs.getString("out_warehouse_path"));
                list.add(map);
            }

            ps2 = con.prepareStatement(sql2);
            if (materialcodes != null && !"".equals(materialcodes)) {
                JSONArray jsonArray = JSON.parseArray(materialcodes);
                for (int a = 0; a < jsonArray.size(); a++) {
                    ps2.setString(j--, jsonArray.getString(a).trim());
                }
            }
            if (materialcode != null && !"".equals(materialcode)) {
                ps2.setString(j--, "%" + materialcode.trim() + "%");
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                ps2.setString(j--, "%" + drawing_no.trim() + "%");
            }
            if (building_no != null && !"".equals(building_no)) {
                ps2.setString(j--, "%" + building_no.trim() + "%");
            }
            if (floor_no != null && !"".equals(floor_no)) {
                ps2.setString(j--, "%" + floor_no.trim() + "%");
            }
            if (planname != null && !"".equals(planname)) {
                ps2.setString(j--, "%" + planname.trim() + "%");
            }
            if ((startDate != null && !"".equals(startDate)) && (endDate != null && !"".equals(endDate))) {
                ps2.setString(j--, startDate);
                ps2.setString(j--, endDate);
            }
            if (method != null && !"".equals(method)) {
                ps2.setString(j--, method);
            }
            if (type != null && !"".equals(type)) {
                ps2.setString(j--, type);
            }
            if ("2".equals(type) && warehouseId != null && !"".equals(warehouseId)) {
                ps2.setString(j--, warehouseId);
            }
            if ("1".equals(type) && warehouseId != null && !"".equals(warehouseId)) {
                ps2.setString(j, warehouseId);
            }
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                int num = rs2.getInt("num");
                result.put("cnt", num);
                result.put("pageAll", Math.ceil((double) num / pageMax));
            }
            result.put("data", list);
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
