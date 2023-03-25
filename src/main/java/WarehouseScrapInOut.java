import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.example.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * @description:
 * @author:
 * @createDate: 2022/12/6
 */
public class WarehouseScrapInOut extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String pids = req.getParameter("pids");
        String scrap_user = req.getParameter("scrap_user");
        String scrap_library = req.getParameter("scrap_library");
        String scrap_remark = req.getParameter("scrap_remark");
        String type = req.getParameter("type");
        JSONArray list = JSON.parseArray(pids);
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps1 = null;
        Map<String, Object> map = new HashMap<>();
        StringBuilder sql = new StringBuilder("update preproduct set inspect = 3,stock_status = '1',scrap_library=?,scrap_remark=?,scrap_in_user = ?,scrap_in_time=date_format(now(),'%Y-%m-%d') where materialcode in (");
        StringBuilder sql2 = new StringBuilder("update preproduct set product_delete = '1' where materialcode in (");
        String sql4 = "update plan set tasknum = tasknum - 1 , tasksqure = tasksqure - ? where plannumber = ?";
        String sql5 = "select plannumber,fangliang from preproduct where materialcode = ?";
        try {
            con = DbUtil.getCon();
            if (list.size() == 1) {
                sql.append("?)");
                sql2.append("?)");
            } else {
                for (int j = 0; j < list.size() - 1; j++) {
                    sql.append("? , ");
                }
                sql.append("?)");
                sql2.append("?)");
            }
            List<Map<String, String>> maps = new ArrayList<>();
            if ("1".equals(type)) {
                ps = con.prepareStatement(sql.toString());
                ps.setString(1, scrap_library);
                ps.setString(2, scrap_remark);
                ps.setString(3, scrap_user);
                for (int j = 0; j < list.size(); j++) {
                    ps.setString(j + 4, list.getString(j));
                }
            } else {
                ps = con.prepareStatement(sql2.toString());
                for (int j = 0; j < list.size(); j++) {
                    ps1 = con.prepareStatement(sql5);
                    ps1.setString(1, list.getString(j));
                    ResultSet rs = ps1.executeQuery();
                    while (rs.next()) {
                        Map<String, String> map1 = new HashMap<>();
                        map1.put("plannumber", rs.getString("plannumber"));
                        map1.put("fangliang", rs.getString("fangliang"));
                        maps.add(map1);
                    }
                    ps.setString(j + 1, list.getString(j));
                }
            }
            int i = ps.executeUpdate();
            if ("5".equals(type)) {
                for (Map<String, String> map1 : maps) {
                    ps1 = con.prepareStatement(sql4);
                    ps1.setBigDecimal(1, new BigDecimal(map1.get("fangliang")));
                    ps1.setString(2, map1.get("plannumber"));
                    ps1.executeUpdate();
                }
            }
            String sql3 = "insert into  warehouse_info_log(warehouse_info_id,create_date,user_name,type,in_warehouse_id,out_warehouse_id,materialcode,method) values(?,now(),?,?,?,?,?,?)";
            for (int j = 0; j < list.size(); j++) {
                ps1 = con.prepareStatement(sql3);
                ps1.setString(1, UUID.randomUUID().toString().toLowerCase().replace("-", ""));
                ps1.setString(2, scrap_user);
                ps1.setString(3, type);
                if ("1".equals(type)) {
                    ps1.setString(4, "000000001");
                    ps1.setString(5, null);
                } else {
                    ps1.setString(4, null);
                    ps1.setString(5, "000000001");
                }
                ps1.setString(6, (String) list.get(j));
                if ("1".equals(type)) {
                    ps1.setString(7, "报废入库");
                } else {
                    ps1.setString(7, "报废出库");
                }
                ps1.executeUpdate();
            }
            if (i < 0) {
                map.put("flag", false);
                map.put("message", "操作失败");
            } else {
                map.put("flag", true);
                map.put("message", "操作成功");
            }
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
                out.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
