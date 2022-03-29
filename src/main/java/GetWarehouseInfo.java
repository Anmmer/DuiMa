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
        String warehouseId = request.getParameter("warehouseId");
        String product_id = request.getParameter("product_id");
        // 需要返回的数据
        // 连接数据库查询
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Map<String, Object> data = new HashMap<>();
        List<Map> maptmp = new ArrayList<>();
        try {
            conn = DbUtil.getCon();
            stmt = conn.createStatement();
            StringBuilder sql = new StringBuilder("select product_id,warehouse_info.warehouse_id,warehouse.warehouse_name,wi_time,user_name from warehouse, warehouse_info,user,preproduct where warehouse_info.warehouse_id = warehouse.warehouse_id and warehouse_info.user_id = user.user_id and wi_type = 1");
            if (warehouseId != null && !"".equals(warehouseId)) {
                sql.append(" and warehouse_info.warehouse_id=" + warehouseId);
            }
            if (product_id != null && !"".equals(product_id)) {
                sql.append(" and warehouse_info.product_id=" + product_id);
            }
            // 获取该仓库具有的products
            rs = stmt.executeQuery(sql.toString());
            while (rs.next()) {
                String wiTime = rs.getString("wi_time");
                String productId = rs.getString("product_id");
                String warehouse_id = rs.getString("warehouse_id");
                String warehouse_name = rs.getString("warehouse_name");
                String userName = rs.getString("user_name");
                HashMap<String, String> insertmap = new HashMap<String, String>();
                insertmap.put("wiTime", wiTime);
                insertmap.put("productId", productId);
                insertmap.put("warehouse_id", warehouse_id);
                insertmap.put("warehouse_name", warehouse_name);
                insertmap.put("userName", userName);
                maptmp.add(insertmap);
            }
            data.put("data", maptmp);
            out.write(JSON.toJSONString(data));
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
