import com.alibaba.fastjson.JSON;
import com.example.DbUtil;
import domain.Warehouse;

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

public class GetFactory extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        Connection con = null;
        PreparedStatement ps = null;
        try (PrintWriter out = response.getWriter()) {
            Map<String, Object> result = new HashMap<>();
            String type = request.getParameter("type");
            String pid = request.getParameter("pid");
            con = DbUtil.getCon();
            int i = 0;
            String sql1 = "select id,pid,name,type from warehouse where is_delete = '0' ";
            List<Warehouse> list = new ArrayList<>();
            if (type != null && !type.equals("")) {
                sql1 += " and type = ?";
                i++;
            }
            if (pid != null && !pid.equals("")) {
                sql1 += " and pid = ?";
                i++;
            }
            ps = con.prepareStatement(sql1);
            if (pid != null && !pid.equals("")) {
                ps.setString(i--, pid);
            }
            if (type != null && !type.equals("")) {
                ps.setString(i, type);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Warehouse warehouse = new Warehouse();
                warehouse.setId(rs.getString("id"));
                warehouse.setPid(rs.getString("pid"));
                warehouse.setName(rs.getString("name"));
                warehouse.setType(rs.getString("type"));
                list.add(warehouse);
            }
            if (type != null && !type.equals("")) {
                result.put("data", list);
            } else {
                List<Warehouse> list1 = Warehouse.build(list, "0");
                result.put("data", list1);
            }
            out.write(JSON.toJSONString(result));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                assert con != null;
                con.close();
                assert ps != null;
                ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
