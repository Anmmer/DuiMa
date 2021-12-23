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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * @description:
 * @author:
 * @createDate: 2021/12/21
 */
public class PrintPreProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String preProductIds = req.getParameter("productIds");
        JSONArray jsonArray = JSONObject.parseArray(preProductIds);
        Connection con = null;
        PreparedStatement ps = null;
        PrintWriter out = resp.getWriter();
        String sql = "update preproduct set print = print +1 where pid = ?";
        Map<String, Object> map = new HashMap<>();
        try {
            con = DbUtil.getCon();
            ps = con.prepareStatement(sql);
            for (Object o : jsonArray) {
                JSONObject jsonObject = (JSONObject) o;
                ps.setInt(1, Integer.parseInt(jsonObject.getString("pid")));
                ps.addBatch();
            }
            int[] is = ps.executeBatch();
            if (is.length < 1)
                map.put("flag", false);
            else
                map.put("flag", true);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
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
