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
 * @createDate: 2022/1/13
 */
public class UpdateLine extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String id = req.getParameter("id");
        String line = req.getParameter("line");
        String line_old = req.getParameter("line_old");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "update line set line = ? where id = ? and isdelete = 0";
            String sql2 = "update plan set line = ? where line = ? and isdelete = 0";
            ps = con.prepareStatement(sql);
            ps.setString(1, line);
            ps.setInt(2, Integer.parseInt(id));
            int i = ps.executeUpdate();
            ps = con.prepareStatement(sql2);
            ps.setString(1,line);
            ps.setString(2,line_old);
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

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
            try {
                if (con != null)
                    con.close();
                if (ps!=null)
                    ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
