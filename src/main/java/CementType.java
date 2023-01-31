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

public class CementType extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String name = req.getParameter("name");
        String id = req.getParameter("id");
        String type = req.getParameter("type"); // 1:查询，2：新增，3：修改，4：删除
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        int i = 0;
        int j = 0;
        try {
            con = DbUtil.getCon();
            String sql1 = "select name,id from cement_type where is_effective = 1";
            String sql1_page = "select count(*) as num from cement_type where is_effective = 1";
            String sql2 = "insert into cement_type values(?,?,now(),'1')";
            String sql3 = "update cement_type set ";
            if ("1".equals(type)) {
                int pageCur = Integer.parseInt(req.getParameter("pageCur"));
                int pageMax = Integer.parseInt(req.getParameter("pageMax"));
                if (name != null && !"".equals(name)) {
                    sql1 += " and name = ?";
                    sql1_page += " and name = ?";
                    i++;
                }
                j = i;
                sql1 += " limit ?,?";
                i += 2;
                ps = con.prepareStatement(sql1);
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);
                if (name != null && !"".equals(name)) {
                    ps.setString(i, name);
                }
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("name", rs.getString("name"));
                    map.put("id", rs.getString("id"));
                    list.add(map);
                }
                result.put("data", list);
                ps = con.prepareStatement(sql1_page);
                if (name != null && !"".equals(name)) {
                    ps.setString(j, name);
                }
                ResultSet rs2 = ps.executeQuery();
                while (rs2.next()) {
                    int num = rs2.getInt("num");
                    int res_num;
                    if (num % pageMax == 0) {
                        res_num = num / pageMax;
                    } else {
                        res_num = num / pageMax + 1;
                    }
                    result.put("cnt", num);
                    result.put("pageAll", res_num);
                }
            }
            if ("2".equals(type)) {
                ps = con.prepareStatement(sql2);
                ps.setString(1, UUID.randomUUID().toString().toLowerCase().replace("-", ""));
                ps.setString(2, name);
                if (ps.executeUpdate() > 0) {
                    result.put("message", "录入成功");
                    result.put("flag", true);
                } else {
                    result.put("message", "录入失败");
                    result.put("flag", true);
                }
            }
            if ("3".equals(type)) {
                sql3 = sql3 + "name = ? where id = ?";
                ps = con.prepareStatement(sql3);
                ps.setString(1, name);
                ps.setString(2, id);
                if (ps.executeUpdate() > 0) {
                    result.put("message", "修改成功");
                    result.put("flag", true);
                } else {
                    result.put("message", "修改失败");
                    result.put("flag", true);
                }
            }
            if ("4".equals(type)) {
                sql3 = sql3 + "is_effective = 0 where id = ?";
                ps = con.prepareStatement(sql3);
                ps.setString(1, id);
                if (ps.executeUpdate() > 0) {
                    result.put("message", "删除成功");
                    result.put("flag", true);
                } else {
                    result.put("message", "删除失败");
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
