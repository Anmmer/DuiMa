import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.example.DbUtil;
import com.mysql.cj.xdevapi.JsonArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.*;

public class OutboundOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String name = req.getParameter("name");
        String id = req.getParameter("id");
        String materialcodes = req.getParameter("materialcodes");
        String customer_name = req.getParameter("customer_name");
        String contact_name = req.getParameter("contact_name");
        String address = req.getParameter("address");
        String material_receiver = req.getParameter("material_receiver");
        String out_time = req.getParameter("out_time");
        JSONArray jsonArray = JSON.parseArray(materialcodes);
        String type = req.getParameter("type"); // 1:查询，2：新增，3：修改，4：删除，5：计划单关联查询
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        int i = 0;
        int j = 0;
        try {
            con = DbUtil.getCon();
            String sql1 = "select planname,create_time,number,customer_name,contact_name,address,material_receiver,out_time,id,(select count(*) from outbound_order_product b  where a.id = b.outbound_order_id and b.is_effective = '1' ) as num from outbound_order a   where a.is_effective = 1";
            String sql1_page = "select count(*) as num from outbound_order where is_effective = 1";
            String sql2 = "insert into outbound_order(id,planname,number,customer_name,contact_name,address,material_receiver,create_time,is_effective,out_time) values(?,?,?,?,?,?,?,now(),'1',?)";
            String sql3 = "update outbound_order set ";
            String sql4 = "update outbound_order_product set ";
            if ("1".equals(type)) {
                int pageCur = Integer.parseInt(req.getParameter("pageCur"));
                int pageMax = Integer.parseInt(req.getParameter("pageMax"));
                if (name != null && !"".equals(name)) {
                    sql1 += " and planname = ?";
                    sql1_page += " and planname = ?";
                    i++;
                }
                j = i;
                sql1 += " order by planname ,number limit ?,?";
                i += 2;
                ps = con.prepareStatement(sql1);
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);
                if (name != null && !"".equals(name)) {
                    ps.setString(i, name);
                }
                ResultSet rs = ps.executeQuery();
                DecimalFormat g1 = new DecimalFormat("0000");
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                while (rs.next()) {
                    int number = rs.getInt("number");
                    String str = g1.format(Integer.valueOf(number));
                    Map<String, Object> map = new HashMap<>();
                    map.put("planname", rs.getString("planname"));
                    map.put("num", rs.getString("num"));
                    map.put("number", str);
                    map.put("customer_name", rs.getString("customer_name"));
                    map.put("contact_name", rs.getString("contact_name"));
                    map.put("address", rs.getString("address"));
                    map.put("material_receiver", rs.getString("material_receiver"));
                    map.put("id", rs.getString("id"));
                    map.put("create_time", rs.getString("create_time"));
                    if (rs.getDate("out_time") != null) {
                        map.put("out_time", simpleDateFormat.format(rs.getDate("out_time")));
                    } else {
                        map.put("out_time", null);
                    }
                    list.add(map);
                }
                result.put("data", list);
                ps = con.prepareStatement(sql1_page);
                if (name != null && !"".equals(name)) {
                    ps.setString(j, name);
                }
                ResultSet rs2 = ps.executeQuery();
                while (rs2.next()) {
                    int num = rs2.getInt("num");
                    int res_num;
                    if (num % pageMax == 0) {
                        res_num = num / pageMax;
                    } else {
                        res_num = num / pageMax + 1;
                    }
                    result.put("cnt", num);
                    result.put("pageAll", res_num);
                }
            }
            if ("2".equals(type)) {
                String uuid = UUID.randomUUID().toString().toLowerCase().replace("-", "");
                String sql5 = "select max(number) as number from outbound_order where planname = ? and is_effective = '1'";
                String sql6 = "insert into  outbound_order_product(outbound_order_id,materialcode,create_time,is_effective) values(?,?,now(),'1') ";
                ps = con.prepareStatement(sql5);
                ps.setString(1, name);
                ResultSet rs = ps.executeQuery();
                int number = 0;
                if (rs.next()) {
                    number = rs.getInt("number");
                }
//                DecimalFormat g1 = new DecimalFormat("0000");
//                String str = g1.format(number);
                for (Object s : jsonArray) {
                    String materialcode = (String) s;
                    ps = con.prepareStatement(sql6);
                    ps.setString(1, uuid);
                    ps.setString(2, materialcode);
                    ps.executeUpdate();
                }
                ps = con.prepareStatement(sql2);
                ps.setString(1, uuid);
                ps.setString(2, name);
                ps.setInt(3, ++number);
                ps.setString(4, customer_name);
                ps.setString(5, contact_name);
                ps.setString(6, address);
                ps.setString(7, material_receiver);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date date = new Date(System.currentTimeMillis());
                if (out_time == null || "".equals(out_time)) {
                    out_time = simpleDateFormat.format(date);
                }
                ps.setString(8, out_time);

                if (ps.executeUpdate() > 0) {
                    result.put("message", "录入成功");
                    result.put("flag", true);
                } else {
                    result.put("message", "录入失败");
                    result.put("flag", true);
                }
            }
//            if ("3".equals(type)) {
//                sql3 = sql3 + "name = ? where id = ?";
//                ps = con.prepareStatement(sql3);
//                ps.setString(1, name);
//                ps.setString(2, id);
//                if (ps.executeUpdate() > 0) {
//                    result.put("message", "修改成功");
//                    result.put("flag", true);
//                } else {
//                    result.put("message", "修改失败");
//                    result.put("flag", true);
//                }
//            }
            if ("4".equals(type)) {
                sql3 = sql3 + "is_effective = 0 where id = ?";
                sql4 = sql4 + "is_effective = 0 where outbound_order_id = ?";
                String sql5 = "select count(*) from outbound_order_product a left join preproduct b on a.materialcode = b.materialcode where outbound_order_id = ?";

                ps = con.prepareStatement(sql4);
                ps.setString(1, id);
                ps.executeUpdate();
                ps = con.prepareStatement(sql3);
                ps.setString(1, id);
                if (ps.executeUpdate() > 0) {
                    result.put("message", "删除成功");
                    result.put("flag", true);
                } else {
                    result.put("message", "删除失败");
                    result.put("flag", true);
                }
            }
            if ("5".equals(type)) {
                String sql7 = "select materialname,preproductid,standard,fangliang from outbound_order_product a left join preproduct b on a.materialcode = b.materialcode where a.outbound_order_id = ? and a.is_effective = '1' and b.product_delete = '0' and b.isdelete=0";
                ps = con.prepareStatement(sql7);
                ps.setString(1, id);
                ResultSet rs = ps.executeQuery();
                BigDecimal bigDecimal = new BigDecimal("0");
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("materialname", rs.getString("materialname"));
                    map.put("preproductid", rs.getString("preproductid"));
                    map.put("standard", rs.getString("standard"));
                    map.put("fangliang", rs.getBigDecimal("fangliang"));
                    bigDecimal = bigDecimal.add(rs.getBigDecimal("fangliang"));
                    list.add(map);
                }
                result.put("data", list);
                result.put("total", bigDecimal);
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
