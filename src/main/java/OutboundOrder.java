import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.example.DbUtil;
import com.example.ExcelUtils;
import com.mysql.cj.xdevapi.JsonArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.text.DateFormat;
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
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = null;
        String name = req.getParameter("name");
        String id = req.getParameter("id");
        String materialcodes = req.getParameter("materialcodes");
        String customer_name = req.getParameter("customer_name");
        String contact_name = req.getParameter("contact_name");
        String startDate = req.getParameter("startDate");
        String endDate = req.getParameter("endDate");
        String address = req.getParameter("address");
        String building_no = req.getParameter("building_no");
        String floor_no = req.getParameter("floor_no");
        String build_type = req.getParameter("build_type");
        String material_receiver = req.getParameter("material_receiver");
        String out_time = req.getParameter("out_time");
        String isExport = req.getParameter("isExport");
        String orderByNumber = req.getParameter("orderByNumber");
        String orderByTime = req.getParameter("orderByTime");
        JSONArray jsonArray = JSON.parseArray(materialcodes);
        String type = req.getParameter("type"); // 1:查询，2：新增，3：修改，4：删除，5：计划单关联查询 6:查看详情
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        int i = 0;
        int j = 0;
        try {
            con = DbUtil.getCon();
            String sql1 = "select planname,create_time,number,customer_name,contact_name,address,material_receiver,out_time,id,(select count(*) from outbound_order_product b  where a.id = b.outbound_order_id and b.is_effective = '1' ) as num,(select count(*) from outbound_order_product b left join preproduct c on b.materialcode = c.materialcode  where a.id = b.outbound_order_id and c.isdelete = '0' and c.stock_status = '2' and b.is_effective = '1' ) as out_num,(select sum(fangliang) from outbound_order_product b left join preproduct c on b.materialcode = c.materialcode  where a.id = b.outbound_order_id and c.isdelete = '0' and b.is_effective = '1' ) as fangliang,building_no,floor_no,build_type from outbound_order a   where a.is_effective = 1";
            String sql1_page = "select count(*) as num from outbound_order where is_effective = 1";
            String sql2 = "insert into outbound_order(id,planname,number,customer_name,contact_name,address,material_receiver,create_time,is_effective,out_time,building_no,floor_no,build_type) values(?,?,?,?,?,?,?,now(),'1',?,?,?,?)";
            String sql3 = "update outbound_order set ";
            String sql4 = "update outbound_order_product set ";
            if ("1".equals(type)) {
                int pageCur = Integer.parseInt(req.getParameter("pageCur"));
                int pageMax = Integer.parseInt(req.getParameter("pageMax"));
                if (name != null && !"".equals(name)) {
                    sql1 += " and planname like ?";
                    sql1_page += " and planname like ?";
                    i++;
                }
                if (startDate != null && !"".equals(startDate) && endDate != null && !"".equals(endDate)) {
                    sql1 += " and out_time < ? and out_time > ?";
                    sql1_page += " and out_time < ? and out_time > ?";
                    i += 2;
                }
                j = i;
                sql1 += " order by planname  ";
                sql1_page += " order by planname  ";
                if ("number_desc".equals(orderByNumber)) {
                    sql1 += ",number desc ";
                    sql1_page += ",number desc ";
                } else {
                    sql1 += ",number asc ";
                    sql1_page += ",number asc ";
                }
                if ("out_time_desc".equals(orderByTime)) {
                    sql1 += ",out_time desc";
                    sql1_page += ",out_time desc";
                } else {
                    sql1 += ",out_time asc";
                    sql1_page += ",out_time asc";
                }
                sql1 += " limit ?,?";
                i += 2;
                ps = con.prepareStatement(sql1);
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);
                if ((startDate != null && !"".equals(startDate)) && (endDate != null && !"".equals(endDate))) {
                    ps.setString(i--, startDate);
                    ps.setString(i--, endDate);
                }
                if (name != null && !"".equals(name)) {
                    ps.setString(i, '%' + name.trim() + '%');
                }
                ResultSet rs = ps.executeQuery();
                DecimalFormat g1 = new DecimalFormat("0000");
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                List<List<Object>> list3 = new ArrayList();
                List<Object> list2 = new ArrayList<>();
                if ("true".equals(isExport)) {
                    list2.add("出库单号");
                    list2.add("出库时间");
                    list2.add("客户名称");
                    list2.add("楼栋");
                    list2.add("楼层");
                    list2.add("构件类型");
                    list2.add("现场联系人");
                    list2.add("收料员");
                    list2.add("项目名称");
                    list2.add("构建数量");
                    list2.add("收货地址");
                    list3.add(list2);
                }
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
                    map.put("building_no", rs.getString("building_no"));
                    map.put("floor_no", rs.getString("floor_no"));
                    map.put("fangliang", rs.getString("fangliang"));
                    map.put("build_type", rs.getString("build_type"));
                    map.put("out_num", rs.getString("out_num"));
                    map.put("create_time", rs.getString("create_time"));
                    if (rs.getDate("out_time") != null) {
                        map.put("out_time", simpleDateFormat.format(rs.getDate("out_time")));
                    } else {
                        map.put("out_time", null);
                    }
                    if ("true".equals(isExport)) {
                        List<Object> list1 = new ArrayList<>();
                        list1.add("JSLJ-" + rs.getInt("number"));
                        if (rs.getDate("out_time") != null) {
                            list1.add(simpleDateFormat.format(rs.getDate("out_time")));
                        } else {
                            list1.add(null);
                        }
                        list1.add(rs.getString("customer_name"));
                        list1.add(rs.getString("building_no"));
                        list1.add(rs.getString("floor_no"));
                        list1.add(rs.getString("build_type"));
                        list1.add(rs.getString("contact_name"));
                        list1.add(rs.getString("material_receiver"));
                        list1.add(rs.getString("planname"));
                        list1.add(rs.getString("num"));
                        list1.add(rs.getString("address"));
                        list3.add(list1);
                    }
                    list.add(map);
                }
                if ("true".equals(isExport)) {
                    DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    ExcelUtils.export(resp, "出库单信息" + sdf.format(new Date()), "出库单信息", list3);
                    return;
                }
                result.put("data", list);
                ps = con.prepareStatement(sql1_page);
                if ((startDate != null && !"".equals(startDate)) && (endDate != null && !"".equals(endDate))) {
                    ps.setString(j--, startDate);
                    ps.setString(j--, endDate);
                }
                if (name != null && !"".equals(name)) {
                    ps.setString(j, "%" + name + "%");
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
                ps.setString(9, building_no);
                ps.setString(10, floor_no);
                ps.setString(11, build_type);

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
            if ("6".equals(type)) {
                if (id == null && "".equals(id)) {
                    result.put("message", "参数不全");
                    result.put("flag", true);
                    return;
                }
                int pageCur = Integer.parseInt(req.getParameter("pageCur"));
                int pageMax = Integer.parseInt(req.getParameter("pageMax"));
                String sql8 = "select materialname,preproductid,standard,fangliang,stock_status from outbound_order_product a left join preproduct b on a.materialcode = b.materialcode where a.outbound_order_id = ? and a.is_effective = '1' and b.product_delete = '0' and b.isdelete=0";
                String sql8_page = "select count(*) num from outbound_order_product a left join preproduct b on a.materialcode = b.materialcode where a.outbound_order_id = ? and a.is_effective = '1' and b.product_delete = '0' and b.isdelete=0";
                i++;
                j = i;
                sql8 += " limit ?,?";
                i += 2;
                ps = con.prepareStatement(sql8);
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);
                if ((id != null && !"".equals(id))) {
                    ps.setString(i, id);
                }
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("materialname", rs.getString("materialname"));
                    map.put("preproductid", rs.getString("preproductid"));
                    map.put("standard", rs.getString("standard"));
                    map.put("fangliang", rs.getBigDecimal("fangliang"));
                    map.put("stock_status", rs.getBigDecimal("stock_status"));
                    list.add(map);
                }
                result.put("data", list);
                ps = con.prepareStatement(sql8_page);
                if ((id != null && !"".equals(id))) {
                    ps.setString(j, id);
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
            out = resp.getWriter();
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
