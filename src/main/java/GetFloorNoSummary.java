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

public class GetFloorNoSummary extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String buildingNo = req.getParameter("buildingNo");
        String floorNo = req.getParameter("floorNo");
        String planname = req.getParameter("planname");
        int pageCur = Integer.parseInt(req.getParameter("pageCur"));
        int pageMax = Integer.parseInt(req.getParameter("pageMax"));
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        if (planname == null || buildingNo == null) {
            result.put("message", "参数不全");
            result.put("flag", false);
            out.write(JSON.toJSONString(result));
            return;
        }
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        int i = 1;
        try {
            con = DbUtil.getCon();
            String sql = "SELECT\n" +
                    "\ta.floor_no,(SELECT concat_ws( '/',concat(count(*), '件'), concat(sum( fangliang ), '方量') ) FROM preproduct b WHERE b.floor_no = a.floor_no AND b.planname = ? and b.building_no = ? and b.isdelete = 0  ) floor_no_sum,\n" +
                    "\t(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b left join plan c on b.plannumber = c.plannumber WHERE b.floor_no = a.floor_no AND c.planname = ? AND b.building_no = ? and  b.pourmade = 1 and b.isdelete = 0  ) pourmade_sum,\n" +
                    "\t(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b left join plan c on b.plannumber = c.plannumber WHERE b.floor_no = a.floor_no AND c.planname = ? AND b.building_no = ? and b.inspect = 1 and b.isdelete = 0 ) inspect_sum,\n" +
                    "\t(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b left join plan c on b.plannumber = c.plannumber WHERE b.floor_no = a.floor_no AND c.planname = ? AND b.building_no = ? and b.stock_status = '1' and b.isdelete = 0 ) stock_in_sum,\n" +
                    "\t(SELECT concat( count(*), '件/', sum( fangliang ), '方量' ) FROM preproduct b left join plan c on b.plannumber = c.plannumber WHERE b.floor_no = a.floor_no AND c.planname = ? AND b.building_no = ? and b.stock_status = '2' and b.isdelete = 0 ) stock_out_sum \n" +
                    "FROM\n" +
                    "( SELECT floor_no FROM preproduct b  WHERE b.planname = ?  GROUP BY floor_no ) a";
            String sql2 = "select count(*) as num from (SELECT floor_no FROM preproduct b  WHERE b.planname = ? ";
            if (floorNo != null && !"".equals(floorNo)) {
                sql += " where floor_no = ?";
                sql2 += " and floor_no = ?";
                i++;
            }
            sql2 += "GROUP BY floor_no) a";
            int j = i;
            sql += " limit ?,?";
            i += 12;
            ps = con.prepareStatement(sql);
            ps.setInt(i--, pageMax);
            ps.setInt(i--, (pageCur - 1) * pageMax);
            if (floorNo != null && !"".equals(floorNo)) {
                ps.setString(i--, floorNo);
            }
            ps.setString(i--, planname);
            ps.setString(i--, buildingNo);
            ps.setString(i--, planname);
            ps.setString(i--, buildingNo);
            ps.setString(i--, planname);
            ps.setString(i--, buildingNo);
            ps.setString(i--, planname);
            ps.setString(i--, buildingNo);
            ps.setString(i--, planname);
            ps.setString(i--, buildingNo);
            ps.setString(i, planname);
            ps2 = con.prepareStatement(sql2);
            if (floorNo != null && !"".equals(floorNo)) {
                ps2.setString(j--, floorNo);
            }
            ps2.setString(j, planname);
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
                map.put("floor_no", rs.getString("floor_no"));
                map.put("floor_no_sum", rs.getString("floor_no_sum"));
                map.put("pourmade_sum", rs.getString("pourmade_sum"));
                map.put("inspect_sum", rs.getString("inspect_sum"));
                map.put("stock_in_sum", rs.getString("stock_in_sum"));
                map.put("stock_out_sum", rs.getString("stock_out_sum"));
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
