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

public class GetBatchDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String batch_id = req.getParameter("batch_id");
        int pageCur = Integer.parseInt(req.getParameter("pageCur"));
        int pageMax = Integer.parseInt(req.getParameter("pageMax"));
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        try {
            con = DbUtil.getCon();
            String sql = "select materialcode,materialname,standard,drawing_no,build_type,building_no,floor_no,fangliang from preproduct where isdelete = 0 and batch_id = ? ";
            String sql2 = "select count(*) as num from preproduct where isdelete = 0 and batch_id = ?";
            sql += " limit ?,?";
            ps = con.prepareStatement(sql);
            ps.setString(1, batch_id);
            ps.setInt(3, pageMax);
            ps.setInt(2, (pageCur - 1) * pageMax);
            ps2 = con.prepareStatement(sql2);
            ps2.setString(1, batch_id);
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
                map.put("fangliang", rs.getString("fangliang"));
                map.put("floor_no", rs.getString("floor_no"));
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
