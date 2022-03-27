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
import java.util.HashMap;
import java.util.Map;

/**
 * @description:
 * @author:
 * @createDate: 2022/1/13
 */
public class DeletePlanName extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String id = req.getParameter("id");
        String planname = req.getParameter("planname");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbUtil.getCon();
            String sql = "update planname set isdelete = 1 where id = ?";
            String sql2 = "select count(1) num from plan where planname = ? and isdelete = 1";
            ps = con.prepareStatement(sql2);
            ps.setString(1, planname);
            rs = ps.executeQuery();
            int num = 0;
            while (rs.next()) {
                num = rs.getInt("num");
            }
            if (num != 0) {
                result.put("message", "项目名称正在使用，不能删除");
                result.put("flag", false);
                out.write(JSON.toJSONString(result));
                return;
            }
            ps = con.prepareStatement(sql);
            ps.setString(1, id);
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
