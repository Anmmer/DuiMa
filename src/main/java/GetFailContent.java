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

public class GetFailContent extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String classification = req.getParameter("classification");
        String pageCur_s = req.getParameter("pageCur");
        String pageMax_s = req.getParameter("pageMax");
        int pageCur = 0;
        if (pageCur_s != null) {
            pageCur = Integer.parseInt(pageCur_s);
        }
        int pageMax = 0;
        if (pageMax_s != null) {
            pageMax = Integer.parseInt(pageMax_s);
        }
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "select id,pid,classification,defect_name from inspect_fail_content where isdelete = '0' and pid != 0";
            String sql2 = "select count(*) as num from inspect_fail_content where isdelete = 0 ";
            int i = 0;
            int j = 0;
            if (classification != null && !"".equals(classification)) {
                sql += " and classification = ?";
                sql2 += " and classification = ?";
                i++;
            }
            if (pageCur != 0 && pageMax != 0) {
                sql += " limit ?,?";
                i += 2;
            }
            j = i;
            ps = con.prepareStatement(sql);
            if (pageCur != 0 && pageMax != 0) {
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);
            }
            if (classification != null && !"".equals(classification)) {
                ps.setString(i, classification);
            }
            ResultSet rs = ps.executeQuery();
            List<Map<String, Object>> list = new ArrayList<>();
            Map<String, Object> data = new HashMap<>();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("pid", rs.getInt("pid"));
                map.put("classification", rs.getString("classification"));
                map.put("defect_name", rs.getString("defect_name"));
                list.add(map);
            }
            if (pageCur != 0 && pageMax != 0) {
                PreparedStatement ps2 = con.prepareStatement(sql2);
                if (classification != null && !"".equals(classification)) {
                    ps2.setString(j, classification);
                }
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    int num = rs2.getInt("num");
                    data.put("cnt", num);
                    data.put("pageAll", Math.ceil((double) num / pageMax));
                }
            }
            data.put("data", list);
            out.write(JSON.toJSONString(data));
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
