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
 * @createDate: 2022/5/11
 */
public class DeleteFailContent extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Integer id = null;
        if (request.getParameter("id") != null) {
            id = Integer.parseInt(request.getParameter("id"));
        }
        String index = request.getParameter("index");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            if ("1".equals(index)) {
                //删除分类
                String sql = "update inspect_fail_content set isdelete = '1' where id = ? or pid = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, id);
                ps.setInt(2, id);
                int i = ps.executeUpdate();
                if (i > 0) {
                    result.put("message", "删除成功");
                    result.put("flag", true);
                    out.write(JSON.toJSONString(result));
                } else {
                    result.put("message", "删除失败");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                }
            } else {
                //删除名称
                String sql = "update inspect_fail_content set isdelete = '1' where id = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, id);
                int i = ps.executeUpdate();
                if (i > 0) {
                    result.put("message", "删除成功");
                    result.put("flag", true);
                    out.write(JSON.toJSONString(result));
                } else {
                    result.put("message", "删除失败");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                }
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
