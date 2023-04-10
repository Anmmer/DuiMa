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
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * @description:
 * @author:
 * @createDate: 2022/1/13
 */
public class UpdatePlanName extends HttpServlet {
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
        String customer_name = req.getParameter("customer_name");
        String material_receiver = req.getParameter("material_receiver");
        String contact_name = req.getParameter("contact_name");
        String address = req.getParameter("address");
        String planname_old = req.getParameter("planname_old");
        String unit_consumption = req.getParameter("unit_consumption");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "update planname set planname = ?,unit_consumption=?,customer_name=?,contact_name=?,address=?,material_receiver=? where id = ? and isdelete = 0";
            String sql2 = "update plan set planname = ? where planname = ? and isdelete = 0";
            String sql3 = "update preproduct set planname = ? where planname = ? and isdelete = 0";
            ps = con.prepareStatement(sql2);
            ps.setString(1, planname.trim());
            ps.setString(2, planname_old.trim());
            ps.executeUpdate();
            ps = con.prepareStatement(sql);
            ps.setString(1, planname.trim());
            ps.setString(2, unit_consumption.trim());
            ps.setString(3, customer_name.trim());
            ps.setString(4, contact_name.trim());
            ps.setString(5, address.trim());
            ps.setString(6, material_receiver.trim());
            ps.setInt(7, Integer.parseInt(id));
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
            ps = con.prepareStatement(sql3);
            ps.setString(1, planname.trim());
            ps.setString(2, planname_old.trim());
            ps.executeUpdate();

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
