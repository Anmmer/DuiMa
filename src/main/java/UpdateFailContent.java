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
 * @createDate: 2022/5/9
 */
public class UpdateFailContent extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String defect_name = request.getParameter("defect_name");
        String classification = request.getParameter("classification");
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
                //修改缺陷名称
                String sql = "update inspect_fail_content set defect_name = ? where id = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(2, id);
                ps.setString(1, defect_name);
                int i = ps.executeUpdate();
                if (i > 0) {
                    result.put("message", "修改成功");
                    result.put("flag", true);
                    out.write(JSON.toJSONString(result));
                } else {
                    result.put("message", "修改失败");
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                }
            } else {
                //修改分类
                String sql1 = "update inspect_fail_content set classification = ? where id = ?";
                String sql2 = "update inspect_fail_content set classification = ? where pid = ?";
                ps = con.prepareStatement(sql1);
                ps.setString(1, classification);
                ps.setInt(2, id);
                int i = ps.executeUpdate();
                ps = con.prepareStatement(sql2);
                ps.setString(1, classification);
                ps.setInt(2, id);
                ps.executeUpdate();
                if (i > 0) {
                    result.put("message", "修改成功");
                    result.put("flag", true);
                    out.write(JSON.toJSONString(result));
                } else {
                    result.put("message", "修改失败");
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
