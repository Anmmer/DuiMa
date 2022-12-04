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

/**
 * @description:
 * @author:
 * @createDate: 2022/1/13
 */
public class GetBuildNum extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String id = req.getParameter("id");
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
            String sql = "select a.planname,b.num from planname a left join (select count(*) num,planname from build_table where is_delete = 0 group by planname) b on a.planname = b.planname where isdelete = 0";
            String sql2 = "select count(*) as num from planname where isdelete = 0";
            if (planname != null && !"".equals(planname)) {
                sql += " and b.planname like  ?";
                sql2 += " and planname = ?";
                i++;
            }
            if (id != null && !"".equals(id)) {
                sql += " and id = ?";
                sql2 += " and id = ?";
                i++;
            }
            int j = i;
            sql += " limit ?,?";
            i += 2;
            ps = con.prepareStatement(sql);
            ps.setInt(i--, pageMax);
            ps.setInt(i--, (pageCur - 1) * pageMax);
            if (id != null && !"".equals(id)) {
                ps.setInt(i--, Integer.parseInt(id));
            }
            if (planname != null && !"".equals(planname)) {
                ps.setString(i, "%" + planname.trim() + "%");
            }
            ps2 = con.prepareStatement(sql2);
            if (id != null && !"".equals(id)) {
                ps2.setInt(j--, Integer.parseInt(id));
            }
            if (planname != null && !"".equals(planname)) {
                ps2.setString(j, "%" + planname.trim() + "%");
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
                map.put("num", rs.getString("num"));
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
