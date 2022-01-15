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
public class GetPlant extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String id = req.getParameter("id");
        String plant = req.getParameter("plant");
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        int i = 0;
        try {
            con = DbUtil.getCon();
            String sql = "select plant,id from plant where isdelete = 0";
            if (plant != null && !"".equals(plant)) {
                sql += " and plant = ?";
                i++;
            }
            if (id != null && !"".equals(id)) {
                sql += " and id = ?";
                i++;
            }
            ps = con.prepareStatement(sql);
            if (id != null && !"".equals(id)) {
                ps.setInt(i--, Integer.parseInt(id));
            }
            if (plant != null && !"".equals(plant)) {
                ps.setString(i, plant);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("plant", rs.getString("plant"));
                map.put("id", rs.getString("id"));
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
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}