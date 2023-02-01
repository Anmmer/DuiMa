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
import java.util.*;

/**
 * @description:
 * @author:
 * @createDate: 2023/2/1
 */
public class SavePrintObj extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String index = req.getParameter("index");
        String str = req.getParameter("str");
        String type = req.getParameter("type"); // 1:查询，2：新增，
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        int i = 0;
        int j = 0;
        try {
            con = DbUtil.getCon();
            String sql1 = "select print_obj,index from cement_type where index = ?";
            String sql2 = "insert into print_obj values(?,?,now())";
            String sql3 = "update default_qc set qc_id = ? where id = 3";
            if ("1".equals(type)) {
                ps = con.prepareStatement(sql1);
                ps.setString(1, index);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("index"));
                    map.put("id", rs.getString("print_obj"));
                    list.add(map);
                }
                result.put("data", list);
            }
            if ("2".equals(type)) {
                String id = UUID.randomUUID().toString().toLowerCase().replace("-", "");
                ps = con.prepareStatement(sql3);
                ps.setString(1, id);
                ps.executeUpdate();
                ps = con.prepareStatement(sql2);
                ps.setString(1, id);
                ps.setString(2, str);
                if (ps.executeUpdate() > 0) {
                    result.put("message", "录入成功");
                    result.put("flag", true);
                } else {
                    result.put("message", "录入失败");
                    result.put("flag", true);
                }
            }
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
