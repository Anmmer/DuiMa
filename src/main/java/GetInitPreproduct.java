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
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author:
 * @createDate: 2023/3/25
 */
public class GetInitPreproduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String materialcode = req.getParameter("materialcode");
        Connection con = null;
        Map<String, Object> data = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            PrintWriter out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select materialcode,materialname from preproduct where materialcode = ? and isdelete = 0";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, materialcode);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("materialcode", rs.getString("materialcode"));
                map.put("materialname", rs.getString("materialname"));
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
