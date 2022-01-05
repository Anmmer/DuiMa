import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
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

public class DeletePlan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String plannumbers = req.getParameter("plannumbers");
        JSONArray jsonArray = JSONObject.parseArray(plannumbers);
        Connection con = null;
        PreparedStatement ps = null;
        PrintWriter out = resp.getWriter();
        StringBuilder sql = new StringBuilder("update plan set isdelete = 1 where plannumber in (");
        if (jsonArray.size() == 1) {
            sql.append("?)");
        } else {
            for (int j = 0; j < jsonArray.size() - 1; j++) {
                sql.append("? , ");
            }
            sql.append("?)");
        }
        Map<String, Object> map = new HashMap<>();
        try {
            con = DbUtil.getCon();
            ps = con.prepareStatement(sql.toString());
            for (int j = 0; j < jsonArray.size(); j++) {
                ps.setInt(j + 1, Integer.parseInt((String) jsonArray.get(j)));
            }
            int i = ps.executeUpdate();
            if (i < 0) {
                map.put("flag", false);
                map.put("message", "删除失败");
            } else {
                map.put("flag", true);
                map.put("message", "删除成功");
            }
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
                ps.close();
                out.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
