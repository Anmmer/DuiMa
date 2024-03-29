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
public class AddPlanName extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String planname = req.getParameter("planname");
        String unit_consumption = req.getParameter("unit_consumption");
        String customer_name = req.getParameter("customer_name");
        String contact_name = req.getParameter("contact_name");
        String address = req.getParameter("address");
        String material_receiver = req.getParameter("material_receiver");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        try {
            con = DbUtil.getCon();
            String sql = "insert into planname(planname,unit_consumption,customer_name,contact_name,address,material_receiver,create_time,isdelete) values(?,?,?,?,?,?,now(),0)";
            String sql2 = "select planname from planname where isdelete = 0";
            ps = con.prepareStatement(sql);
            ps.setString(1, planname.trim());
            ps.setString(2, unit_consumption.trim());
            ps.setString(3, customer_name.trim());
            ps.setString(4, contact_name.trim());
            ps.setString(5, address.trim());
            ps.setString(6, material_receiver.trim());
            ps2 = con.prepareStatement(sql2);
            ResultSet rs = ps2.executeQuery();
            List<String> list = new ArrayList<>();
            while (rs.next()) {
                list.add(rs.getString("planname"));
            }
            for (String str : list) {
                if (str.equals(planname)) {
                    result.put("message", "项目信息重复");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            int i = ps.executeUpdate();
            if (i > 0) {
                result.put("message", "录入成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "录入成功");
                result.put("flag", true);
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
