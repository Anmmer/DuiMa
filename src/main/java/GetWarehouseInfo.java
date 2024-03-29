import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import com.alibaba.fastjson.JSON;
import com.example.DbUtil;
import com.example.ExcelUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class GetWarehouseInfo extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 传入 warehouse_id

        // 获取、转换参数
        String name = request.getParameter("factoryName");
        String planname = request.getParameter("planname");
        String allData = request.getParameter("allData");
        String floor_no = request.getParameter("floor_no");
        String preproductid = request.getParameter("preproductid");
        String building_no = request.getParameter("building_no");
        String materialcode = request.getParameter("materialcode");
        String materialname = request.getParameter("materialname");
        String build_type = request.getParameter("build_type");
        String isOrder = request.getParameter("isOrder");
        String orderByDrawing_no = request.getParameter("orderByDrawing_no");
        String isExport = request.getParameter("isExport");
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
            int k = 0;
            StringBuilder sql = new StringBuilder("select warehouse_info.materialcode,preproduct.materialname,build_type,planname,floor_no,building_no,drawing_no,path,preproductid,fangliang,(select count(*) from outbound_order_product where outbound_order_product.is_effective = '1' and outbound_order_product.materialcode = warehouse_info.materialcode) isOrder,warehouse_info.create_date,warehouse_info.user_name from warehouse, warehouse_info,preproduct where warehouse_info.warehouse_id = warehouse.id and warehouse_info.materialcode = preproduct.materialcode  and warehouse_info.is_effective = '1' and warehouse.is_delete = '0'  and preproduct.product_delete = '0' and preproduct.isdelete = '0'");
            StringBuilder sql2 = new StringBuilder("select count(*) as num,sum(fangliang) fangliang from warehouse, warehouse_info,preproduct where  warehouse_info.warehouse_id = warehouse.id and warehouse_info.materialcode = preproduct.materialcode  and warehouse_info.is_effective = '1' and warehouse.is_delete = '0'  and preproduct.product_delete = '0' and preproduct.isdelete = '0'");
            StringBuilder sql3 = new StringBuilder("select warehouse_info.materialcode as materialcode from warehouse, warehouse_info,preproduct where warehouse_info.warehouse_id = warehouse.id and warehouse_info.materialcode = preproduct.materialcode  and warehouse_info.is_effective = '1' and warehouse.is_delete = '0'  and preproduct.product_delete = '0' and preproduct.isdelete = '0'");
            if ("true".equals(isOrder)) {
                sql.append(" and preproduct.materialcode in (select materialcode from outbound_order_product where is_effective = '1')");
                sql2.append(" and preproduct.materialcode in (select materialcode from outbound_order_product where is_effective = '1')");
                sql3.append(" and preproduct.materialcode in (select materialcode from outbound_order_product where is_effective = '1')");
            }
            if ("false".equals(isOrder)) {
                sql.append(" and preproduct.materialcode not in (select materialcode from outbound_order_product where is_effective = '1')");
                sql2.append(" and preproduct.materialcode not in (select materialcode from outbound_order_product where is_effective = '1')");
                sql3.append(" and preproduct.materialcode not in (select materialcode from outbound_order_product where is_effective = '1')");
            }

            if (name != null && !"".equals(name)) {
                sql.append(" and warehouse.id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id,t.pid from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )");
                sql2.append(" and warehouse.id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id,t.pid from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )");
                sql3.append(" and warehouse.id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id,t.pid from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )");
                i++;
            }
            if (planname != null && !"".equals(planname)) {
                sql.append(" and planname like ?");
                sql2.append(" and planname like ?");
                sql3.append(" and planname like ?");
                i++;
            }
            if (floor_no != null && !"".equals(floor_no)) {
                sql.append(" and preproduct.floor_no = ?");
                sql2.append(" and preproduct.floor_no = ?");
                sql3.append(" and preproduct.floor_no = ?");
                i++;
            }
            if (building_no != null && !"".equals(building_no)) {
                sql.append(" and preproduct.building_no = ?");
                sql2.append(" and preproduct.building_no = ?");
                sql3.append(" and preproduct.building_no = ?");
                i++;
            }
            if (build_type != null && !"".equals(build_type)) {
                sql.append(" and preproduct.build_type like ?");
                sql2.append(" and preproduct.build_type like ?");
                sql3.append(" and preproduct.build_type like ?");
                i++;
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                sql.append(" and preproduct.drawing_no= ?");
                sql2.append(" and preproduct.drawing_no= ?");
                sql3.append(" and preproduct.drawing_no= ?");
                i++;
            }
            if (materialcode != null && !"".equals(materialcode)) {
                sql.append(" and warehouse_info.materialcode= ?");
                sql2.append(" and warehouse_info.materialcode= ?");
                sql3.append(" and warehouse_info.materialcode= ?");
                i++;
            }
            if (materialname != null && !"".equals(materialname)) {
                sql.append(" and preproduct.materialname like ?");
                sql2.append(" and preproduct.materialname like ?");
                sql3.append(" and preproduct.materialname like ?");
                i++;
            }
            if (id != null && !"".equals(id)) {
                sql.append(" and warehouse.id= ?");
                sql2.append(" and warehouse.id= ?");
                sql3.append(" and warehouse.id= ?");
                i++;
            }
            if (preproductid != null && !"".equals(preproductid)) {
                sql.append(" and preproduct.preproductid like ?");
                sql2.append(" and preproduct.preproductid like ?");
                sql3.append(" and preproduct.preproductid like ?");
                i++;
            }
            j = i;
            k = i;
            if ("true".equals(orderByDrawing_no)) {
                sql.append(" order by drawing_no");
                sql2.append(" order by drawing_no");
                sql3.append(" order by drawing_no");
            }
            sql.append(" limit ?,?");
            i += 2;
            // 获取该仓库具有的products
            ps = conn.prepareStatement(sql.toString());
            ps.setInt(i--, pageMax);
            ps.setInt(i--, (pageCur - 1) * pageMax);
            if (preproductid != null && !"".equals(preproductid)) {
                ps.setString(i--, "%" + preproductid.trim() + "%");
            }
            if (id != null && !"".equals(id)) {
                ps.setString(i--, id);
            }
            if (materialname != null && !"".equals(materialname)) {
                ps.setString(i--, "%" + materialname.trim() + "%");
            }
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(i--, materialcode.trim());
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                ps.setString(i--, drawing_no);
            }
            if (build_type != null && !"".equals(build_type)) {
                ps.setString(i--, "%" + build_type.trim() + "%");
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(i--, building_no.trim());
            }
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(i--, floor_no.trim());
            }
            if (planname != null && !"".equals(planname)) {
                ps.setString(i--, "%" + planname.trim() + "%");
            }
            if (name != null && !"".equals(name)) {
                ps.setString(i, name);
            }
            rs = ps.executeQuery();
            List<List<Object>> list3 = new ArrayList();
            List<Object> list2 = new ArrayList<>();
            if ("true".equals(isExport)) {
                list2.add("物料编码");
                list2.add("物料名称");
                list2.add("构建编号");
                list2.add("构建类型");
                list2.add("所属项目");
                list2.add("楼栋");
                list2.add("楼层");
                list2.add("方量");
                list2.add("图号");
                list2.add("库位");
                list3.add(list2);
            }

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
                insertmap.put("isOrder", rs.getString("isOrder"));
                insertmap.put("preproductid", rs.getString("preproductid"));
                insertmap.put("fangliang", rs.getString("fangliang"));
                insertmap.put("create_date", rs.getString("create_date"));//入库日期
                insertmap.put("user_name", rs.getString("user_name"));//入库人
                if ("true".equals(isExport)) {
                    List<Object> list1 = new ArrayList<>();
                    list1.add(rs.getString("materialcode"));
                    list1.add(rs.getString("materialname"));
                    list1.add(rs.getString("preproductid"));
                    list1.add(rs.getString("build_type"));
                    list1.add(rs.getString("planname"));
                    list1.add(rs.getString("building_no"));
                    list1.add(rs.getString("floor_no"));
                    list1.add(rs.getString("fangliang"));
                    list1.add(rs.getString("drawing_no"));
                    list1.add(rs.getString("path"));
                    list3.add(list1);
                }
                maptmp.add(insertmap);
            }
            data.put("warehouseInfo", maptmp);
            if ("true".equals(isExport)) {
                DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                ExcelUtils.export(response, "仓库信息导出" + sdf.format(new Date()), "仓库信息", list3);
                return;
            }
            if ("true".equals(allData)) {
                ps = conn.prepareStatement(sql3.toString());
                if (preproductid != null && !"".equals(preproductid)) {
                    ps.setString(k--, "%" + preproductid.trim() + "%");
                }
                if (id != null && !"".equals(id)) {
                    ps.setString(k--, id);
                }
                if (materialname != null && !"".equals(materialname)) {
                    ps.setString(k--, "%" + materialname.trim() + "%");
                }
                if (materialcode != null && !"".equals(materialcode)) {
                    ps.setString(k--, materialcode.trim());
                }
                if (drawing_no != null && !"".equals(drawing_no)) {
                    ps.setString(k--, drawing_no);
                }
                if (build_type != null && !"".equals(build_type)) {
                    ps.setString(k--, "%" + build_type.trim() + "%");
                }
                if (building_no != null && !"".equals(building_no)) {
                    ps.setString(k--, building_no.trim());
                }
                if (floor_no != null && !"".equals(floor_no)) {
                    ps.setString(k--, floor_no.trim());
                }
                if (planname != null && !"".equals(planname)) {
                    ps.setString(k--, "%" + planname.trim() + "%");
                }
                if (name != null && !"".equals(name)) {
                    ps.setString(k, name);
                }
                rs = ps.executeQuery();
                List<String> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(rs.getString("materialcode"));
                }
                data.put("allData", list);
            }

            ps = conn.prepareStatement(sql2.toString());
            if (preproductid != null && !"".equals(preproductid)) {
                ps.setString(j--, "%" + preproductid.trim() + "%");
            }
            if (id != null && !"".equals(id)) {
                ps.setString(j--, id);
            }
            if (materialname != null && !"".equals(materialname)) {
                ps.setString(j--, "%" + materialname.trim() + "%");
            }
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(j--, materialcode);
            }
            if (drawing_no != null && !"".equals(drawing_no)) {
                ps.setString(j--, drawing_no);
            }
            if (build_type != null && !"".equals(build_type)) {
                ps.setString(j--, "%" + build_type.trim() + "%");
            }
            if (building_no != null && !"".equals(building_no)) {
                ps.setString(j--, building_no.trim());
            }
            if (floor_no != null && !"".equals(floor_no)) {
                ps.setString(j--, floor_no.trim());
            }
            if (planname != null && !"".equals(planname)) {
                ps.setString(j--, "%" + planname.trim() + "%");
            }
            if (name != null && !"".equals(name)) {
                ps.setString(j, name);
            }
            ResultSet rs2 = ps.executeQuery();
            while (rs2.next()) {
                int num = rs2.getInt("num");
                BigDecimal fangliang = rs2.getBigDecimal("fangliang");
                data.put("cnt", num);
                data.put("fangliang", fangliang);
                data.put("pageAll", Math.ceil((double) num / pageMax));
            }
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
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
