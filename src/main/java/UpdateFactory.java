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

public class UpdateFactory extends HttpServlet {
    public static int update(Connection con, String id) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = null;
        con = DbUtil.getCon();
        String sql = "update warehouse set path=? where id = ?";
        String sql2 = "select path,name,pid  from warehouse where is_delete = 0 and id=?";
        ps = con.prepareStatement(sql2);
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        String name = null;
        String pid = null;
        String path = null;
        while (rs.next()) {
            path = rs.getString("path");
            name = rs.getString("name");
            pid = rs.getString("pid");
        }
        ps = con.prepareStatement(sql2);
        ps.setString(1, pid);
        rs = ps.executeQuery();
        String pre_path = null;
        while (rs.next()) {
            pre_path = rs.getString("path");
        }
        ps = con.prepareStatement(sql);
        ps.setString(1, (path == null ? "" : (pre_path + "/")) + name);
        ps.setString(2, id);
        int i = ps.executeUpdate();
        return i;
    }

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
        String pid = req.getParameter("pid");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "update warehouse set name = ?,path=? where id = ?";
            String sql2 = "select path,type  from warehouse where is_delete = 0 and id=?";
            String sql3 = "WITH recursive temp AS (\n" +
                    "\t\tSELECT\n" +
                    "\t\t\tid,\n" +
                    "\t\t\tpid \n" +
                    "\t\tFROM\n" +
                    "\t\t\twarehouse p \n" +
                    "\t\tWHERE\n" +
                    "\t\t\tid = ? UNION\n" +
                    "\t\tSELECT\n" +
                    "\t\t\tt.id,\n" +
                    "\t\t\tt.pid \n" +
                    "\t\tFROM\n" +
                    "\t\t\twarehouse t\n" +
                    "\t\t\tINNER JOIN temp t2 ON t2.id = t.pid \n" +
                    "\t\t) SELECT\n" +
                    "\t\tid \n" +
                    "FROM\n" +
                    "\ttemp";
            ps = con.prepareStatement(sql2);
            ps.setString(1, pid);
            ResultSet rs = ps.executeQuery();
            String path = null;
            String type = null;
            while (rs.next()) {
                path = rs.getString("path");
                type = rs.getString("type");
            }
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, (path == null ? "" : (path + "/")) + name);
            ps.setString(3, id);
            int i = ps.executeUpdate();
            ps = con.prepareStatement(sql3);
            ps.setString(1, id);
            rs = ps.executeQuery();
            List<String> list = new ArrayList<>();
            while (rs.next()) {
                list.add(rs.getString("id"));
            }
            for (int i1 = 1; i1 < list.size(); i1++) {
                UpdateFactory.update(con, list.get(i1));
            }
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
