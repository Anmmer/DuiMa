import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;

import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

// 出库、入库
public class InOutWarehouse extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 传入equipmentName
        // 返回 true 或者 错误信息 或者 false
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取、转换参数
        String pids = request.getParameter("productIds");            // 需要入库、出库的构件号集合
        List<String> products = JSON.parseArray(pids, String.class);
        String warehouseId = request.getParameter("warehouseId");            // 货位编号
        String moveWarehouseId = request.getParameter("moveWarehouseId");            // 货位编号
        String type = request.getParameter("type");                    // 出库，入库类型	1为入库，0为出库
        String id = request.getParameter("userId");                    // 操作人工号
        String name = request.getParameter("userName");                // 操作人名
        // 需要返回的数据
        HashMap<String, Object> ret = new HashMap<>();
        // 连接数据库查询
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DbUtil.getCon();
            String msg = "";                    // 返回的信息
            for (int i = 0; i < products.size(); i++) {
                String productId = products.get(i);
                String sql = "select count(*) as num form warehouse_info where materialcode = ? and is_effective = '1'";
                ps = conn.prepareStatement(sql);
                ps.setString(1, productId);
                rs = ps.executeQuery();
                int num = 0;
                while (rs.next()) {
                    num = rs.getInt("num");
                }
                if ("1".equals(type) && num != 0) {
                    msg = "物料编码为：" + productId + " 的构建已入库，请勿重复入库";
                    ret.put("msg", msg);
                    ret.put("flag", false);
                    out.print(JSON.toJSONString(ret));
                    return;
                }
                if (!"1".equals(type) && num == 0) {
                    msg = "物料编码为：" + productId + " 的构建未入库，请先入库";
                    ret.put("msg", msg);
                    ret.put("flag", false);
                    out.print(JSON.toJSONString(ret));
                    return;
                }

            }
            for (int i = 0; i < products.size(); i++) {
                String productId = products.get(i);
                // 检查是否在库存内  ->  信息写入warehouse_info  ->  信息写入product
                //					 |
                //					 ->  出错写入msg
                String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
                if ("1".equals(type)) {
                    // 入库操作
                    String sql2 = "insert into  warehouse_info(create_date,materialcode,user_name,id,warehouse_id,is_effective) values(now(),?,?,?,?,'1')";
                    ps = conn.prepareStatement(sql2);
                    ps.setString(1, productId);
                    ps.setString(2, name);
                    ps.setString(3, uuid);
                    ps.setString(4, warehouseId);
                    ps.executeUpdate();
                }
                if ("2".equals(type) || "3".equals(type)) {
                    // 出库操作
                    String sql2 = "update warehouse_info set is_effective = '0' where materialcode = ?";
                    ps = conn.prepareStatement(sql2);
                    ps.setString(1, productId);
                    ps.executeUpdate();
                }
                String sql3 = "insert into  warehouse_info_log(warehouse_info_id,create_date,user_name,type,warehouse_id) values(?,now(),?,?,?)";
                ps = conn.prepareStatement(sql3);
                ps.setString(1, uuid);
                ps.setString(2, name);
                ps.setString(3, type);
                if ("3".equals(type)) {
                    ps.setString(4, moveWarehouseId);
                } else {
                    ps.setString(4, null);
                }
                ps.executeUpdate();
            }
            ret.put("msg", "操作成功！");
            ret.put("flag", true);
            out.print(JSON.toJSONString(ret));
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
