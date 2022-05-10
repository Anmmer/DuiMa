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
 * @createDate: 2022/5/9
 */
public class AddFailContent extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String defect_name = request.getParameter("defect_name");
        String classification = request.getParameter("classification");
        Integer pid = null;
        if (request.getParameter("pid") != null) {
            pid = Integer.parseInt(request.getParameter("pid"));
        }
        String index = request.getParameter("index");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        try {
            con = DbUtil.getCon();
            if ("1".equals(index)) {
                //添加缺陷名称
                String sql = "insert into inspect_fail_content(pid,classification,defect_name,isdelete) values(?,?,?,0)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, pid);
                ps.setString(2, classification);
                ps.setString(3, defect_name);
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
            } else {
                //添加分类
                String sql = "insert into inspect_fail_content(pid,classification,isdelete) values(?,?,0)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, 0);
                ps.setString(2, classification);
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
