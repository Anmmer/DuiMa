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
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class InspectNo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String pids = req.getParameter("pids");
        String failure_reason = req.getParameter("failure_reason");
        String patch_library = req.getParameter("patch_library");
        String inspect_remark = req.getParameter("inspect_remark");
        String inspect_user = req.getParameter("inspect_user");
        JSONArray list = JSON.parseArray(pids);
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        Map<String, Object> map = new HashMap<>();
        StringBuilder sql = new StringBuilder("update preproduct set inspect = 2,stock_status = '0',checktime=date_format(now(),'%Y-%m-%d'), failure_reason = ?, patch_library = ?, inspect_remark=?, inspect_user=?  where materialcode in (");
        String sql3 = "insert into  warehouse_info_log(warehouse_info_id,create_date,user_name,type,in_warehouse_id,out_warehouse_id,materialcode,method) values(?,now(),?,?,?,?,?,?)";
        String sql2 = "select materialcode from preproduct where materialcode = ?";
        if (list.size() == 1) {
            sql.append("?)");
        } else {
            for (int j = 0; j < list.size() - 1; j++) {
                sql.append("? , ");
            }
            sql.append("?)");
        }
//        if (failure_reason == null) {
//            map.put("flag", false);
//            map.put("message", "请选择不合格原因");
//            out.write(JSON.toJSONString(map));
//            return;
//        }
        try {
            con = DbUtil.getCon();
            ps = con.prepareStatement(sql.toString());
            ps.setString(1, failure_reason);
            ps.setString(2, patch_library);
            ps.setString(3, inspect_remark);
            ps.setString(4, inspect_user);
            for (int j = 0; j < list.size(); j++) {
                ps.setString(j + 5, list.getString(j));
                ps2 = con.prepareStatement(sql2);
                ps2.setString(1, list.getString(j));
                ResultSet rs = ps2.executeQuery();
                String materialcode = null;
                while (rs.next()) {
                    materialcode = rs.getString("materialcode");
                }
                ps2 = con.prepareStatement(sql3);
                ps2.setString(1, UUID.randomUUID().toString().toLowerCase().replace("-", ""));
                ps2.setString(2, inspect_user);
                ps2.setString(3, "1");
                ps2.setString(4, "000000002");
                ps2.setString(5, null);
                ps2.setString(6, materialcode);
                ps2.setString(7, "修补入库");
                int i = ps2.executeUpdate();
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
