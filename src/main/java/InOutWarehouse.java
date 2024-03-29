import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取、转换参数
        String pids = request.getParameter("ids");            // 需要入库、出库的构件号集合
        List<String> products = JSON.parseArray(pids, String.class);
        String out_warehouse_id = request.getParameter("out_warehouse_id");            // 出库货位编号
        String in_warehouse_id = request.getParameter("in_warehouse_id");            // 入库货位编号
        String type = request.getParameter("type");                    // 出库，入库类型	1为入库，2为出库  ,3为移库，4为盘库
        String id = request.getParameter("userId");                    // 操作人工号
        String name = request.getParameter("userName");                // 操作人名
        String method = request.getParameter("method");                // 入库方式
        String initInWarehouse = request.getParameter("isInitInWarehouse");  //是否期初导入
        Boolean isInitInWarehouse = false;
        // 需要返回的数据
        HashMap<String, Object> ret = new HashMap<>();
        if (initInWarehouse != null) {
            isInitInWarehouse = Boolean.valueOf(initInWarehouse);
        }
        // 连接数据库查询
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DbUtil.getCon();
            String msg = "";                    // 返回的信息
            List<Map<String, String>> list = new ArrayList<>();
            String batch_id = UUID.randomUUID().toString().toUpperCase().replace("-", "");
            String initSql = "update preproduct set stock_status = '1' , inspect = '1',pourmade = '1',pourmade = '1',product_delete = '0' where materialcode = ?";
            for (int i = 0; i < products.size(); i++) {
                String productId = products.get(i);
                String sql = "select warehouse_id,outbound_order_id from warehouse_info a left join outbound_order_product b on a.materialcode = b.materialcode where a.materialcode = ? and a.is_effective = '1'";
                ps = conn.prepareStatement(sql);
                ps.setString(1, productId);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("warehouse_id", rs.getString("warehouse_id"));
                    map.put("outbound_order_id", rs.getString("outbound_order_id"));
                    list.add(map);
                }
                if ("1".equals(type) && list.size() != 0) {
                    msg = "物料编码为：" + productId + " 的构建已入库，请勿重复入库";
                    ret.put("msg", msg);
                    ret.put("flag", false);
                    out.print(JSON.toJSONString(ret));
                    return;
                }
                if (!"1".equals(type) && list.size() == 0) {
                    msg = "物料编码为：" + productId + " 的构建未入库，请先入库";
                    ret.put("msg", msg);
                    ret.put("flag", false);
                    out.print(JSON.toJSONString(ret));
                    return;
                }
                if ("2".equals(type) && list.get(i).get("outbound_order_id") == null) {
                    msg = "物料编码为：" + productId + " 的构建请先生成出库单再出库";
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
                String uuid = UUID.randomUUID().toString().toLowerCase().replace("-", "");
                if ("2".equals(type) || "3".equals(type)) {
                    // 出库操作
                    String sql2 = "update warehouse_info set is_effective = '0' where materialcode = ?";
                    String sql4 = "update preproduct set stock_status = '2' where materialcode = ?";
                    ps = conn.prepareStatement(sql2);
                    ps.setString(1, productId);
                    ps.executeUpdate();
                    ps = conn.prepareStatement(sql4);
                    ps.setString(1, productId);
                    ps.executeUpdate();
                }
                if ("1".equals(type) || "3".equals(type)) {
                    if (isInitInWarehouse) {
                        ps = conn.prepareStatement(initSql);
                        ps.setString(1, productId);
                        ps.executeUpdate();
                    }
                    // 入库操作
                    String sql2 = "insert into  warehouse_info(create_date,materialcode,user_name,id,warehouse_id,is_effective) values(now(),?,?,?,?,'1')";
                    String sql3 = "update preproduct set stock_status = '1' where materialcode = ?";
                    ps = conn.prepareStatement(sql2);
                    ps.setString(1, productId);
                    ps.setString(2, name);
                    ps.setString(3, uuid);
                    ps.setString(4, in_warehouse_id);
                    ps.executeUpdate();
                    ps = conn.prepareStatement(sql3);
                    ps.setString(1, productId);
                    ps.executeUpdate();
                }
                String sql3 = "insert into  warehouse_info_log(warehouse_info_id,create_date,user_name,type,in_warehouse_id,out_warehouse_id,materialcode,method,batch_id) values(?,now(),?,?,?,?,?,?,?)";
                ps = conn.prepareStatement(sql3);
                ps.setString(1, UUID.randomUUID().toString().toLowerCase().replace("-", ""));
                ps.setString(2, name);
                ps.setString(3, type);
                ps.setString(4, in_warehouse_id);
                if (!"1".equals(type) && out_warehouse_id == null) {
                    out_warehouse_id = list.get(i).get("warehouse_id");
                }
                ps.setString(5, out_warehouse_id);
                ps.setString(6, productId);
                ps.setString(7, method);
                if ("4".equals(type)) {
                    ps.setString(8, batch_id);
                } else {
                    ps.setString(8, null);
                }
                ps.executeUpdate();
            }
            ret.put("msg", "操作成功！");
            ret.put("flag", true);
            out.print(JSON.toJSONString(ret));
        } catch (Exception e) {
            e.printStackTrace();
            ret.put("msg", "操作成功！");
            ret.put("flag", true);
            out.print(JSON.toJSONString(ret));
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
