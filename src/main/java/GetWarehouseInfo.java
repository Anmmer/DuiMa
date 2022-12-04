import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class GetWarehouseInfo extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 传入 warehouse_id
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取、转换参数
        String name = request.getParameter("name");
        String planname = request.getParameter("planname");
        String floor_no = request.getParameter("floor_no");
        String building_no = request.getParameter("building_no");
        String materialcode = request.getParameter("materialcode");
        String build_type = request.getParameter("build_type");
        String id = request.getParameter("id");
        String drawing_no = request.getParameter("drawing_no");
        int pageCur = Integer.parseInt(request.getParameter("pageCur"));
        int pageMax = Integer.parseInt(request.getParameter("pageMax"));
        // 需要返回的数据
        // 连接数据库查询
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Map<String, Object> data = new HashMap<>();
        List<Map> maptmp = new ArrayList<>();
        try {
            conn = DbUtil.getCon();
            int i = 0;
            int j = 0;
            StringBuilder sql = new StringBuilder("select warehouse_info.materialcode,build_table.materialname,build_type,planname,floor_no,building_no,drawing_no,path from warehouse, warehouse_info,build_table where warehouse_info.warehouse_id = warehouse.id and warehouse_info.materialcode = build_table.materialcode and build_table.is_delete=0 and warehouse_info.is_effective = '1'");
            StringBuilder sql2 = new StringBuilder("select count(*) as num from warehouse, warehouse_info,build_table,preproduct where warehouse_info.warehouse_id = warehouse.id and warehouse_info.materialcode = preproduct.materialcode and preproduct.materialcode=build_table.materialcode and build_table.is_delete = 0 and warehouse_info.is_effective = '1'");
            if (name != null && !"".equals(name)) {
                sql.append(" and warehouse.id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )");
                sql2.append(" and warehouse.id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  name= ?\n" +
                        "union \n" +
                        " select t.id from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )");
                i++;
            }
            if (planname != null && !"".equals(planname)) {
                sql.append(" and build_table.planname= ?");
                sql2.append(" and build_table.planname= ?");
                i++;
            }
            if (floor_no != null && !"".equals(floor_no)) {
                sql.append(" and build_table.floor_no= ?");
                sql2.append(" and build_table.floor_no= ?");
                i++;
            }
            if (building_no != null && !"".equals(building_no)) {
                sql.append(" and build_table.building_no= ?");
                sql2.append(" and build_table.building_no= ?");
                i++;
            }
            if (build_type != null && !"".equals(build_type)) {
                sql.append(" and build_table.build_type= ?");
                sql2.append(" and build_table.build_type= ?");
                i++;
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                sql.append(" and build_table.drawing_no= ?");
                sql2.append(" and build_table.drawing_no= ?");
                i++;
            }
            if (materialcode != null && !"".equals(materialcode)) {
                sql.append(" and warehouse_info.materialcode= ?");
                sql2.append(" and warehouse_info.materialcode= ?");
                i++;
            }
            if (id != null && !"".equals(id)) {
                sql.append(" and warehouse.id= ?");
                sql2.append(" and warehouse.id= ?");
                i++;
            }
            j = i;
            sql.append(" limit ?,?");
            i += 2;
            // 获取该仓库具有的products
            ps = conn.prepareStatement(sql.toString());
            ps.setInt(i--, pageMax);
            ps.setInt(i--, (pageCur - 1) * pageMax);
            if (id != null && !"".equals(id)) {
                ps.setString(i--, id);
            }
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(i--, materialcode);
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                ps.setString(i--, drawing_no);
            }
            if (build_type != null && !"".equals(build_type)) {
                ps.setString(i--, build_type);
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(i--, building_no);
            }
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(i--, floor_no);
            }
            if (planname != null && !"".equals(planname)) {
                ps.setString(i--, planname);
            }
            if (name != null && !"".equals(name)) {
                ps.setString(i, name);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                HashMap<String, String> insertmap = new HashMap<>();
                insertmap.put("materialcode", rs.getString("materialcode"));
                insertmap.put("materialname", rs.getString("materialname"));
                insertmap.put("planname", rs.getString("planname"));
                insertmap.put("floor_no", rs.getString("floor_no"));
                insertmap.put("building_no", rs.getString("building_no"));
                insertmap.put("build_type", rs.getString("build_type"));
                insertmap.put("drawing_no", rs.getString("drawing_no"));
                insertmap.put("path", rs.getString("path"));
                maptmp.add(insertmap);
            }
            data.put("warehouseInfo", maptmp);
            ps = conn.prepareStatement(sql2.toString());
            if (id != null && !"".equals(id)) {
                ps.setString(j--, id);
            }
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(j--, materialcode);
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                ps.setString(j--, drawing_no);
            }
            if (build_type != null && !"".equals(build_type)) {
                ps.setString(j--, build_type);
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(j--, building_no);
            }
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(j--, floor_no);
            }
            if (planname != null && !"".equals(planname)) {
                ps.setString(j--, planname);
            }
            if (name != null && !"".equals(name)) {
                ps.setString(j, name);
            }
            ResultSet rs2 = ps.executeQuery();
            while (rs2.next()) {
                int num = rs2.getInt("num");
                data.put("cnt", num);
                data.put("pageAll", Math.ceil((double) num / pageMax));
            }
            out.write(JSON.toJSONString(data));
        } catch (Exception e) {
            e.printStackTrace();
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
