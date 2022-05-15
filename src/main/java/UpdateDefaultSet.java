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
 * @createDate: 2022/5/15
 */
public class UpdateDefaultSet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String name = req.getParameter("name");
        String on_or_off = req.getParameter("on_or_off");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "update default_set set on_or_off = ? where name = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1,on_or_off);
            ps.setString(2,name);
            int i = ps.executeUpdate();
            if (i > 0) {
                result.put("message", "开启隐蔽检验成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "开启隐蔽检验失败");
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
