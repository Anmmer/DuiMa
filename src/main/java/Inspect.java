import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
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

public class Inspect extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String pids = req.getParameter("pids");
        String inspect_user = req.getParameter("inspect_user");
        JSONArray list = JSON.parseArray(pids);
        Connection con = null;
        PreparedStatement ps = null;
        Map<String, Object> map = new HashMap<>();
        StringBuilder sql = new StringBuilder("update preproduct set inspect = 1,inspect_user = ?,checktime=date_format(now(),'%Y-%m-%d'),stock_status = '0' where materialcode in (");
        if (list.size() == 1) {
            sql.append("?)");
        } else {
            for (int j = 0; j < list.size() - 1; j++) {
                sql.append("? , ");
            }
            sql.append("?)");
        }
        try {
            con = DbUtil.getCon();
            ps = con.prepareStatement(sql.toString());
            ps.setString(1, inspect_user);
            for (int j = 0; j < list.size(); j++) {
                ps.setString(j + 2, list.getString(j));
            }
            int i = ps.executeUpdate();
            if (i < 0) {
                map.put("flag", false);
                map.put("message", "质检失败");
            } else {
                map.put("flag", true);
                map.put("message", "质检成功");
            }
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            map.put("flag", false);
            map.put("message", "质检失败");
            out.write(JSON.toJSONString(map));
        } finally {
            try {
                con.close();
                out.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
