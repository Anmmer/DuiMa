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
 * @createDate: 2022/3/24
 */
public class GetPreProductWarehouse extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String materialcode = req.getParameter("materialcode");
        String warehouseId = req.getParameter("warehouseId");
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        int i = 0;
        try {
            con = DbUtil.getCon();
            String sql = "select warehouse_id,name, path,materialname,warehouse_info.materialcode,preproductid,pourmade,inspect,covert_test from warehouse,warehouse_info,preproduct where warehouse.id = warehouse_info.warehouse_id and warehouse_info.materialcode = preproduct.materialcode  and  is_effective = 1";
            if (materialcode != null && !"".equals(materialcode)) {
                sql += " and warehouse_info.materialcode = ?";
                i++;
            }
            if (warehouseId != null && !"".equals(warehouseId)) {
                sql += " and warehouse.id = ?";
                i++;
            }
            ps = con.prepareStatement(sql);
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(i--, materialcode);
            }
            if (warehouseId != null && !"".equals(warehouseId)) {
                ps.setString(i, warehouseId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("path", rs.getString("path"));
                map.put("warehouse_id", rs.getString("warehouse_id"));
                map.put("name", rs.getString("name"));
                map.put("materialname", rs.getString("materialname"));
                map.put("preproductid", rs.getString("preproductid"));
                map.put("materialcode", rs.getString("materialcode"));
                map.put("pourmade", rs.getInt("pourmade"));
                map.put("inspect", rs.getInt("inspect"));
                map.put("covert_test", rs.getInt("covert_test"));
                list.add(map);
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
