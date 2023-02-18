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

public class GetProductionSummary extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String planname = req.getParameter("planname");
        int pageCur = Integer.parseInt(req.getParameter("pageCur"));
        int pageMax = Integer.parseInt(req.getParameter("pageMax"));
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        int i = 0;
        try {
            con = DbUtil.getCon();
            String sql = "SELECT\n" +
                    "\ta.planname,(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b  WHERE b.planname = a.planname and b.isdelete = 0 ) plannumber_sum,\n" +
                    "\t(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b LEFT JOIN plan c ON b.plannumber = c.plannumber WHERE c.planname = a.planname AND b.pourmade = 1 and b.product_delete = 0 ) pourmade_sum,\n" +
                    "\t(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b LEFT JOIN plan c ON b.plannumber = c.plannumber WHERE c.planname = a.planname AND b.inspect = 1 and b.product_delete = 0) inspect_sum,\n" +
                    "\t(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b LEFT JOIN plan c ON b.plannumber = c.plannumber WHERE c.planname = a.planname AND b.stock_status = '1' and b.product_delete = 0) stock_in_sum,\n" +
                    "\t(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b LEFT JOIN plan c ON b.plannumber = c.plannumber WHERE c.planname = a.planname AND b.stock_status = '2' and b.product_delete = 0) stock_out_sum, \n" +
                    "(select count(*) from preproduct c where c.planname = a.planname and c.inspect = 1 and c.product_delete = 0) finished_num,"+
                    "(select count(*) from preproduct c where c.planname = a.planname and c.product_delete = 0) all_num,"+
                    "(select count(*) from preproduct c where c.planname = a.planname and c.stock_status = 2 and c.product_delete = 0) out_num "+
                    "FROM planname a \n" +
                    "WHERE\n" +
                    "\ta.isdelete = 0";
            String sql2 = "select count(*) as num from planname where isdelete = 0";
            if (planname != null && !"".equals(planname)) {
                sql += " and planname = ?";
                sql2 += " and planname = ?";
                i++;
            }
            int j = i;
            sql += " limit ?,?";
            i += 2;
            ps = con.prepareStatement(sql);
            ps.setInt(i--, pageMax);
            ps.setInt(i--, (pageCur - 1) * pageMax);
            if (planname != null && !"".equals(planname)) {
                ps.setString(i, planname);
            }
            ps2 = con.prepareStatement(sql2);
            if (planname != null && !"".equals(planname)) {
                ps2.setString(j, planname);
            }
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                int num = rs2.getInt("num");
                result.put("cnt", num);
                int res_num;
                if (num % pageMax == 0) {
                    res_num = num / pageMax;
                } else {
                    res_num = num / pageMax + 1;
                }
                result.put("pageAll", res_num);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("planname", rs.getString("planname"));
                map.put("plannumber_sum", rs.getString("plannumber_sum"));
                map.put("pourmade_sum", rs.getString("pourmade_sum"));
                map.put("inspect_sum", rs.getString("inspect_sum"));
                map.put("stock_in_sum", rs.getString("stock_in_sum"));
                map.put("stock_out_sum", rs.getString("stock_out_sum"));
                map.put("finished_num", rs.getString("finished_num"));
                map.put("all_num", rs.getString("all_num"));
                map.put("out_num", rs.getString("out_num"));
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
                if (ps2 != null)
                    ps2.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
