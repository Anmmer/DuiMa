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
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PrintWriter out = resp.getWriter();
        String sql3 = "select materialcode from preproduct where (pourmade = 1 or stock_status > 0) and plannumber in ( ";
        StringBuilder sql_plan = new StringBuilder("update plan set isdelete = 1 where plannumber in (");
        StringBuilder sql_pre = new StringBuilder("update preproduct set product_delete = 1 where plannumber in (");
        if (jsonArray.size() == 1) {
            sql_plan.append("?)");
            sql_pre.append("?)");
            sql3 += "?)";
        } else {
            for (int j = 0; j < jsonArray.size() - 1; j++) {
                sql_plan.append("? , ");
                sql_pre.append("? , ");
                sql3 += "? , ";
            }
            sql_plan.append("?)");
            sql_pre.append("?)");
            sql3 += "?)";
        }
        Map<String, Object> map = new HashMap<>();
        try {
            con = DbUtil.getCon();
            ps1 = con.prepareStatement(sql3);
            for (int j = 0; j < jsonArray.size(); j++) {
                ps1.setString(j + 1, jsonArray.getString(j));
            }
            ResultSet rs = ps1.executeQuery();
            while (rs.next()) {
                String materialcode = rs.getString("materialcode");
                map.put("message", "物料编码为：" + materialcode + "的构建已生产，不能删除");
                map.put("flag", false);
                out.write(JSON.toJSONString(map));
                return;
            }
            ps1 = con.prepareStatement(sql_plan.toString());
            ps2 = con.prepareStatement(sql_pre.toString());
            for (int j = 0; j < jsonArray.size(); j++) {
                ps1.setString(j + 1, jsonArray.getString(j));
                ps2.setString(j + 1, jsonArray.getString(j));
            }
            int i = ps1.executeUpdate();
            ps2.executeUpdate();
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
                if (ps1 != null) {
                    ps1.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                out.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
