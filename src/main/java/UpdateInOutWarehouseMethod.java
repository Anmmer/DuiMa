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
import java.util.HashMap;
import java.util.Map;

public class UpdateInOutWarehouseMethod extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String name = req.getParameter("name");
        String isEffective = req.getParameter("isEffective");
        String id = req.getParameter("id");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "update in_out_warehouse_method set  ";
            if (name != null) {
                sql += "name = ?";
                if (isEffective != null) {
                    sql += ", ";
                }
            }
            if (isEffective != null) {
                sql += "is_effective = ?";
            }
            sql += "where id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            if (isEffective != null) {
                ps.setString(2, isEffective);
                ps.setString(3, id);
            } else {
                ps.setString(2, id);
            }
            int i = ps.executeUpdate();
            if (i > 0) {
                result.put("message", "修改成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "修改失败");
                result.put("flag", false);
                out.write(JSON.toJSONString(result));
            }
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