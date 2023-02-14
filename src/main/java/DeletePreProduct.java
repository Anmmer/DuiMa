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
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

public class DeletePreProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String pids = req.getParameter("pids");
        String plannumber = req.getParameter("plannumber");
        String fangliang = req.getParameter("fangliang");
        JSONArray jsonArray = JSONObject.parseArray(pids);
        Connection con = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;
        PrintWriter out = resp.getWriter();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        StringBuilder sql1 = new StringBuilder("update preproduct set product_delete = 1,print = 0 where pid in (");
        String sql2 = "update plan set tasknum = tasknum - ? , tasksqure = tasksqure - ? where plannumber = ?";
        StringBuilder sql3 = new StringBuilder("update plan set updatedate = ?");
        if (jsonArray.size() == 1) {
            sql1.append("?)");
        } else {
            for (int j = 0; j < jsonArray.size() - 1; j++) {
                sql1.append("? , ");
            }
            sql1.append("?)");
        }

        Map<String, Object> map = new HashMap<>();
        try {
            con = DbUtil.getCon();
            ps1 = con.prepareStatement(sql1.toString());
            ps2 = con.prepareStatement(sql2);
            ps2.setInt(1, jsonArray.size());
            ps2.setBigDecimal(2, new BigDecimal(fangliang));
            ps2.setString(3, plannumber);
            for (int j = 0; j < jsonArray.size(); j++) {
                ps1.setInt(j + 1, jsonArray.getInteger(j));
            }
            int i = ps1.executeUpdate();
            ps2.executeUpdate();
//            if (PrintPreProduct.getPrintState(plannumber)) {
//                sql3.append(",printstate = 1");
//            } else {
//                sql3.append(",printstate = 0");
//            }
            sql3.append(" where plannumber = ?");
            ps3 = con.prepareStatement(sql3.toString());
            ps3.setDate(1, new Date(new java.util.Date().getTime()));
            ps3.setString(2, plannumber);
            ps3.executeUpdate();
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
                ps1.close();
                ps2.close();
                out.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
