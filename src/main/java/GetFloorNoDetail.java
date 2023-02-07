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

public class GetFloorNoDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String planname = req.getParameter("planname");
        String building_no = req.getParameter("building_no");
        String floor_no = req.getParameter("floor_no");
        int pageCur = Integer.parseInt(req.getParameter("pageCur"));
        int pageMax = Integer.parseInt(req.getParameter("pageMax"));
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        try {
            con = DbUtil.getCon();
            String sql = "select a.materialcode,a.materialname,a.standard,a.drawing_no,a.build_type,a.building_no,a.floor_no, a.pourmade,a.inspect,a.stock_status from preproduct a left join plan b on a.plannumber = b.plannumber where a.product_delete = 0 and a.building_no = ? and a.floor_no = ? and a.planname = ? ";
            String sql2 = "select count(*) as num from preproduct a left join plan b on a.plannumber = b.plannumber where a.product_delete = 0 and a.building_no = ? and a.floor_no = ? and a.planname = ? ";
            sql += " limit ?,?";
            ps = con.prepareStatement(sql);
            ps.setString(1, building_no);
            ps.setString(2, floor_no);
            ps.setString(3, planname);
            ps.setInt(5, pageMax);
            ps.setInt(4, (pageCur - 1) * pageMax);
            ps2 = con.prepareStatement(sql2);
            ps2.setString(1, building_no);
            ps2.setString(2, floor_no);
            ps2.setString(3, planname);
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
                map.put("materialcode", rs.getString("materialcode"));
                map.put("materialname", rs.getString("materialname"));
                map.put("standard", rs.getString("standard"));
                map.put("drawing_no", rs.getString("drawing_no"));
                map.put("build_type", rs.getString("build_type"));
                map.put("building_no", rs.getString("building_no"));
                map.put("floor_no", rs.getString("floor_no"));
                map.put("pourmade", rs.getString("pourmade"));
                map.put("inspect", rs.getString("inspect"));
                map.put("stock_status", rs.getString("stock_status"));
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
