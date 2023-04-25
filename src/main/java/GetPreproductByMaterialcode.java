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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GetPreproductByMaterialcode extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        Connection con = null;
        String json = req.getParameter("materialcodes");
        JSONArray jsonArray = JSON.parseArray(json);
        try {
            PrintWriter out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select materialcode,materialname,standard,drawing_no,build_type,building_no,floor_no,fangliang from preproduct where materialcode = ? and isdelete = 0";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = null;
            Map<String, Object> result = new HashMap<>();
            List<Map<String, Object>> list = new ArrayList<>();
            for (Object o : jsonArray) {
                String jsonObject = (String) o;
                ps.setString(1, jsonObject);
                rs = ps.executeQuery();
                if (!rs.next()) {
                    result.put("flag", false);
                    result.put("message", "物料编码为：" + jsonObject + " 的构件未上传BOM信息！");
                    out.write(JSON.toJSONString(result));
                    return;
                }
                Map<String, Object> map = new HashMap<>();
                map.put("materialcode", rs.getString("materialcode"));
                map.put("standard", rs.getString("standard"));
                map.put("materialname", rs.getString("materialname"));
                map.put("fangliang", rs.getBigDecimal("fangliang"));
                map.put("drawing_no", rs.getString("drawing_no"));
                map.put("building_no", rs.getString("building_no"));
                map.put("floor_no", rs.getString("floor_no"));
                map.put("build_type", rs.getString("build_type"));
                list.add(map);
            }
            result.put("flag", true);
            result.put("data", list);
            out.write(JSON.toJSONString(result));
            ps.close();
            if (rs != null) {
                rs.close();
            }
            out.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }

        }
    }
}
