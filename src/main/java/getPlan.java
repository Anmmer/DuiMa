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

public class getPlan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        Connection con = null;
        try {
            PrintWriter out=resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select planid,planname,company,plant from plan";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            Map<String,List<Map<String,String>>> data = new HashMap<>();
            List<Map<String,String>> list = new ArrayList<>();
            while (!rs.next()) {
                Map<String,String> map = new HashMap<>();
                map.put("planname",rs.getString("planname"));
                map.put("company",rs.getString("company"));
                map.put("plant",rs.getString("plant"));
                list.add(map);
            }
            data.put("data",list);
            out.write(JSON.toJSONString(data));
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
