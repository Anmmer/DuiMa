import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class AddFactory extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String pid = request.getParameter("pid");
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "insert into warehouse(id,pid,name,type,create_date,is_delete,path) values(?,?,?,?,now(),0,?)";
            String sql2 = "select count(*) as num from warehouse where is_delete = 0 and name=? and type = ?";
            String sql3 = "select path  from warehouse where is_delete = 0 and id=?";
            ResultSet rs = null;
            if (!"3".equals(type)) {
                ps = con.prepareStatement(sql2);
                ps.setString(1, name);
                ps.setString(2, type);
                rs = ps.executeQuery();
                List<String> list = new ArrayList<>();
                int num = 0;
                while (rs.next()) {
                    num = rs.getInt("num");
                }
                if (num > 0) {
                    result.put("message", "录入信息已存在");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            ps = con.prepareStatement(sql3);
            ps.setString(1, pid);
            rs = ps.executeQuery();
            String path = null;
            while (rs.next()) {
                path = rs.getString("path");
            }
            ps = con.prepareStatement(sql);
            ps.setString(1, UUID.randomUUID().toString().toLowerCase().replace("-", ""));
            ps.setString(2, pid);
            ps.setString(3, name);
            ps.setString(4, type);
            ps.setString(5, (path == null ? "" : (path + "/")) + name);

            int i = ps.executeUpdate();
            if (i > 0) {
                result.put("message", "录入成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "录入失败");
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
