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
 * @createDate: 2021/12/20
 */
public class GetPreProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String plannumber = req.getParameter("plannumber");
        Connection con = null;
        int i = 0;
        try {
            PrintWriter out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select pid,materialcode,preproductid,standard,materialname,weigh,qc,fangliang,plannumber,print,concretegrade from preproduct where isdelete = 0 ";
            if (plannumber != null && !"".equals(plannumber)) {
                sql += "and plannumber = ?";
            }
            PreparedStatement ps = con.prepareStatement(sql);
            if (plannumber != null && !"".equals(plannumber)) {
                ps.setString(1, plannumber);
            }
            ResultSet rs = ps.executeQuery();
            Map<String, List<Map<String, Object>>> data = new HashMap<>();
            List<Map<String, Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("pid", rs.getInt("pid"));
                map.put("materialcode", rs.getString("materialcode"));
                map.put("preproductid", rs.getString("preproductid"));
                map.put("standard", rs.getString("standard"));
                map.put("materialname", rs.getString("materialname"));
                map.put("weigh", rs.getBigDecimal("weigh"));
                map.put("qc", rs.getString("qc"));
                map.put("fangliang", rs.getBigDecimal("fangliang"));
                map.put("concretegrade", rs.getString("concretegrade"));
                map.put("print", rs.getInt("print"));
                map.put("plannumber", rs.getString("plannumber"));
                list.add(map);
            }
            data.put("data", list);
            out.write(JSON.toJSONString(data));
            ps.close();
            rs.close();
            out.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }
    }
}
