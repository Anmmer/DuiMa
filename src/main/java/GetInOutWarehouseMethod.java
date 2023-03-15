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

public class GetInOutWarehouseMethod extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String name = req.getParameter("name");
        String type = req.getParameter("type");
        String cur = req.getParameter("pageCur");
        String max = req.getParameter("pageMax");
        int pageCur = 0;
        int pageMax = 0;
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int i = 0;
        int j = 0;
        try {
            con = DbUtil.getCon();
            String sql = "select id,name,create_date,type,is_effective from in_out_warehouse_method where is_effective = '1'";
            String sql2 = "select count(*) as num from in_out_warehouse_method where is_effective = '1'";
            if (name != null && !"".equals(name)) {
                sql += " and name = ?";
                sql2 += " and name = ?";
                i++;
            }
            if (type != null && !"".equals(type)) {
                sql += " and type = ?";
                sql2 += " and type = ?";
                i++;
            }
            j = i;
            if (cur != null && max != null) {
                pageCur = Integer.parseInt(cur);
                pageMax = Integer.parseInt(max);
                sql += " limit ?,?";
                i += 2;
            }
            ps = con.prepareStatement(sql);
            if (cur != null && max != null) {
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);
            }
            if (type != null && !"".equals(type)) {
                ps.setString(i--, type);
            }
            if (name != null && !"".equals(name)) {
                ps.setString(i, name);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getString("id"));
                map.put("name", rs.getString("name"));
                map.put("create_date", rs.getString("create_date"));
                map.put("type", rs.getString("type"));
                map.put("is_effective", rs.getString("is_effective"));
                list.add(map);
            }
            if (cur != null && max != null) {
                ps = con.prepareStatement(sql2);
                if (type != null && !"".equals(type)) {
                    ps.setString(j--, type);
                }
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
            result.put("data", list);
            out.write(JSON.toJSONString(result));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null)
                    con.close();
                if (rs != null)
                    rs.close();
                if (ps != null)
                    ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            if (out != null) {
                out.close();
            }
        }
    }
}
